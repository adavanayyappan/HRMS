//
//  IdentifyCameraViewController.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 18/07/24.
//

import UIKit
import AVFoundation
import Vision
import Combine
import CoreLocation
import SwiftUICore

struct PunchModel: Codable {
    let status: String
    let message: String
    let satrtTime: String
    let endTime: String
}

protocol IdentifyCameraViewControllerDelegate: AnyObject {
    func navigateToNextViewController()
}

class IdentifyCameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, CLLocationManagerDelegate {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    private let faceNet = MobileFaceNet()
    public var THRESHOLD: Float = 0.8;
    
    private let locationManager = CLLocationManager()
    private var cancellables = Set<AnyCancellable>()
    
    private var serverImageUrl = "\(Constants.imageURL)"
    private var imagePath: String = AppStorageManager.value(forKey: AppStorageKeys.KEY_EMP_IMAGE, defaultValue: "")
    var latitude: String = ""
    var longitude: String = ""
    var serverImage: UIImage? = nil
    
    let changeButton = UIButton(type: .system)
    weak var delegate: IdentifyCameraViewControllerDelegate?
    private var hasPostedPunch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupButton()
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let videoCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        } else {
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        view.bringSubviewToFront(changeButton)
       
        
        serverImageUrl = Constants.imageURL.rawValue + imagePath
        fetchServerImage()
        
        // Set the delegate
        locationManager.delegate = self
        
        // Check the current authorization status
        let authorizationStatus = locationManager.authorizationStatus
        
        if authorizationStatus == .notDetermined {
            // Request location permissions
            locationManager.requestWhenInUseAuthorization()
        } else {
            // Handle the current authorization status
            handleAuthorizationStatus(authorizationStatus)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DispatchQueue.global(qos: .userInitiated).async {
            if !self.captureSession.isRunning {
                self.captureSession.startRunning()
            }
        }
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DispatchQueue.global(qos: .userInitiated).async {
            if self.captureSession.isRunning {
                self.captureSession.stopRunning()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        DispatchQueue.global(qos: .userInitiated).async {
            if self.captureSession.isRunning {
                self.captureSession.stopRunning()
            }
        }
    }


    
    func setupButton() {
        // Add a button to capture image
        changeButton.setTitle("Change Face", for: .normal)
        changeButton.addTarget(self, action: #selector(captureButtonTapped), for: .touchUpInside)
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        changeButton.backgroundColor = .primarycolor
        changeButton.tintColor = .white
        view.addSubview(changeButton)
        
        NSLayoutConstraint.activate([
            changeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            changeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            changeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeButton.heightAnchor.constraint(equalToConstant: 50.0),
            changeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    @objc private func captureButtonTapped() {
        self.captureSession.stopRunning()
        self.dismiss(animated: true) {
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let rootVC = scene.windows.first(where: { $0.isKeyWindow })?.rootViewController {
                    let vc = AddCameraViewController()
                    rootVC.present(vc, animated: true)
                }
            }
    }
    
    func setupTabBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Face Detection"
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.barTintColor = .systemBackground
             navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.label]
        } else {
            // Fallback on earlier versions
            self.navigationController?.navigationBar.barTintColor = .lightText
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black]
        }
        self.navigationController?.navigationBar.isHidden = false
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.barStyle = .default
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.label]
        } else {
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.black]
        }
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            navigationController?.navigationBar.backgroundColor = .white
        }
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let request = VNDetectFaceRectanglesRequest { (req, err) in
            
            if let err = err {
                self.captureSession.startRunning()
                print("Failed to detect faces:", err)
                return
            }
            
            DispatchQueue.main.async {
                if let results = req.results, results.count > 0 {
                    let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
                    let image = UIImage(ciImage: ciImage)
                    
                    guard let serverImage = self.serverImage else {
                        print("Failed to fetch server image")
                        self.fetchServerImage()
                        return
                    }
                    
                    if let similarity = self.faceNet?.compare(image1: serverImage, with: image) {
                        print("Similarity score: \(similarity)")
                        if similarity > self.THRESHOLD {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                if !self.hasPostedPunch {
                                    self.hasPostedPunch = true
                                    self.postPunchData()
                                }
                            }
                        }
                    }
                }
            }
            
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            do {
                try handler.perform([request])
            } catch let reqErr {
                self.captureSession.startRunning()
                print("Failed to perform request:", reqErr)
            }
        }
    }
    
    func fetchServerImage() {
        ImageFetcher.fetchImage(from: self.serverImageUrl) { serverImage in
            guard let serverImage = serverImage else {
                self.captureSession.startRunning()
                print("Failed to fetch server image")
                return
            }

            self.serverImage = serverImage
        }
    }
    
    
}

