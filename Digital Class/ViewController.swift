//
//  ViewController.swift
//  Digital Class
//
//  Created by Celina Martinez on 7/6/18.
//  Copyright © 2018 Jadapema. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    let utilities = Utilities()
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // My logo
    var logoIV : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logo")
        return imageView
    }()
    
    // First Textfield
    var userTxtF : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Utilities().darkBlueColor
        textField.attributedPlaceholder = NSAttributedString(string: "Email",
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
    
    //  Second Textfield
    var passTxtF : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Utilities().darkBlueColor
        textField.attributedPlaceholder = NSAttributedString(string: "••••••••••",
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
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        return textField
    }()
    
    //  Login label
    var logInLbl : UILabel = {
        let label = UILabel()
        label.backgroundColor = Utilities().lightBlueColor
        label.text = "Iniciar Sesion"
        label.textAlignment = .center
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        label.layer.masksToBounds = false
        label.layer.cornerRadius = 30
        label.clipsToBounds = true
        return label
    }()
    
    // Facebook Label
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
    
    //  Registrarse Label
    var signInLbl : UILabel = {
        let label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "Registrarse"
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
        
        self.view.addSubview(logoIV)
        self.view.addSubview(userTxtF)
        userTxtF.delegate = self
        self.view.addSubview(passTxtF)
        passTxtF.delegate = self
        self.view.addSubview(logInLbl)
        logInLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logInHandler)))
        logInLbl.isUserInteractionEnabled = true
        self.view.addSubview(fLbl)
        fLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(facebookHandler)))
        fLbl.isUserInteractionEnabled = true
        self.view.addSubview(signInLbl)
        signInLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(signInHandler)))
        signInLbl.isUserInteractionEnabled = true
        setupLayout()
    }

    private func setupLayout () {
        //Logo
        logoIV.translatesAutoresizingMaskIntoConstraints = false
        logoIV.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 27).isActive = true
        logoIV.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        logoIV.widthAnchor.constraint(equalToConstant: 312).isActive = true
        logoIV.heightAnchor.constraint(equalToConstant: 236).isActive = true
        // Username TextField
        userTxtF.translatesAutoresizingMaskIntoConstraints = false
        userTxtF.topAnchor.constraint(equalTo: logoIV.bottomAnchor, constant: 65).isActive = true
        userTxtF.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        userTxtF.widthAnchor.constraint(equalToConstant: 383).isActive = true
        userTxtF.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // Password Textfield
        passTxtF.translatesAutoresizingMaskIntoConstraints = false
        passTxtF.topAnchor.constraint(equalTo: userTxtF.bottomAnchor, constant: 10).isActive = true
        passTxtF.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        passTxtF.widthAnchor.constraint(equalToConstant: 383).isActive = true
        passTxtF.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // Log In Label
        logInLbl.translatesAutoresizingMaskIntoConstraints = false
        logInLbl.topAnchor.constraint(equalTo: passTxtF.bottomAnchor, constant: 40).isActive = true
        logInLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        logInLbl.widthAnchor.constraint(equalToConstant: 383).isActive = true
        logInLbl.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // login with facebook label
        fLbl.translatesAutoresizingMaskIntoConstraints = false
        fLbl.topAnchor.constraint(equalTo: logInLbl.bottomAnchor, constant: 35).isActive = true
        fLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        fLbl.widthAnchor.constraint(equalToConstant: 60).isActive = true
        fLbl.heightAnchor.constraint(equalToConstant: 60).isActive = true
        //  Sign In Label
        signInLbl.translatesAutoresizingMaskIntoConstraints = false
        signInLbl.topAnchor.constraint(equalTo: fLbl.bottomAnchor, constant: 35).isActive = true
        signInLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        signInLbl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        signInLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }

    @objc func logInHandler () {
        print("Log In")
        let modalStyle = UIModalTransitionStyle.crossDissolve
        let vc = HomeViewController()
        vc.modalTransitionStyle = modalStyle
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func facebookHandler () {
        print("Facebook")
    }
    
    @objc func signInHandler () {
        print("Sign In")
        let modalStyle = UIModalTransitionStyle.crossDissolve
        let vc = AcountTypesViewController()
        vc.modalTransitionStyle = modalStyle
        self.present(vc, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.userTxtF.resignFirstResponder()
        self.passTxtF.resignFirstResponder()
    }
    
}
extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userTxtF.resignFirstResponder()
        passTxtF.resignFirstResponder()
        return true
    }
}
