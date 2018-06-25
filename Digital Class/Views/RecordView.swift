//
//  RecordView.swift
//  Digital Class
//
//  Created by Celina Martinez on 12/6/18.
//  Copyright © 2018 Jadapema. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import FirebaseDatabase


class RecordView : UIView {
    
    //
    let  movieFileOutput = AVCaptureMovieFileOutput()
    var session: AVCaptureSession?
    var userreponsevideoData = NSData()
    var userreponsethumbimageData = NSData()
    ///
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    var cameraPreviewLayer : AVCaptureVideoPreviewLayer?
    
    var imageTaked : UIImage!
    var videoImage : UIImage!
    var videoUrl : URL!
    var isRecording = false
    
    var recordView : UIView = {
       var view = UIView()
        return view
    }()
    
    var takePhotoView : UIView = {
        var view = UIView()
        view.layer.borderWidth = 2
        view.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9137254902, blue: 0.8784313725, alpha: 0.7040881849)
        view.layer.borderColor = Utilities().darkBlueColor.cgColor
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 35
        view.clipsToBounds = true
        return view
    }()
    
    var changueModeLbl : UILabel = {
        let label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "Video"
        label.textAlignment = .center
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        label.layer.masksToBounds = false
        label.layer.cornerRadius = 5
        label.layer.borderColor = Utilities().whiteColor.cgColor
        label.layer.borderWidth = 1
        label.clipsToBounds = true
        return label
    }()
    
    var photosView : UIImageView = {
        var view = UIImageView()
        view.layer.borderWidth = 1
        view.backgroundColor = Utilities().lightBlueColor
        view.layer.borderColor = Utilities().darkBlueColor.cgColor
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    //  top view
    var topView : UIView = {
        var topView = UIView(frame: CGRect(x: 0, y: 0, width: 415, height: 40))
        let separator = UIView()
        topView.addSubview(separator)
        topView.backgroundColor = Utilities().darkBlueColor
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        separator.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 0).isActive = true
        separator.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: 0).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separator.backgroundColor = Utilities().lightBlueColor
        topView.isHidden = true
        return topView
    }()
    
    // left IV
    let leftIV : UIImageView = {
        var imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "flecha")
        let rotationAngle = 180 * (Double.pi/180)
        imageView.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
        return imageView
    }()
    
    var photosArray : [UIImage] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(recordView)
        addSubview(takePhotoView)
        takePhotoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(takePhotoHandler)))
        takePhotoView.isUserInteractionEnabled = true
        addSubview(changueModeLbl)
        changueModeLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeModeHandler)))
        changueModeLbl.isUserInteractionEnabled = true
        addSubview(photosView)
        photosView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(collectionPhotosHandler)))
        photosView.isUserInteractionEnabled = true
        
        addSubview(topView)
        
        backgroundColor = Utilities().lightBlueColor
        SetupCaptureSession()
        SetupDevice()
        SetupInputOutput()
        SetupPreviewLayer()
        StartRunningCaptureSession()
        setupLayout()
        
    }
    
    func setupLayout () {
        
        recordView.translatesAutoresizingMaskIntoConstraints = false
        recordView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        recordView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        recordView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        recordView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        
        takePhotoView.translatesAutoresizingMaskIntoConstraints = false
        takePhotoView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        takePhotoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -13).isActive = true
        takePhotoView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        takePhotoView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        changueModeLbl.translatesAutoresizingMaskIntoConstraints = false
        changueModeLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        changueModeLbl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        changueModeLbl.widthAnchor.constraint(equalToConstant: 80).isActive = true
        changueModeLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        photosView.translatesAutoresizingMaskIntoConstraints = false
        photosView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        photosView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        photosView.widthAnchor.constraint(equalToConstant: 41).isActive = true
        photosView.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        
    }
    
    func SetupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    func SetupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
            currentCamera = backCamera
        }
    }
    
    func SetupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            if #available(iOS 11.0, *) {
                photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings.init(format: [AVVideoCodecKey:AVVideoCodecType.jpeg])], completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }
            captureSession.addOutput(photoOutput!)
            
            
        } catch {
            print(error)
        }
    }
    
    func SetupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.frame
        self.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    public func StartRunningCaptureSession() {
        captureSession.startRunning()
    }
    
    func createSession() {
        
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
            currentCamera = backCamera
        }
        
        
        
        var input: AVCaptureDeviceInput?
        //        let  movieFileOutput = AVCaptureMovieFileOutput()
        var prevLayer: AVCaptureVideoPreviewLayer?
        prevLayer?.frame.size = recordView.frame.size
        session = AVCaptureSession()
        let error: NSError? = nil
        do { input = try AVCaptureDeviceInput(device: currentCamera!) } catch {return}
        if error == nil {
            session?.addInput(input!)
        } else {
            print("camera input error: \(String(describing: error))")
        }
        prevLayer = AVCaptureVideoPreviewLayer(session: session!)
        prevLayer?.frame.size = recordView.frame.size
        prevLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        prevLayer?.connection?.videoOrientation = .portrait
        recordView.layer.addSublayer(prevLayer!)
        //        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        //        let  filemainurl = NSURL(string: ("\(documentsURL.appendingPathComponent("temp"))" + ".mov"))
        
        let maxDuration: CMTime = CMTimeMake(600, 10)
        movieFileOutput.maxRecordedDuration = maxDuration
        movieFileOutput.minFreeDiskSpaceLimit = 1024 * 1024
        if self.session!.canAddOutput(movieFileOutput) {
            self.session!.addOutput(movieFileOutput)
        }
        session?.startRunning()
        //        movieFileOutput.startRecording(toOutputFileURL: filemainurl! as URL, recordingDelegate: self)
        
    }
    
    func cameraWithPosition(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        for device in devices {
            if device.position == position {
                return device
            }
        }
        return nil
    }
    
    @objc func takePhotoHandler () {
        print("Take Photo")
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    @objc func takeVideoHandler () {
        print("take video")
    }
    
    @objc func changeModeHandler () {
        print("Change")
    }
    
    @objc func collectionPhotosHandler () {
        print("Collection")
        guard photosArray.count != 0 else {return}
        
        recordView.isHidden = true
        photosView.isHidden = true
        changueModeLbl.isHidden = true
        takePhotoView.isHidden = true
        
        
    }
    
    @objc func backHandler () {
        print("back")
        
        recordView.isHidden = false
        photosView.isHidden = false
        changueModeLbl.isHidden = false
        takePhotoView.isHidden = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecordView : AVCapturePhotoCaptureDelegate {
    
    @available(iOS 11.0, *)
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let ImageData = photo.fileDataRepresentation() {
//            ImageTaked = UIImage(data: ImageData)
            self.photosView.image = UIImage(data: ImageData)
            photosArray.append(UIImage(data: ImageData)!)
//            performSegue(withIdentifier: "ShowPreview", sender: nil)
        }
    }
}