extension IdentifyCameraViewController {
    // CLLocationManagerDelegate method to get location updates
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            print("Latitude: \(latitude), Longitude: \(longitude)")
            self.latitude = "\(latitude)"
            self.longitude = "\(longitude)"
            
            // Optionally stop updating location to save battery
            locationManager.stopUpdatingLocation()
        }
        
    // CLLocationManagerDelegate method
       func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           handleAuthorizationStatus(status)
       }
       
       // Handle authorization status changes
       private func handleAuthorizationStatus(_ status: CLAuthorizationStatus) {
           switch status {
           case .authorizedWhenInUse, .authorizedAlways:
               // Permissions granted, start updating location
               locationManager.startUpdatingLocation()
           case .denied, .restricted:
               // Permissions denied, update the UI accordingly
               showLocationAccessDeniedAlert()
           case .notDetermined:
               // Requesting authorization, do nothing
               break
           @unknown default:
               // Handle future cases
               break
           }
       }
       
       private func showLocationAccessDeniedAlert() {
           let alert = UIAlertController(title: "Location Access Denied",
                                         message: "Please enable location services in Settings.",
                                         preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default))
           present(alert, animated: true)
       }
       
       // CLLocationManagerDelegate method
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           // Handle location manager errors
           print("Location manager failed with error: \(error.localizedDescription)")
       }
}

extension IdentifyCameraViewController {
    
    func postPunchData() {
        
        let token: String = AppStorageManager.value(forKey: AppStorageKeys.KEY_TOKEN, defaultValue: "")
        let empID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_EMP_ID, defaultValue: 0)
        let clientID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_CLIENT_ID, defaultValue: 0)
        
        guard let empIDStr = BaseStringConverter.intToBase64String(empID),
              let clientIDStr = BaseStringConverter.intToBase64String(clientID) else {
            return
        }
        
        let url = Constants.baseUrl.rawValue + Constants.punchingUrl.rawValue
        guard let url = URL(string: url) else {
            showAlert(message: NetworkError.badURL.localizedDescription)
            return
        }
        
        let formData = [
            "empID": empIDStr,
            "clientID": clientIDStr,
            "latitude": latitude,
            "longitude": longitude
        ]
        
        let headers = ["Authorization": token]
        
        let networkManager = NetworkManager.shared
        
        guard let formBody = networkManager.createFormBody(from: formData) else { return }
        
        networkManager.fetchData(
            url: url,
            method: .post,
            headers: headers,
            body: formBody,
            responseType: PunchModel.self
        )
        .sink { [weak self] completion in
            switch completion {
            case .failure(let error):
                if let networkError = error as? NetworkError {
                    self?.showAlert(message: networkError.localizedDescription)
                    print("Failed with error: \(networkError.localizedDescription)")
                } else {
                    self?.showAlert(message: error.localizedDescription)
                    print("Failed with error: \(error.localizedDescription)")
                }
            case .finished:
                break
            }
        } receiveValue: { [weak self] data in
            print("Received response: \(data)")
           
            guard data.status == "success" else {
                self?.showAlert(message: "Failed. Please Try Again")
                return
            }
            
            self?.showToast(message: "Punch me success")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self?.dismiss(animated: true)
            }
            

        }
        .store(in: &cancellables)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension UIViewController {
    func showToast(message: String, duration: Double = 2.0) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textColor = .white
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 0.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true

        let maxSizeTitle = CGSize(width: self.view.bounds.size.width - 40, height: self.view.bounds.size.height)
        var expectedSizeTitle = toastLabel.sizeThatFits(maxSizeTitle)
        expectedSizeTitle.width += 20
        expectedSizeTitle.height += 10
        toastLabel.frame = CGRect(
            x: (self.view.frame.size.width - expectedSizeTitle.width) / 2,
            y: self.view.frame.size.height - 100,
            width: expectedSizeTitle.width,
            height: expectedSizeTitle.height
        )

        self.view.addSubview(toastLabel)

        UIView.animate(withDuration: 0.5, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: { _ in
                toastLabel.removeFromSuperview()
            })
        }
    }
}
