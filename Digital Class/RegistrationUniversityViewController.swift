//
//  RegistrationUniversityViewController.swift
//  Digital Class
//
//  Created by Celina Martinez on 7/6/18.
//  Copyright © 2018 Jadapema. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MapKit


class RegistrationUniversityViewController: UIViewController {

    let utilities = Utilities()
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // Scroll
    let scrollView : UIScrollView = {
        let screensize: CGRect = UIScreen.main.bounds
        var scrollView: UIScrollView!
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screensize.width, height: screensize.height))
        
        scrollView.contentSize = CGSize(width: screensize.width, height: 1320)
        return scrollView
    }()
    
    // My logo
    var logoIV : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logo-top")
        return imageView
    }()
    // Welcome label
    var welcomeLbl : UILabel = {
        let label = UILabel()
        label.text = "Bienvenido a Digital Class"
        label.textAlignment = .center
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Regular", size: 20)
        return label
    }()
    
    // Video View
    var videoV : UIView = {
        var view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        var image = UIImageView(frame: CGRect(x: 0, y: 0, width: 390, height: 230))
        image.image = #imageLiteral(resourceName: "video")
        view.addSubview(image)
        return view
    }()
    
    //  message Label
    var messageLbl : UILabel = {
        let label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "Se requiere que complete el siguiente formulario para contactarnos con su administracion.\n Agradecemos su confianza en nosotros."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 20)
        return label
    }()
    
    // names textfield
    var nameTxtF : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Utilities().darkBlueColor
        textField.attributedPlaceholder = NSAttributedString(string: "Nombre de tu Universidad",
                                                             attributes: [NSAttributedStringKey.foregroundColor: Utilities().whiteColor, NSAttributedStringKey.font : UIFont(name: "AvenirNext-UltraLight", size: 20) as Any])
        
        textField.textColor = Utilities().whiteColor
        textField.textAlignment = .center
        textField.font = UIFont(name: "AvenirNext-UltraLight", size: 20)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 30
        textField.clipsToBounds = true
        textField.keyboardAppearance = .dark
        textField.keyboardType = .asciiCapable
        textField.returnKeyType = .done
        return textField
    }()
    
    // slogan textfield
    var sloganTxtF : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Utilities().darkBlueColor
        textField.attributedPlaceholder = NSAttributedString(string: "Slogan de tu Universidad",
                                                             attributes: [NSAttributedStringKey.foregroundColor: Utilities().whiteColor, NSAttributedStringKey.font : UIFont(name: "AvenirNext-UltraLight", size: 20) as Any])
        
        textField.textColor = Utilities().whiteColor
        textField.textAlignment = .center
        textField.font = UIFont(name: "AvenirNext-UltraLight", size: 20)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 30
        textField.clipsToBounds = true
        textField.keyboardAppearance = .dark
        textField.keyboardType = .asciiCapable
        textField.returnKeyType = .done
        return textField
    }()
    
    // email textfield
    var emailTxtF : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Utilities().darkBlueColor
        textField.attributedPlaceholder = NSAttributedString(string: "Ingresa tu correo",
                                                             attributes: [NSAttributedStringKey.foregroundColor: Utilities().whiteColor, NSAttributedStringKey.font : UIFont(name: "AvenirNext-UltraLight", size: 20) as Any])
        
        textField.textColor = Utilities().whiteColor
        textField.textAlignment = .center
        textField.font = UIFont(name: "AvenirNext-UltraLight", size: 20)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 30
        textField.clipsToBounds = true
        textField.keyboardAppearance = .dark
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .done
        return textField
    }()
    
    // phone textfield
    var phoneTxtF : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Utilities().darkBlueColor
        textField.attributedPlaceholder = NSAttributedString(string: "Ingresa tu telefono",
                                                             attributes: [NSAttributedStringKey.foregroundColor: Utilities().whiteColor, NSAttributedStringKey.font : UIFont(name: "AvenirNext-UltraLight", size: 20) as Any])
        
        textField.textColor = Utilities().whiteColor
        textField.textAlignment = .center
        textField.font = UIFont(name: "AvenirNext-UltraLight", size: 20)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 30
        textField.clipsToBounds = true
        textField.keyboardAppearance = .dark
        textField.keyboardType = .numberPad
        textField.returnKeyType = .done
        return textField
    }()
    
    // ubicar universidad label
    var mapLbl : UILabel = {
        let label = UILabel()
        label.text = "Ubicar Universidad en el mapa"
        label.textAlignment = .center
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Regular", size: 20)
        return label
    }()
    
    // Map View
    private var locationManager: CLLocationManager!
    private var currentLocation: MKPointAnnotation?
    private var universityLocation : CLLocationCoordinate2D?
    var enter = true
    var mapV : MKMapView = {
        var view = MKMapView()
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.mapType = .standard
        view.isZoomEnabled = true
        view.isScrollEnabled = true
        return view
    }()

    //  Send Request label
    var sendLbl : UILabel = {
        let label = UILabel()
        label.backgroundColor = Utilities().lightBlueColor
        label.text = "Enviar Solicitud"
        label.textAlignment = .center
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        label.layer.masksToBounds = false
        label.layer.cornerRadius = 30
        label.clipsToBounds = true
        return label
    }()
    
    //  LogIn Label
    var LogInLbl : UILabel = {
        let label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "Iniciar Sesion"
        label.textAlignment = .center
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 20)
        return label
    }()
    
    var player: AVPlayer!
    var avpController = AVPlayerViewController()
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.backgroundColor = utilities.darkBlueColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(logoIV)
        scrollView.addSubview(welcomeLbl)
        scrollView.addSubview(videoV)
        videoV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playVideo)))
        videoV.isUserInteractionEnabled = true
        scrollView.addSubview(messageLbl)
        scrollView.addSubview(nameTxtF)
        nameTxtF.delegate = self
        scrollView.addSubview(sloganTxtF)
        sloganTxtF.delegate = self
        scrollView.addSubview(emailTxtF)
        emailTxtF.delegate = self
        scrollView.addSubview(phoneTxtF)
        phoneTxtF.delegate = self
        phoneTxtF.addDoneButtonToKeyboard(myAction:  #selector(self.phoneTxtF.resignFirstResponder))
        scrollView.addSubview(mapLbl)
        scrollView.addSubview(mapV)
        // map
        locationManager = CLLocationManager()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        mapV.delegate = self
        addLongPressGesture()
        //
        scrollView.addSubview(sendLbl)
        sendLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendHandler)))
        sendLbl.isUserInteractionEnabled = true
        scrollView.addSubview(LogInLbl)
        LogInLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logInHandler)))
        LogInLbl.isUserInteractionEnabled = true
        
        setupLayout()
        
    }
    
    private func setupLayout () {
        //Logo
        logoIV.translatesAutoresizingMaskIntoConstraints = false
        logoIV.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 27).isActive = true
        logoIV.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        logoIV.widthAnchor.constraint(equalToConstant: 312).isActive = true
        logoIV.heightAnchor.constraint(equalToConstant: 109).isActive = true
        // Welcome label
        welcomeLbl.translatesAutoresizingMaskIntoConstraints = false
        welcomeLbl.topAnchor.constraint(equalTo: logoIV.bottomAnchor, constant: 0).isActive = true
        welcomeLbl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        welcomeLbl.widthAnchor.constraint(equalToConstant: 390).isActive = true
        welcomeLbl.heightAnchor.constraint(equalToConstant: 45).isActive = true
        // video view
        videoV.translatesAutoresizingMaskIntoConstraints = false
        videoV.topAnchor.constraint(equalTo: welcomeLbl.bottomAnchor, constant: 10).isActive = true
        videoV.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        videoV.widthAnchor.constraint(equalToConstant: 390).isActive = true
        videoV.heightAnchor.constraint(equalToConstant: 230).isActive = true
        // message label
        messageLbl.translatesAutoresizingMaskIntoConstraints = false
        messageLbl.topAnchor.constraint(equalTo: videoV.bottomAnchor, constant: 10).isActive = true
        messageLbl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        messageLbl.widthAnchor.constraint(equalToConstant: 390).isActive = true
        messageLbl.heightAnchor.constraint(equalToConstant: 170).isActive = true
        // name taxtfield
        nameTxtF.translatesAutoresizingMaskIntoConstraints = false
        nameTxtF.topAnchor.constraint(equalTo: messageLbl.bottomAnchor, constant: 10).isActive = true
        nameTxtF.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        nameTxtF.widthAnchor.constraint(equalToConstant: 390).isActive = true
        nameTxtF.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // slogan textfield
        sloganTxtF.translatesAutoresizingMaskIntoConstraints = false
        sloganTxtF.topAnchor.constraint(equalTo: nameTxtF.bottomAnchor, constant: 10).isActive = true
        sloganTxtF.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        sloganTxtF.widthAnchor.constraint(equalToConstant: 390).isActive = true
        sloganTxtF.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // email textfield
        emailTxtF.translatesAutoresizingMaskIntoConstraints = false
        emailTxtF.topAnchor.constraint(equalTo: sloganTxtF.bottomAnchor, constant: 10).isActive = true
        emailTxtF.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        emailTxtF.widthAnchor.constraint(equalToConstant: 390).isActive = true
        emailTxtF.heightAnchor.constraint(equalToConstant: 60).isActive = true
        //phone textfield
        phoneTxtF.translatesAutoresizingMaskIntoConstraints = false
        phoneTxtF.topAnchor.constraint(equalTo: emailTxtF.bottomAnchor, constant: 10).isActive = true
        phoneTxtF.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        phoneTxtF.widthAnchor.constraint(equalToConstant: 390).isActive = true
        phoneTxtF.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // map label
        mapLbl.translatesAutoresizingMaskIntoConstraints = false
        mapLbl.topAnchor.constraint(equalTo: phoneTxtF.bottomAnchor, constant: 0).isActive = true
        mapLbl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        mapLbl.widthAnchor.constraint(equalToConstant: 390).isActive = true
        mapLbl.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // map view
        mapV.translatesAutoresizingMaskIntoConstraints = false
        mapV.topAnchor.constraint(equalTo: mapLbl.bottomAnchor, constant: 0).isActive = true
        mapV.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        mapV.widthAnchor.constraint(equalToConstant: 390).isActive = true
        mapV.heightAnchor.constraint(equalToConstant: 250).isActive = true
        // send label
        sendLbl.translatesAutoresizingMaskIntoConstraints = false
        sendLbl.topAnchor.constraint(equalTo: mapV.bottomAnchor, constant: 10).isActive = true
        sendLbl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        sendLbl.widthAnchor.constraint(equalToConstant: 390).isActive = true
        sendLbl.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // login label
        LogInLbl.translatesAutoresizingMaskIntoConstraints = false
        LogInLbl.topAnchor.constraint(equalTo: sendLbl.bottomAnchor, constant: 10).isActive = true
        LogInLbl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        LogInLbl.widthAnchor.constraint(equalToConstant: 120).isActive = true
        LogInLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    @objc func playVideo() {
        let moviePath = Bundle.main.path(forResource: "publicidad", ofType: "mp4")
        if let path = moviePath {
            let url = NSURL.fileURL(withPath: path)
            self.player = AVPlayer(url: url)
            self.avpController = AVPlayerViewController()
            self.avpController.player = self.player
            avpController.view.frame = videoV.frame
            avpController.view.frame.origin.y = 0
            avpController.view.frame.origin.x = 0
            
            self.addChildViewController(avpController)
            videoV.addSubview(avpController.view)
            player.play()
        }

    }
    
    @objc func sendHandler () {
        guard self.nameTxtF.text != nil && self.nameTxtF.text != "" else {
            nameTxtF.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.1568627451, blue: 0.1058823529, alpha: 1)
            utilities.littleDownMovement(view: nameTxtF)
            return
        }
        guard self.sloganTxtF.text != nil && self.sloganTxtF.text != "" else {
            nameTxtF.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
            sloganTxtF.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.1568627451, blue: 0.1058823529, alpha: 1)
            utilities.littleDownMovement(view: sloganTxtF)
            return
        }
        guard self.emailTxtF.text != nil && self.emailTxtF.text != "" else {
            emailTxtF.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.1568627451, blue: 0.1058823529, alpha: 1)
            sloganTxtF.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
            nameTxtF.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
            utilities.littleDownMovement(view: emailTxtF)
            return
        }
        guard utilities.isValidEmail(email: self.emailTxtF.text!) else {
            emailTxtF.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.1568627451, blue: 0.1058823529, alpha: 1)
            emailTxtF.text = ""
            emailTxtF.attributedPlaceholder = NSAttributedString(string: "Correo mal estrucutado ej. me@mail.com",
                                                                 attributes: [NSAttributedStringKey.foregroundColor: Utilities().redColor, NSAttributedStringKey.font : UIFont(name: "AvenirNext-UltraLight", size: 20) as Any])
            return
        }
        guard self.phoneTxtF.text != nil && self.phoneTxtF.text != "" else {
            self.emailTxtF.attributedPlaceholder = NSAttributedString(string: "Ingresa tu correo",
                                                                      attributes: [NSAttributedStringKey.foregroundColor: Utilities().whiteColor, NSAttributedStringKey.font : UIFont(name: "AvenirNext-UltraLight", size: 20) as Any])
            phoneTxtF.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.1568627451, blue: 0.1058823529, alpha: 1)
            emailTxtF.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
            sloganTxtF.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
            nameTxtF.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
            utilities.littleDownMovement(view: phoneTxtF)
            return
        }
        guard self.universityLocation != nil else {
            mapLbl.textColor = #colorLiteral(red: 0.5882352941, green: 0.1568627451, blue: 0.1058823529, alpha: 1)
            utilities.littleDownMovement(view: mapLbl)
            return
        }
        print("send")
        print("University Name: \(nameTxtF.text!), slogan: \(sloganTxtF.text!), email: \(emailTxtF.text!), phone: \(phoneTxtF.text!), latitud: \((universityLocation?.latitude)!), longitud: \((universityLocation?.longitude)!)")
        let modalStyle = UIModalTransitionStyle.crossDissolve
        let vc = ViewController()
        vc.modalTransitionStyle = modalStyle
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func logInHandler () {
        print("Login")
        let modalStyle = UIModalTransitionStyle.crossDissolve
        let vc = ViewController()
        vc.modalTransitionStyle = modalStyle
        self.present(vc, animated: true, completion: nil)
    }
    // map
    
    func addLongPressGesture(){
        let longPressRecogniser:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target:self , action:#selector(RegistrationUniversityViewController.handleLongPress(_:)))
        longPressRecogniser.minimumPressDuration = 1.0 //user needs to press for 2 seconds
        self.mapV.addGestureRecognizer(longPressRecogniser)
    }
    
    @objc func handleLongPress(_ gestureRecognizer:UIGestureRecognizer){
        if gestureRecognizer.state != .began{
            return
        }
        
        guard self.nameTxtF.text != nil && self.nameTxtF.text != "" else {
            nameTxtF.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.1568627451, blue: 0.1058823529, alpha: 1)
            utilities.littleDownMovement(view: nameTxtF)
            return
        }
        
        let touchPoint:CGPoint = gestureRecognizer.location(in: self.mapV)
        let touchMapCoordinate:CLLocationCoordinate2D =
            self.mapV.convert(touchPoint, toCoordinateFrom: self.mapV)
        
        let annot:MKPointAnnotation = MKPointAnnotation()
        annot.coordinate = touchMapCoordinate
        annot.title = "\(nameTxtF.text!)"
        
        universityLocation = touchMapCoordinate
        
        self.resetTracking()
        self.mapV.removeAnnotations(mapV.annotations)
        self.mapV.addAnnotation(annot)
        self.mapV.addAnnotation(currentLocation!)
        self.centerMap(touchMapCoordinate)
    }
    
    func resetTracking(){
        if (mapV.showsUserLocation){
            mapV.showsUserLocation = false
            self.mapV.removeAnnotations(mapV.annotations)
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func centerMap(_ center:CLLocationCoordinate2D){
        let spanX = 0.007
        let spanY = 0.007
        
        let newRegion = MKCoordinateRegion(center:center , span: MKCoordinateSpanMake(spanX, spanY))
        mapV.setRegion(newRegion, animated: true)
    }
    //
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        nameTxtF.resignFirstResponder()
        sloganTxtF.resignFirstResponder()
        emailTxtF.resignFirstResponder()
        phoneTxtF.resignFirstResponder()
        
    }
    
}

extension RegistrationUniversityViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTxtF.resignFirstResponder()
        sloganTxtF.resignFirstResponder()
        emailTxtF.resignFirstResponder()
        phoneTxtF.resignFirstResponder()
        return true
    }
}

extension RegistrationUniversityViewController : CLLocationManagerDelegate, MKMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if enter {
            enter = false
            centerMap((manager.location?.coordinate)!)
            let annot:MKPointAnnotation = MKPointAnnotation()
            annot.coordinate = (manager.location?.coordinate)!
            annot.title = "You!"
            currentLocation = annot
            mapV.addAnnotation(currentLocation!)
            print("hello")
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        let identifier = "pin"
        var view : MKPinAnnotationView
        if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView{
            print("with")
            dequeueView.annotation = annotation
            view = dequeueView
        }else{
            print("without")
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        view.pinTintColor =  utilities.lightBlueColor
        return view
    }
}
