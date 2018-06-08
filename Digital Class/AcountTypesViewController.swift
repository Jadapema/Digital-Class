//
//  AcountTypesViewController.swift
//  Digital Class
//
//  Created by Celina Martinez on 7/6/18.
//  Copyright © 2018 Jadapema. All rights reserved.
//

import UIKit

class AcountTypesViewController: UIViewController {

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
    // type label
    var questionLbl : UILabel = {
        let label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "Que tipo de cuenta deseas?"
        label.textAlignment = .center
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 24)
        return label
    }()
    //  Login label
    var logInLbl : UILabel = {
        let label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "Iniciar Sesion"
        label.textAlignment = .center
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 20)
        return label
    }()
    // Stack Types
    var typesStack : UIStackView = {
        // stack configuration
        let stack = UIStackView()
        stack.axis = UILayoutConstraintAxis.horizontal
        stack.distribution = UIStackViewDistribution.equalSpacing
        stack.alignment = UIStackViewAlignment.center
        stack.spacing = 5
        // Creating the 3 views with a for
        for i in 0...2 {
            //  Container View
            let view = UIView()
            view.heightAnchor.constraint(equalToConstant: 151).isActive = true
            view.widthAnchor.constraint(equalToConstant: 124).isActive = true
            // The image
            var imageview : UIImageView = {
                let imageView = UIImageView()
                return imageView
            }()
            // Container of Image
            var viewIn : UIView = {
               let viewInSide = UIView()
                viewInSide.backgroundColor = Utilities().darkBlueColor
                viewInSide.layer.borderWidth = 1
                viewInSide.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
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
                return label
            }()
            // Setting the constraints
            view.addSubview(viewIn)
            viewIn.translatesAutoresizingMaskIntoConstraints = false
            viewIn.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            viewIn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
            viewIn.heightAnchor.constraint(equalToConstant: 119).isActive = true
            viewIn.widthAnchor.constraint(equalToConstant: 124).isActive = true
            
            viewIn.addSubview(imageview)
            imageview.translatesAutoresizingMaskIntoConstraints = false
            imageview.centerXAnchor.constraint(equalTo: viewIn.centerXAnchor, constant: 0).isActive = true
            
            view.addSubview(typeLbl)
            typeLbl.translatesAutoresizingMaskIntoConstraints = false
            typeLbl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
            typeLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
            typeLbl.heightAnchor.constraint(equalToConstant: 32).isActive = true
            typeLbl.widthAnchor.constraint(equalToConstant: 124).isActive = true
            
            // Setting the values of individual view
            switch i {
            case 0:
                typeLbl.text = "Estudiante"
                imageview.image = #imageLiteral(resourceName: "student")
                imageview.heightAnchor.constraint(equalToConstant: 93).isActive = true
                imageview.widthAnchor.constraint(equalToConstant: 88).isActive = true
                imageview.bottomAnchor.constraint(equalTo: viewIn.bottomAnchor, constant: 0).isActive = true
                break
            case 1:
                typeLbl.text = "Profesor"
                imageview.image = #imageLiteral(resourceName: "professor")
                imageview.heightAnchor.constraint(equalToConstant: 93).isActive = true
                imageview.widthAnchor.constraint(equalToConstant: 88).isActive = true
                imageview.bottomAnchor.constraint(equalTo: viewIn.bottomAnchor, constant: 0).isActive = true
                break
            case 2:
                typeLbl.text = "Universidad"
                imageview.image = #imageLiteral(resourceName: "university")
                imageview.heightAnchor.constraint(equalToConstant: 85).isActive = true
                imageview.widthAnchor.constraint(equalToConstant: 109).isActive = true
                imageview.bottomAnchor.constraint(equalTo: viewIn.bottomAnchor, constant: 18).isActive = true
                break
            default: break
            }
            // adding to the stack
            stack.addArrangedSubview(view)
        }
        return stack
    }()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.backgroundColor = utilities.darkBlueColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(logoIV)
        self.view.addSubview(questionLbl)
        self.view.addSubview(logInLbl)
        logInLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logInHandler)))
        logInLbl.isUserInteractionEnabled = true
        self.view.addSubview(typesStack)
        typesStack.arrangedSubviews[0].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(studentHandler)))
        typesStack.arrangedSubviews[0].isUserInteractionEnabled = true
        typesStack.arrangedSubviews[1].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(professorHandler)))
        typesStack.arrangedSubviews[1].isUserInteractionEnabled = true
        typesStack.arrangedSubviews[2].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(universityHandler)))
        typesStack.arrangedSubviews[2].isUserInteractionEnabled = true
        setupLayout()
    }

    private func setupLayout () {
        //Logo
        logoIV.translatesAutoresizingMaskIntoConstraints = false
        logoIV.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 27).isActive = true
        logoIV.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        logoIV.widthAnchor.constraint(equalToConstant: 312).isActive = true
        logoIV.heightAnchor.constraint(equalToConstant: 236).isActive = true
        
        //  Question Label
        questionLbl.translatesAutoresizingMaskIntoConstraints = false
        questionLbl.topAnchor.constraint(equalTo: logoIV.bottomAnchor, constant: 70).isActive = true
        questionLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        questionLbl.widthAnchor.constraint(equalToConstant: 320).isActive = true
        questionLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        //  types stack
        typesStack.translatesAutoresizingMaskIntoConstraints = false
        typesStack.topAnchor.constraint(equalTo: questionLbl.bottomAnchor, constant: 70).isActive = true
        typesStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        typesStack.widthAnchor.constraint(equalToConstant: 382).isActive = true
        typesStack.heightAnchor.constraint(equalToConstant: 151).isActive = true
        
        //  Sign In Label
        logInLbl.translatesAutoresizingMaskIntoConstraints = false
        logInLbl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -25).isActive = true
        logInLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        logInLbl.widthAnchor.constraint(equalToConstant: 116).isActive = true
        logInLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    @objc func logInHandler () {
        print("Log In")
    }
    
    @objc func studentHandler () {
        print("Student")
    }
    @objc func professorHandler () {
        print("Professor")
    }
    @objc func universityHandler () {
        print("University")
    }

}
