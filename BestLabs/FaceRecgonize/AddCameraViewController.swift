//
//  AddCameraViewController.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 23/07/24.
//

import UIKit
import AVFoundation
import Vision

class AddCameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var detectedImage: UIImage?
    let captureButton = UIButton(type: .system)
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.isHidden = true
        return label
    }()

    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        view.backgroundColor = .white
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
        
        view.bringSubviewToFront(captureButton)
        
        DispatchQueue.global(qos: .userInitiated).async {
            if !self.captureSession.isRunning {
                self.captureSession.startRunning()
            }
        }
        
        setupActivityIndicator()
        
        view.addSubview(statusLabel)

        NSLayoutConstraint.activate([
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            statusLabel.bottomAnchor.constraint(equalTo: captureButton.topAnchor, constant: -10),
            statusLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])

        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 60),
            closeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    private func setupActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

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
        // Add a button to capture image
        captureButton.setTitle("Add Face", for: .normal)
        captureButton.addTarget(self, action: #selector(captureButtonTapped), for: .touchUpInside)
        captureButton.translatesAutoresizingMaskIntoConstraints = false
        captureButton.backgroundColor = .primarycolor
        captureButton.tintColor = .white
        view.addSubview(captureButton)
        captureButton.isEnabled = false
        
        NSLayoutConstraint.activate([
            captureButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            captureButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            captureButton.heightAnchor.constraint(equalToConstant: 50.0),
            captureButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    func setupTabBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Face Add"
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
                print("Failed to detect faces:", err)
                self.showStatus("No Faces Detected")
                return
            }

            if let results = req.results as? [VNFaceObservation], let face = results.first {
                let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
                let context = CIContext()
                guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
                    print("Failed to create CGImage from CIImage")
                    return
                }

                let orientedImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: .right)
                DispatchQueue.main.async {
                    self.hideStatus()
                    self.cropFace(from: orientedImage, with: face)
                }
            } else {
                self.showStatus("No Faces Detected")
            }
        }

        DispatchQueue.global(qos: .userInteractive).async {
            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            try? handler.perform([request])
        }
    }

    
    private func cropFace(from image: UIImage, with observation: VNFaceObservation) {
        guard let cgImage = image.cgImage else { return }

        let boundingBox = observation.boundingBox
        let width = CGFloat(cgImage.width)
        let height = CGFloat(cgImage.height)

        let faceRect = CGRect(
            x: boundingBox.origin.x * width,
            y: (1 - boundingBox.origin.y - boundingBox.height) * height,
            width: boundingBox.width * width,
            height: boundingBox.height * height
        )

        guard let croppedCGImage = cgImage.cropping(to: faceRect) else { return }

        let croppedImage = UIImage(cgImage: croppedCGImage, scale: image.scale, orientation: image.imageOrientation)
        let resized = Tools.scaleImage(croppedImage, toSize: CGSize(width: 112, height: 112))

        if let finalImage = resized {
            self.processCapturedImage(finalImage)
        }
    }

    
    // Inside image capture delegate or similar:
    func processCapturedImage(_ image: UIImage) {
        self.detectedImage = image
        self.captureButton.isEnabled = true
    }

    private func showStatus(_ text: String) {
        DispatchQueue.main.async {
            self.statusLabel.text = text
            self.statusLabel.isHidden = false
        }
    }

    private func hideStatus() {
        DispatchQueue.main.async {
            self.statusLabel.isHidden = true
        }
    }
    
    @objc private func captureButtonTapped() {
        uploadFaceRequest()
    }
    
    private func uploadFaceRequest() {
        guard let detectedImage else {
            return
        }
        
        // Show loader
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.captureButton.isEnabled = false
        }
        
        let url = Constants.baseUrl.rawValue + Constants.uploadFaceUrl.rawValue
        let imageUrl = URL(string: url)!
        
        let token: String = AppStorageManager.value(forKey: AppStorageKeys.KEY_TOKEN, defaultValue: "")
        let empID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_EMP_ID, defaultValue: 0)
        let clientID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_CLIENT_ID, defaultValue: 0)
        
        guard let empIDStr = BaseStringConverter.intToBase64String(empID),
              let clientIDStr = BaseStringConverter.intToBase64String(clientID) else {
            return
        }
        
        let parameters = ["empID": empIDStr, "clientID": clientIDStr]
        let headers = ["Authorization" : token]
        
        ImageFetcher.uploadImage(url: imageUrl, image: detectedImage, parameters: parameters, headers: headers) { result in
            switch result {
            case .success(let data):
                // Handle success
                print("Upload successful: \(data)")
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
                do {
                    let response = try JSONDecoder().decode(FaceAddResponse.self, from: data)
                    print("Status: \(response.status)")
                    print("Face Image: \(response.faceImage)")
                    let imagePath = response.faceImage.replacingOccurrences(of: "http://portal.bsnet.biz/hrms/media/face/", with: "")
                    AppStorageManager.setValue(imagePath, forKey: AppStorageKeys.KEY_EMP_IMAGE)
                    DispatchQueue.global(qos: .userInitiated).async {
                        if self.captureSession.isRunning {
                            self.captureSession.stopRunning()
                        }
                    }
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)
                    }
                } catch {
                    print("Decoding failed: \(data)")
                    self.showAlert(message: "Decoding failed")
                    DispatchQueue.global(qos: .userInitiated).async {
                        if !self.captureSession.isRunning {
                            self.captureSession.startRunning()
                        }
                    }
                }
                
            case .failure(let error):
                // Handle error
                print("Upload failed: \(error)")
                DispatchQueue.global(qos: .userInitiated).async {
                    if !self.captureSession.isRunning {
                        self.captureSession.startRunning()
                    }
                }
                self.showAlert(message: "Upload failed")
            }
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
                      
struct FaceAddResponse: Codable {
    let status: String
    let message: String
    let faceImage: String
}


