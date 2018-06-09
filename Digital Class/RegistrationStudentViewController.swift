//
//  RegistrationStudentViewController.swift
//  Digital Class
//
//  Created by Celina Martinez on 7/6/18.
//  Copyright © 2018 Jadapema. All rights reserved.
//

import UIKit

class RegistrationStudentViewController: UIViewController {

    let utilities = Utilities()
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // My logo
    var logoIV : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logo-top")
        return imageView
    }()
    
    // Container View Profile Image
    var profileImageContainer : UIView = {
        var view = UIView()
        view.backgroundColor = Utilities().darkBlueColor
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    // Scroll
    let scrollView : UIScrollView = {
        let screensize: CGRect = UIScreen.main.bounds
        var scrollView: UIScrollView!
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screensize.width, height: screensize.height))
        
        scrollView.contentSize = CGSize(width: screensize.width, height: 1320)
        return scrollView
    }()
    
    // Image View Profile
    var profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "student")
        return imageView
    }()
    
    //  facebook
    var fLbl : UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.3490196078, blue: 0.5960784314, alpha: 1)
        label.text = "f"
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        label.layer.masksToBounds = false
        label.layer.cornerRadius = 30
        label.clipsToBounds = true
        return label
    }()
    
    // selecciona tu foto de perfil label
    var selectionLbl : UILabel = {
        let label = UILabel()
        label.text = "Selecciona tu foto de perfil"
        label.textAlignment = .center
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Regular", size: 20)
        return label
    }()
    
    // names textfield
    var nameTxtF : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Utilities().darkBlueColor
        textField.attributedPlaceholder = NSAttributedString(string: "Ingresa tus nombres",
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
    
    // given names textfield
    var givenNamesTxtF : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Utilities().darkBlueColor
        textField.attributedPlaceholder = NSAttributedString(string: "Ingresa tus apellidos",
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
    
    // date Picker
    var datePicker : UIDatePicker = {
        var picker = UIDatePicker()
        var components = DateComponents()
        components.year = -59
        components.month = 01
        components.day = 01
        let minDate = Calendar.current.date(byAdding: components, to: Date())
        components.month = -Calendar.current.component(.month, from: Date())
        components.day = -Calendar.current.component(.day, from: Date())
        components.year = -9
        let maxDate = Calendar.current.date(byAdding: components, to: Date())
        
        picker.minimumDate = minDate
        picker.maximumDate = maxDate
        picker.datePickerMode = .date
        picker.setValue(Utilities().whiteColor, forKeyPath: "textColor")
        picker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        return picker
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
        textField.keyboardType = .asciiCapable
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
    // selecciona tu Universidad label
    var selectionUniLbl : UILabel = {
        let label = UILabel()
        label.text = "Selecciona tu Universidad"
        label.textAlignment = .center
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Regular", size: 20)
        return label
    }()
    
    // ies - view
    var iesV : UIView = {
        var view = UIView()
        view.backgroundColor = Utilities().darkBlueColor
        view.layer.borderWidth = 3
        view.layer.borderColor = #colorLiteral(red: 0.4039215686, green: 0.5019607843, blue: 0.6235294118, alpha: 1)
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        
        // The image
        var imageview : UIImageView = {
            let imageView = UIImageView()
            imageView.image = #imageLiteral(resourceName: "ies")
            return imageView
        }()
        // Container of Image
        var viewIn : UIView = {
            let viewInSide = UIView()
            viewInSide.backgroundColor = Utilities().whiteColor
            viewInSide.layer.borderWidth = 1
            viewInSide.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
            viewInSide.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            viewInSide.layer.masksToBounds = false
            viewInSide.layer.cornerRadius = 10
            viewInSide.clipsToBounds = true

            return viewInSide
        }()
        // Label
        var typeLbl : UILabel = {
            let label = UILabel()
            label.backgroundColor = Utilities().darkBlueColor
            label.textAlignment = .center
            label.textColor = Utilities().whiteColor
            label.font = UIFont(name: "AvenirNext-Regular", size: 20)
            label.text = "ies - UNI"
            return label
        }()
        
        // Setting the constraints
        view.addSubview(viewIn)
        viewIn.translatesAutoresizingMaskIntoConstraints = false
        viewIn.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        viewIn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        viewIn.heightAnchor.constraint(equalToConstant: 72).isActive = true
        viewIn.widthAnchor.constraint(equalToConstant: 118).isActive = true
        
        viewIn.addSubview(imageview)
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.centerXAnchor.constraint(equalTo: viewIn.centerXAnchor, constant: 0).isActive = true
        imageview.centerYAnchor.constraint(equalTo: viewIn.centerYAnchor, constant: 0).isActive = true
        imageview.heightAnchor.constraint(equalToConstant: 35).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(typeLbl)
        typeLbl.translatesAutoresizingMaskIntoConstraints = false
        typeLbl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        typeLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        typeLbl.heightAnchor.constraint(equalToConstant: 32).isActive = true
        typeLbl.widthAnchor.constraint(equalToConstant: 124).isActive = true

        return view
    }()
    // other University - view
    var otherUniV : UIView = {
        var view = UIView()
        view.backgroundColor = Utilities().darkBlueColor
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        
        // The image
        var imageview : UIImageView = {
            let imageView = UIImageView()
            imageView.image = #imageLiteral(resourceName: "university")
            return imageView
        }()
        // Container of Image
        var viewIn : UIView = {
            let viewInSide = UIView()
            viewInSide.backgroundColor = Utilities().whiteColor
            viewInSide.layer.borderWidth = 1
            viewInSide.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
            viewInSide.layer.masksToBounds = false
            viewInSide.layer.cornerRadius = 10
            viewInSide.clipsToBounds = true
            viewInSide.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            return viewInSide
        }()
        // Label
        var typeLbl : UILabel = {
            let label = UILabel()
            label.backgroundColor = Utilities().darkBlueColor
            label.textAlignment = .center
            label.textColor = Utilities().whiteColor
            label.font = UIFont(name: "AvenirNext-Regular", size: 20)
            label.text = "Otra"
            return label
        }()
        
        // Setting the constraints
        view.addSubview(viewIn)
        viewIn.translatesAutoresizingMaskIntoConstraints = false
        viewIn.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        viewIn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        viewIn.heightAnchor.constraint(equalToConstant: 72).isActive = true
        viewIn.widthAnchor.constraint(equalToConstant: 118).isActive = true
        
        viewIn.addSubview(imageview)
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.centerXAnchor.constraint(equalTo: viewIn.centerXAnchor, constant: 0).isActive = true
        imageview.heightAnchor.constraint(equalToConstant: 85).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: 109).isActive = true
        imageview.bottomAnchor.constraint(equalTo: viewIn.bottomAnchor, constant: 18).isActive = true
        
        view.addSubview(typeLbl)
        typeLbl.translatesAutoresizingMaskIntoConstraints = false
        typeLbl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        typeLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        typeLbl.heightAnchor.constraint(equalToConstant: 32).isActive = true
        typeLbl.widthAnchor.constraint(equalToConstant: 124).isActive = true
        
        return view
    }()
    
    // selecciona tu Carrera label
    var selectionCareerLbl : UILabel = {
        let label = UILabel()
        label.text = "Selecciona tu Carrera"
        label.textAlignment = .center
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Regular", size: 20)
        return label
    }()
    
    var selectedUniversity = "ies-UNI"
    var selectedCareer  = "Ing. Computacion"
    var date : String?
    var iesCareers = ["Arquitectura","Ing. Civil", "Ing. Computacion", "Ing. Industrial", "Ing. Sistemas", "Ing. Telecomunicaciones"]
    var careersPicker : UIPickerView = {
        var picker = UIPickerView()
        picker.layer.borderWidth = 1
        picker.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        picker.layer.masksToBounds = false
        picker.layer.cornerRadius = 10
        picker.clipsToBounds = true
        var rotationAngle = -90 * (Double.pi/180)
        picker.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
        picker.tintColor = UIColor.white
        return picker
    }()
    
    // carnet textfield
    var idCodeTxtF : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Utilities().darkBlueColor
        textField.attributedPlaceholder = NSAttributedString(string: "Codigo ID de tu carnet Universitario",
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
    
    //  Sign In label
    var signInLbl : UILabel = {
        let label = UILabel()
        label.backgroundColor = Utilities().lightBlueColor
        label.text = "Registrarse"
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
    
    //  message Label
    var messageLbl : UILabel = {
        let label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "Si quieres colaborar con tus profesores y compañeros, pidele a la administracion de tu universidad que se ponga en contacto con nosotros"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 20)
        return label
    }()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.backgroundColor = utilities.darkBlueColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(logoIV)
        scrollView.addSubview(profileImageContainer)
        profileImageContainer.addSubview(profileImageView)
        profileImageContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProfileImagePicker)))
        profileImageContainer.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProfileImagePicker)))
        profileImageView.isUserInteractionEnabled = true
        scrollView.addSubview(fLbl)
        scrollView.addSubview(selectionLbl)
        scrollView.addSubview(nameTxtF)
        nameTxtF.delegate = self
        scrollView.addSubview(givenNamesTxtF)
        givenNamesTxtF.delegate = self
        scrollView.addSubview(datePicker)
        scrollView.addSubview(emailTxtF)
        emailTxtF.delegate = self
        scrollView.addSubview(phoneTxtF)
        phoneTxtF.delegate = self
        phoneTxtF.addDoneButtonToKeyboard(myAction:  #selector(self.phoneTxtF.resignFirstResponder))
        scrollView.addSubview(selectionUniLbl)
        scrollView.addSubview(iesV)
        scrollView.addSubview(otherUniV)
        iesV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(iesSelectedHandler)))
        iesV.isUserInteractionEnabled = true
        otherUniV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(otherSelectedHandler)))
        otherUniV.isUserInteractionEnabled = true
        scrollView.addSubview(selectionCareerLbl)
        scrollView.addSubview(careersPicker)
        careersPicker.delegate = self
        careersPicker.dataSource = self
        careersPicker.selectRow(2, inComponent: 0, animated: true)
        scrollView.addSubview(idCodeTxtF)
        idCodeTxtF.delegate = self
        scrollView.addSubview(signInLbl)
        signInLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(signInHandler)))
        signInLbl.isUserInteractionEnabled = true
        scrollView.addSubview(LogInLbl)
        LogInLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logInHandler)))
        LogInLbl.isUserInteractionEnabled = true
        scrollView.addSubview(messageLbl)
        messageLbl.alpha = 0
        setupLayout()
    }
    
    private func setupLayout () {
        //Logo
        logoIV.translatesAutoresizingMaskIntoConstraints = false
        logoIV.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 27).isActive = true
        logoIV.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        logoIV.widthAnchor.constraint(equalToConstant: 312).isActive = true
        logoIV.heightAnchor.constraint(equalToConstant: 109).isActive = true
        // Profile image container
        profileImageContainer.translatesAutoresizingMaskIntoConstraints = false
        profileImageContainer.topAnchor.constraint(equalTo: logoIV.bottomAnchor, constant: 0).isActive = true
        profileImageContainer.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        profileImageContainer.widthAnchor.constraint(equalToConstant: 119).isActive = true
        profileImageContainer.heightAnchor.constraint(equalToConstant: 119).isActive = true
        //  Profile Image View
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.centerXAnchor.constraint(equalTo: profileImageContainer.centerXAnchor, constant: 0).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 93).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 88).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: profileImageContainer.bottomAnchor, constant: 0).isActive = true
        // facebook
        fLbl.translatesAutoresizingMaskIntoConstraints = false
        fLbl.leftAnchor.constraint(equalTo: profileImageContainer.rightAnchor, constant: 70).isActive = true
        fLbl.heightAnchor.constraint(equalToConstant: 60).isActive = true
        fLbl.widthAnchor.constraint(equalToConstant: 60).isActive = true
        fLbl.topAnchor.constraint(equalTo: logoIV.bottomAnchor, constant: 35).isActive = true
        // selecciona tu foto de perfil label
        selectionLbl.translatesAutoresizingMaskIntoConstraints = false
        selectionLbl.topAnchor.constraint(equalTo: profileImageContainer.bottomAnchor, constant: 10).isActive = true
        selectionLbl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        selectionLbl.widthAnchor.constraint(equalToConstant: 245).isActive = true
        selectionLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // name textfield
        nameTxtF.translatesAutoresizingMaskIntoConstraints = false
        nameTxtF.topAnchor.constraint(equalTo: selectionLbl.bottomAnchor, constant: 10).isActive = true
        nameTxtF.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        nameTxtF.widthAnchor.constraint(equalToConstant: 383).isActive = true
        nameTxtF.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // given name textfield
        givenNamesTxtF.translatesAutoresizingMaskIntoConstraints = false
        givenNamesTxtF.topAnchor.constraint(equalTo: nameTxtF.bottomAnchor, constant: 10).isActive = true
        givenNamesTxtF.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        givenNamesTxtF.widthAnchor.constraint(equalToConstant: 383).isActive = true
        givenNamesTxtF.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // date picker textfield
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: givenNamesTxtF.bottomAnchor, constant: 10).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        datePicker.widthAnchor.constraint(equalToConstant: 383).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 160).isActive = true
        // given name textfield
        emailTxtF.translatesAutoresizingMaskIntoConstraints = false
        emailTxtF.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10).isActive = true
        emailTxtF.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        emailTxtF.widthAnchor.constraint(equalToConstant: 383).isActive = true
        emailTxtF.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // given name textfield
        phoneTxtF.translatesAutoresizingMaskIntoConstraints = false
        phoneTxtF.topAnchor.constraint(equalTo: emailTxtF.bottomAnchor, constant: 10).isActive = true
        phoneTxtF.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        phoneTxtF.widthAnchor.constraint(equalToConstant: 383).isActive = true
        phoneTxtF.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // selecciona universidad label
        selectionUniLbl.translatesAutoresizingMaskIntoConstraints = false
        selectionUniLbl.topAnchor.constraint(equalTo: phoneTxtF.bottomAnchor, constant: 0).isActive = true
        selectionUniLbl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        selectionUniLbl.widthAnchor.constraint(equalToConstant: 383).isActive = true
        selectionUniLbl.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // ies view
        iesV.translatesAutoresizingMaskIntoConstraints = false
        iesV.topAnchor.constraint(equalTo: selectionUniLbl.bottomAnchor, constant: 10).isActive = true
        iesV.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -100).isActive = true
        iesV.widthAnchor.constraint(equalToConstant: 119).isActive = true
        iesV.heightAnchor.constraint(equalToConstant: 119).isActive = true
        // other university view
        otherUniV.translatesAutoresizingMaskIntoConstraints = false
        otherUniV.topAnchor.constraint(equalTo: selectionUniLbl.bottomAnchor, constant: 10).isActive = true
        otherUniV.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 100).isActive = true
        otherUniV.widthAnchor.constraint(equalToConstant: 119).isActive = true
        otherUniV.heightAnchor.constraint(equalToConstant: 119).isActive = true
        // selecciona Carrera label
        selectionCareerLbl.translatesAutoresizingMaskIntoConstraints = false
        selectionCareerLbl.topAnchor.constraint(equalTo: otherUniV.bottomAnchor, constant: 10).isActive = true
        selectionCareerLbl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        selectionCareerLbl.widthAnchor.constraint(equalToConstant: 383).isActive = true
        selectionCareerLbl.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // careers picker view
        careersPicker.translatesAutoresizingMaskIntoConstraints = false
        careersPicker.topAnchor.constraint(equalTo: selectionCareerLbl.bottomAnchor, constant: -145).isActive = true
        careersPicker.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        careersPicker.widthAnchor.constraint(equalToConstant: 80).isActive = true
        careersPicker.heightAnchor.constraint(equalToConstant: 390).isActive = true
        // id code textfield
        idCodeTxtF.translatesAutoresizingMaskIntoConstraints = false
        idCodeTxtF.topAnchor.constraint(equalTo: careersPicker.bottomAnchor, constant: -125).isActive = true
        idCodeTxtF.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        idCodeTxtF.widthAnchor.constraint(equalToConstant: 383).isActive = true
        idCodeTxtF.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // Sign in label
        signInLbl.translatesAutoresizingMaskIntoConstraints = false
        signInLbl.topAnchor.constraint(equalTo: idCodeTxtF.bottomAnchor, constant: 15).isActive = true
        signInLbl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        signInLbl.widthAnchor.constraint(equalToConstant: 383).isActive = true
        signInLbl.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // log in label
        LogInLbl.translatesAutoresizingMaskIntoConstraints = false
        LogInLbl.topAnchor.constraint(equalTo: signInLbl.bottomAnchor, constant: 15).isActive = true
        LogInLbl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        LogInLbl.widthAnchor.constraint(equalToConstant: 120).isActive = true
        LogInLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // message label
        messageLbl.translatesAutoresizingMaskIntoConstraints = false
        messageLbl.topAnchor.constraint(equalTo: iesV.bottomAnchor, constant: 30).isActive = true
        messageLbl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        messageLbl.widthAnchor.constraint(equalToConstant: 390).isActive = true
        messageLbl.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        print("Dia: \(Calendar.current.component(.day       , from: picker.date)), Mes: \(Calendar.current.component(.month, from: picker.date)), Año: \(Calendar.current.component(.year, from: picker.date))")
        date = "Dia: \(Calendar.current.component(.day       , from: picker.date)), Mes: \(Calendar.current.component(.month, from: picker.date)), Año: \(Calendar.current.component(.year, from: picker.date))"
    }
    
    @objc func iesSelectedHandler () {
        print("ies")
        otherUniV.layer.borderWidth = 1
        otherUniV.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        iesV.layer.borderWidth = 4
        iesV.layer.borderColor = #colorLiteral(red: 0.4039215686, green: 0.5019607843, blue: 0.6235294118, alpha: 1)
        selectedUniversity = "ies-UNI"
        UIView.animate(withDuration: 0.5, animations: {
            self.messageLbl.alpha = 0
        }) { (completed) in
            if completed {
                UIView.animate(withDuration: 0.5, animations: {
                    self.selectionCareerLbl.alpha = 1
                    self.careersPicker.alpha = 1
                    self.idCodeTxtF.alpha = 1
                })
            }
        }
    }
    
    @objc func otherSelectedHandler () {
        print("other")
        iesV.layer.borderWidth = 1
        iesV.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        otherUniV.layer.borderWidth = 4
        otherUniV.layer.borderColor = #colorLiteral(red: 0.4039215686, green: 0.5019607843, blue: 0.6235294118, alpha: 1)
        selectedUniversity = "other"
        UIView.animate(withDuration: 0.5, animations: {
            self.selectionCareerLbl.alpha = 0
            self.careersPicker.alpha = 0
            self.idCodeTxtF.alpha = 0
        }) { (completed) in
            if completed {
                UIView.animate(withDuration: 0.5, animations: {
                    self.messageLbl.alpha = 1
                })
            }
        }
    }
    
    @objc func signInHandler () {
        guard self.nameTxtF.text != nil && self.nameTxtF.text != "" else {
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            nameTxtF.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.1568627451, blue: 0.1058823529, alpha: 1)
            utilities.littleDownMovement(view: nameTxtF)
            return
        }
        guard self.givenNamesTxtF.text != nil && self.givenNamesTxtF.text != "" else {
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            givenNamesTxtF.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.1568627451, blue: 0.1058823529, alpha: 1)
            nameTxtF.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
            utilities.littleDownMovement(view: givenNamesTxtF)
            return
        }
        guard date != nil else {
            scrollView.setContentOffset(CGPoint(x: 0, y: 300), animated: true)
            givenNamesTxtF.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
            datePicker.layer.borderWidth = 1
            datePicker.layer.masksToBounds = false
            datePicker.layer.cornerRadius = 10
            datePicker.clipsToBounds = true
            datePicker.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.1568627451, blue: 0.1058823529, alpha: 1)
            utilities.littleDownMovement(view: datePicker)
            return
        }
        guard self.emailTxtF.text != nil && self.emailTxtF.text != "" else {
            scrollView.setContentOffset(CGPoint(x: 0, y: 400), animated: true)
            datePicker.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
            datePicker.layer.borderWidth = 0
            emailTxtF.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.1568627451, blue: 0.1058823529, alpha: 1)
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
            scrollView.setContentOffset(CGPoint(x: 0, y: 400), animated: true)
            emailTxtF.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
            phoneTxtF.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.1568627451, blue: 0.1058823529, alpha: 1)
            utilities.littleDownMovement(view: phoneTxtF)
            return
        }
        if selectedUniversity != "other" {
            guard self.idCodeTxtF.text != nil && self.idCodeTxtF.text != "" else {
                phoneTxtF.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
                idCodeTxtF.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.1568627451, blue: 0.1058823529, alpha: 1)
                utilities.littleDownMovement(view: idCodeTxtF)
                return
            }
            // All data recolected with university
            print("University: \(selectedUniversity), Carreer: \(selectedCareer), idCode; \(idCodeTxtF.text!)")
            print("Name: \(nameTxtF.text!), GivenName: \(givenNamesTxtF.text!), BornDate: \(date!), email: \(emailTxtF.text!), phone: \(phoneTxtF.text!)")
            let modalStyle = UIModalTransitionStyle.crossDissolve
            let vc = RegistrationProfessorViewController()
            vc.modalTransitionStyle = modalStyle
            self.present(vc, animated: true, completion: nil)
        } else {
            // All data recolected without university
            print("University: \(selectedUniversity)")
            print("Name: \(nameTxtF.text!), GivenName: \(givenNamesTxtF.text!), BornDate: \(date!), email: \(emailTxtF.text!), phone: \(phoneTxtF.text!)")
            let modalStyle = UIModalTransitionStyle.crossDissolve
            let vc = RegistrationProfessorViewController()
            vc.modalTransitionStyle = modalStyle
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    @objc func logInHandler () {
        print("Log in")
        let modalStyle = UIModalTransitionStyle.crossDissolve
        let vc = ViewController()
        vc.modalTransitionStyle = modalStyle
        self.present(vc, animated: true, completion: nil)
    }
    
    // Handler imagepicker
    @objc func handleProfileImagePicker () {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @objc func facebookHandler () {
        print("Facebook")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.nameTxtF.resignFirstResponder()
        self.givenNamesTxtF.resignFirstResponder()
        self.emailTxtF.resignFirstResponder()
        self.phoneTxtF.resignFirstResponder()
        self.idCodeTxtF.resignFirstResponder()
    }

}

extension RegistrationStudentViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTxtF.resignFirstResponder()
        givenNamesTxtF.resignFirstResponder()
        emailTxtF.resignFirstResponder()
        phoneTxtF.resignFirstResponder()
        idCodeTxtF.resignFirstResponder()
        return true
    }
}

