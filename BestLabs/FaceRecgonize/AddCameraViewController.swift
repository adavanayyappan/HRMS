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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        view.backgroundColor = .white
        setupButton()
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
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
        
        captureSession.startRunning()
    }
    
    func setupButton() {
        // Add a button to capture image
        // Add a button to capture image
        captureButton.setTitle("Add Face", for: .normal)
        captureButton.addTarget(self, action: #selector(captureButtonTapped), for: .touchUpInside)
        captureButton.translatesAutoresizingMaskIntoConstraints = false
//        captureButton.backgroundColor = .primarycolor
        captureButton.tintColor = .white
        view.addSubview(captureButton)
        captureButton.isEnabled = false
        
        NSLayoutConstraint.activate([
            captureButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            captureButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            captureButton.heightAnchor.constraint(equalToConstant: 50.0),
            captureButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
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
                return
            }
            
            DispatchQueue.main.async {
                if let results = req.results, results.count > 0 {
                    self.captureButton.isEnabled = true
                    self.captureSession.stopRunning()
                    let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
                    self.detectedImage = UIImage(ciImage: ciImage)
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
    
    @objc private func captureButtonTapped() {
        uploadFaceRequest()
    }
    
    private func uploadFaceRequest() {
        guard let detectedImage else {
            return
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
                do {
                    let response = try JSONDecoder().decode(FaceAddResponse.self, from: data)
                    print("Status: \(response.status)")
                    print("Face Image: \(response.faceImage)")
                    let imagePath = response.faceImage.replacingOccurrences(of: "http://portal.bsnet.biz/hrms/media/face/", with: "")
                    AppStorageManager.setValue(response.faceImage, forKey: AppStorageKeys.KEY_EMP_IMAGE)
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)
                    }
                } catch {
                    print("Decoding failed: \(data)")
                    self.showAlert(message: "Decoding failed")
                    self.captureSession.startRunning()
                }
                
            case .failure(let error):
                // Handle error
                print("Upload failed: \(error)")
                self.captureSession.startRunning()
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