extension RegistrationStudentViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return iesCareers.count
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 80
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 170
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 170, height: 80))
        let label = UILabel(frame: CGRect(x: 5, y: 0, width: 160, height: 80))
        label.text = iesCareers[row]
        label.textAlignment = .center
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Regular", size: 20)
        label.adjustsFontSizeToFitWidth = true
        view.addSubview(label)
        let rotationAngle = 90 * (Double.pi/180)
        view.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
        return view
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected Career : \(iesCareers[row])")
    }
}

extension UITextField{
    
    func addDoneButtonToKeyboard(myAction:Selector?){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.blackOpaque
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: myAction)
        done.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: Utilities().whiteColor, NSAttributedStringKey.font : UIFont(name: "AvenirNext-Regular", size: 20) as Any], for: .normal)
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
}
extension RegistrationStudentViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var SelectedImage : UIImage!
        if let EditedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            SelectedImage = EditedImage
        } else if let OriginalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            SelectedImage = OriginalImage
        }
        if let image = SelectedImage {
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.image = image
            profileImageView.frame.size.height = profileImageContainer.frame.height
            profileImageView.frame.size.width = profileImageContainer.frame.width
            profileImageView.frame.origin.y -= 25
            profileImageView.frame.origin.x -= 16
        }
        dismiss(animated: true, completion: nil)
    }
}
