//
//  ClassView.swift
//  Digital Class
//
//  Created by Celina Martinez on 22/6/18.
//  Copyright © 2018 Jadapema. All rights reserved.
//

import UIKit

class ClassView: UIView {

    var homeViewController : HomeViewController?
    
    lazy var bgView : UIView = {
        var view = UIView()
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 1
        view.addSubview(blurEffectView)
        view.alpha = 0
        return view
    }()
    
    lazy var closeIV : UIImageView = {
        var imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "exit")
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hidde)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    var containerView : UIView = {
        var view = UIView()
        view.backgroundColor = Utilities().darkBlueColor
        view.layer.borderWidth = 2
        view.layer.borderColor = Utilities().lightBlueColor.cgColor
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 50
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    var dragView : UIView = {
        var view = UIView()
        view.backgroundColor = Utilities().darkBlueColor
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 50
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        var bar = UIView()
        bar.layer.cornerRadius = 2
        bar.clipsToBounds = true
        bar.backgroundColor = Utilities().lightBlueColor
        view.addSubview(bar)
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        bar.widthAnchor.constraint(equalToConstant: 200).isActive = true
        bar.heightAnchor.constraint(equalToConstant: 4).isActive = true
        return view
    }()
    
    var topLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.text = "Programacaion Grafica"
        label.textColor = Utilities().whiteColor
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        label.alpha = 0
        return label
    }()
    
    // profile
    let profileIV : UIImageView = {
        var imageView = UIImageView()
        imageView.layer.borderColor = Utilities().lightBlueColor.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.backgroundColor = Utilities().darkBlueColor
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "profe")
        return imageView
    }()
    
    var fixedClassNameLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.text = "Programacion Grafica"
        label.textColor = Utilities().whiteColor
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "AvenirNext-Regular", size: 20)
        return label
    }()
    
    var professorNameLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.text = "Ing. Aracelli Torres"
        label.textColor = Utilities().whiteColor
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "AvenirNext-Regular", size: 12)
        return label
    }()
    
    var universityNameLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.text = "UNI - ies"
        label.textColor = Utilities().whiteColor
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 20)
        return label
    }()
    
    var groupNameLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.text = "3T1-CO"
        label.textColor = Utilities().whiteColor
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 20)
        return label
    }()
    
    let starStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = UILayoutConstraintAxis.horizontal
        stack.distribution = UIStackViewDistribution.equalSpacing
        stack.alignment = UIStackViewAlignment.center
        stack.spacing = 0
        
        for t in 1...5 {
            var imageView = UIImageView()
            imageView.image = #imageLiteral(resourceName: "star")
            imageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
            stack.addArrangedSubview(imageView)
        }
        
        return stack
    }()
    
    let subMenuStack : UIStackView = {
        let types = ["Temas","Compañeros","Comentarios"]
        let stack = UIStackView()
        stack.axis = UILayoutConstraintAxis.horizontal
        stack.distribution = UIStackViewDistribution.equalSpacing
        stack.alignment = UIStackViewAlignment.center
        
        for t in types {
            let label = UILabel()
            label.text = t
            label.textAlignment = .center
            label.textColor = Utilities().lightBlueColor
            label.backgroundColor = Utilities().darkBlueColor
            label.font = UIFont(name: "AvenirNext-Medium", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.widthAnchor.constraint(equalToConstant: 125).isActive = true
            label.heightAnchor.constraint(equalToConstant: 30).isActive = true
//            label.backgroundColor = .red
            stack.addArrangedSubview(label)
        }
        let e = stack.arrangedSubviews[0] as! UILabel
        e.textColor = Utilities().whiteColor
        
        return stack
    }()
    
    let subMenuDownBar : UIView = {
        var view = UIView()
        view.backgroundColor = Utilities().whiteColor
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 1
        view.clipsToBounds = true
        return view
    }()
    
    var themesTV : UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = Utilities().darkBlueColor
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        
        return tableView
    }()
    
    var selectedSubSection = 0
    
    //    comments CV
    var commentsCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0.5
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.allowsMultipleSelection = false
        collection.backgroundColor = Utilities().darkBlueColor
        collection.alpha = 0
        return collection
    }()
    
    var bottomView : UIView = {
        var bottomView = UIView()
        let separator = UIView(frame: CGRect(x: 0, y: 0, width: 415, height: 0.5))
        bottomView.addSubview(separator)
        bottomView.backgroundColor = Utilities().darkBlueColor
        separator.backgroundColor = Utilities().lightBlueColor
        bottomView.alpha = 0
        return bottomView
    }()
    
    // send
    let sendIV : UIImageView = {
        var imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "enviar")
        imageView.backgroundColor = Utilities().darkBlueColor
        return imageView
    }()
    
    let messageTF : UITextField = {
        var textField = UITextField()
        textField.keyboardAppearance = .dark
        textField.layer.borderColor = Utilities().lightBlueColor.cgColor
        textField.layer.borderWidth = 1
        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 5
        textField.clipsToBounds = true
        textField.textColor = Utilities().whiteColor
        textField.attributedPlaceholder = NSAttributedString(string: "Escribe un mensaje...",
                                                             attributes: [NSAttributedStringKey.foregroundColor: Utilities().lightBlueColor, NSAttributedStringKey.font : UIFont(name: "AvenirNext-Medium", size: 16) as Any])
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextFieldViewMode.always
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        addSubview(containerView)
        bgView.addSubview(closeIV)
        containerView.addSubview(dragView)
        dragView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:))))
        bgView.addSubview(topLbl)
        bgView.addSubview(profileIV)
        bgView.addSubview(fixedClassNameLbl)
        bgView.addSubview(professorNameLbl)
        bgView.addSubview(universityNameLbl)
        bgView.addSubview(groupNameLbl)
        bgView.addSubview(starStack)
        
        containerView.addSubview(subMenuStack)
        subMenuStack.arrangedSubviews[0].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(themesHandler)))
        subMenuStack.arrangedSubviews[0].isUserInteractionEnabled = true
        subMenuStack.arrangedSubviews[1].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(classmatesHandler)))
        subMenuStack.arrangedSubviews[1].isUserInteractionEnabled = true
        subMenuStack.arrangedSubviews[2].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(commentsHandler)))
        subMenuStack.arrangedSubviews[2].isUserInteractionEnabled = true
        containerView.addSubview(subMenuDownBar)
        
        containerView.addSubview(themesTV)
        themesTV.delegate = self
        themesTV.dataSource = self
        themesTV.register(classTVCell.self, forCellReuseIdentifier: "theme")
        themesTV.register(themeTVCell.self, forCellReuseIdentifier: "title")
        
        containerView.addSubview(commentsCV)
        commentsCV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hiddeKeyboardHandler)))
        commentsCV.isUserInteractionEnabled = true
        commentsCV.delegate = self
        commentsCV.dataSource = self
        commentsCV.register(commentsCVCell.self, forCellWithReuseIdentifier: "comment")
        commentsCV.isHidden = true
        
        
        addSubview(bottomView)
        bottomView.isHidden = true
        bottomView.addSubview(sendIV)
        sendIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendHandler)))
        sendIV.isUserInteractionEnabled = true
        bottomView.addSubview(messageTF)
        messageTF.delegate = self
        
        setupKeyboardObservers()
        
        setupLayout()
    }
    
    var containerTopAnchor : NSLayoutConstraint?
    var subMenuDownBarCenterXAnchor : NSLayoutConstraint?
    var subMenuDownBarWidthAnchor : NSLayoutConstraint?
    var containerViewBottomAnchor: NSLayoutConstraint?
    
    func setupLayout () {
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bgView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bgView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerTopAnchor =  containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: (self.frame.height - 168) + 170)
        containerTopAnchor?.isActive = true
        containerView.heightAnchor.constraint(equalToConstant: self.frame.height - 38).isActive = true
        containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -2).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 2).isActive = true
        
        closeIV.translatesAutoresizingMaskIntoConstraints = false
        closeIV.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: -10).isActive = true
        closeIV.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 10).isActive = true
        closeIV.widthAnchor.constraint(equalToConstant: 20).isActive = true
        closeIV.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        dragView.translatesAutoresizingMaskIntoConstraints = false
        dragView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        dragView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        dragView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        dragView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        topLbl.translatesAutoresizingMaskIntoConstraints = false
        topLbl.topAnchor.constraint(equalTo: bgView.topAnchor).isActive = true
        topLbl.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: 5).isActive = true
        topLbl.rightAnchor.constraint(equalTo: closeIV.leftAnchor, constant: -5).isActive = true
        topLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        profileIV.translatesAutoresizingMaskIntoConstraints = false
        profileIV.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: -20).isActive = true
        profileIV.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 50).isActive = true
        profileIV.widthAnchor.constraint(equalToConstant: 70).isActive = true
        profileIV.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        professorNameLbl.translatesAutoresizingMaskIntoConstraints = false
        professorNameLbl.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: -10).isActive = true
        professorNameLbl.topAnchor.constraint(equalTo: profileIV.bottomAnchor, constant: 10).isActive = true
        professorNameLbl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        professorNameLbl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        fixedClassNameLbl.translatesAutoresizingMaskIntoConstraints = false
        fixedClassNameLbl.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 50).isActive = true
        fixedClassNameLbl.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: 10).isActive = true
        fixedClassNameLbl.rightAnchor.constraint(equalTo: profileIV.leftAnchor, constant: -5).isActive = true
        fixedClassNameLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        universityNameLbl.translatesAutoresizingMaskIntoConstraints = false
        universityNameLbl.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: 10).isActive = true
        universityNameLbl.topAnchor.constraint(equalTo: fixedClassNameLbl.bottomAnchor, constant: 0).isActive = true
        universityNameLbl.widthAnchor.constraint(equalTo: fixedClassNameLbl.widthAnchor, multiplier: 0.5).isActive = true
        universityNameLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        groupNameLbl.translatesAutoresizingMaskIntoConstraints = false
        groupNameLbl.rightAnchor.constraint(equalTo: profileIV.leftAnchor, constant: 5).isActive = true
        groupNameLbl.topAnchor.constraint(equalTo: fixedClassNameLbl.bottomAnchor, constant: 0).isActive = true
        groupNameLbl.widthAnchor.constraint(equalTo: fixedClassNameLbl.widthAnchor, multiplier: 0.5).isActive = true
        groupNameLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        starStack.translatesAutoresizingMaskIntoConstraints = false
        starStack.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: 10).isActive = true
        starStack.topAnchor.constraint(equalTo: universityNameLbl.bottomAnchor, constant: 10).isActive = true
        starStack.widthAnchor.constraint(equalToConstant: 100).isActive = true
        starStack.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        subMenuStack.translatesAutoresizingMaskIntoConstraints = false
        subMenuStack.topAnchor.constraint(equalTo: dragView.bottomAnchor, constant: 10).isActive = true
        subMenuStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        subMenuStack.heightAnchor.constraint(equalToConstant: 20).isActive = true
        subMenuStack.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9 ).isActive = true
        
        subMenuDownBar.translatesAutoresizingMaskIntoConstraints = false
        subMenuDownBarCenterXAnchor = subMenuDownBar.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: -125)
        subMenuDownBarCenterXAnchor?.isActive = true
        subMenuDownBar.topAnchor.constraint(equalTo: subMenuStack.bottomAnchor, constant: 0).isActive = true
        subMenuDownBarWidthAnchor = subMenuDownBar.widthAnchor.constraint(equalToConstant: 30)
        subMenuDownBarWidthAnchor?.isActive = true
        subMenuDownBar.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        themesTV.translatesAutoresizingMaskIntoConstraints = false
        themesTV.topAnchor.constraint(equalTo: subMenuStack.bottomAnchor, constant: 7).isActive = true
        themesTV.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        themesTV.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        themesTV.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        commentsCV.translatesAutoresizingMaskIntoConstraints = false
        commentsCV.topAnchor.constraint(equalTo: subMenuStack.bottomAnchor, constant: 7).isActive = true
        commentsCV.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        commentsCV.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 2).isActive = true
        commentsCV.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -2).isActive = true
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        containerViewBottomAnchor = bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        containerViewBottomAnchor?.isActive = true
        //        bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        bottomView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        bottomView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        sendIV.translatesAutoresizingMaskIntoConstraints = false
        sendIV.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -10).isActive = true
        sendIV.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: 0).isActive = true
        sendIV.widthAnchor.constraint(equalToConstant: 25).isActive = true
        sendIV.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        messageTF.translatesAutoresizingMaskIntoConstraints = false
        messageTF.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 5).isActive = true
        messageTF.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -5).isActive = true
        messageTF.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 5).isActive = true
        messageTF.rightAnchor.constraint(equalTo: sendIV.leftAnchor, constant: -10).isActive = true
        
    }
    
    func show () {
        print("show")
        self.isHidden = false
        
        UIView.animate(withDuration: 0.2, animations: {
            self.bgView.alpha = 1
        }) { (completed) in
            if completed {
                
                UIView.animate(withDuration: 0.3) {
                    self.containerTopAnchor?.constant -= self.frame.height - 168
                    self.layoutIfNeeded()
                }
            }
        }
        
    }
    
    @objc func hidde () {
        print("hidde")
        
        
        
        UIView.animate(withDuration: 0.3, animations: {
            self.containerTopAnchor?.constant += self.frame.height - 168
            self.layoutIfNeeded()
            
        }) { (comp) in
            if comp {
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.bgView.alpha = 0
                }) { (completed) in
                    if completed {
                        self.isHidden = true
                    }
                }
                
            }
        }
    }
    
    var pinPosition : CGFloat = 170
    
    @objc func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: self)
        let velocityInView = panGesture.velocity(in: self)
        
        switch panGesture.state {
        case .began:
            pinPosition = (containerTopAnchor?.constant)!
            
            break
        case .changed:
            if Int((containerTopAnchor?.constant)!) <= 170 && Int((containerTopAnchor?.constant)!) >= 40 {
                    containerTopAnchor?.constant = pinPosition + translation.y
            } else {
                panGesture.isEnabled = false
                if Int((containerTopAnchor?.constant)!) > 170 {
                    containerTopAnchor?.constant = 170
                    print("Down!")
                    hiddeTopLbl()
                } else if Int((containerTopAnchor?.constant)!) < 40 {
                    containerTopAnchor?.constant = 40
                    print("Up!")
                    showTopLbl()
                }
            }
            
            break
        case .cancelled:
            panGesture.isEnabled = true
            break
            
        case .ended:
            
            if Int((containerTopAnchor?.constant)!) >= 105 {
                print("DOWN!")
                hiddeTopLbl()
                UIView.animate(withDuration: 0.5) {
                    self.containerTopAnchor?.constant = 170
                    self.layoutIfNeeded()
                }
            } else if Int((containerTopAnchor?.constant)!) < 105 {
                print("UP!")
                showTopLbl()
                UIView.animate(withDuration: 0.5) {
                    self.containerTopAnchor?.constant = 40
                    self.layoutIfNeeded()
                }
            }
            break
        default:
            break
        }
    }
    
    func showTopLbl () {
        UIView.animate(withDuration: 0.5) {
            self.topLbl.alpha = 1
        }
    }
    
    func hiddeTopLbl () {
        UIView.animate(withDuration: 0.5) {
            self.topLbl.alpha = 0
        }
    }

    func setStars (stars : Int) {
        if (stars - 1) >= 0 && (stars - 1) <= 4 || stars == 0 {
            for s in 0...starStack.arrangedSubviews.count - 1 {
                let starIV = starStack.arrangedSubviews[s] as! UIImageView
                if stars != 0 {
                    print(stars)
                    if s <= (stars - 1) {
                        starIV.image = #imageLiteral(resourceName: "star")
                    } else {
                        starIV.image = #imageLiteral(resourceName: "star-empty")
                    }
                } else {
                    starIV.image = #imageLiteral(resourceName: "star-empty")
                }
            }
        }
    }
    
    @objc func themesHandler () {
        
        switch selectedSubSection {
        case 1:
            setStateSelected(i: 0)
            subMenuDownBarCenterXAnchor?.constant -= 125
            subMenuDownBarWidthAnchor?.constant -= 30
            UIView.animate(withDuration: 0.5) {
                self.layoutIfNeeded()
            }
            return
        case 2:
            setStateSelected(i: 0)
            subMenuDownBarCenterXAnchor?.constant -= 250
            subMenuDownBarWidthAnchor?.constant -= 30
            UIView.animate(withDuration: 0.5) {
                self.layoutIfNeeded()
            }
            return
        default:
            print("default")
        }
        
    }
    
    @objc func classmatesHandler () {
        switch selectedSubSection {
        case 0:
            setStateSelected(i: 1)
            subMenuDownBarCenterXAnchor?.constant += 125
            subMenuDownBarWidthAnchor?.constant += 30
            UIView.animate(withDuration: 0.5) {
                self.layoutIfNeeded()
            }
            return
        case 2:
            setStateSelected(i: 1)
            subMenuDownBarCenterXAnchor?.constant -= 125
            UIView.animate(withDuration: 0.5) {
                self.layoutIfNeeded()
            }
            return
        default:
            print("default")
        }
        
    }
    
    @objc func commentsHandler () {
        switch selectedSubSection {
        case 0:
            setStateSelected(i: 2)
            subMenuDownBarCenterXAnchor?.constant += 250
            subMenuDownBarWidthAnchor?.constant += 30
            UIView.animate(withDuration: 0.5) {
                self.layoutIfNeeded()
            }
            return
        case 1:
            setStateSelected(i: 2)
            subMenuDownBarCenterXAnchor?.constant += 125
            UIView.animate(withDuration: 0.5) {
                self.layoutIfNeeded()
            }
            return
        default:
            print("default")
        }
    }
    
    func setStateSelected(i:Int) {
        
        selectedSubSection = i
        
        for v in subMenuStack.arrangedSubviews {
            let label = v as! UILabel
            label.textColor = Utilities().lightBlueColor
        }
        let e = subMenuStack.arrangedSubviews[i] as! UILabel
        e.textColor = Utilities().whiteColor
        
        switch i {
        case 0:
            print("Set to 0")
            UIView.animate(withDuration: 0.5, animations: {
                self.commentsCV.alpha = 0
                self.bottomView.alpha = 0
            }) { (completion) in
                if completion {
                    self.commentsCV.isHidden = true
                    self.bottomView.isHidden = true
                    self.themesTV.isHidden = false
                    UIView.animate(withDuration: 0.5, animations: {
                        self.themesTV.alpha = 1
                    })
                }
            }
            return
        case 1:
            print("Set to 1")
            UIView.animate(withDuration: 0.5, animations: {
                self.themesTV.alpha = 0
                self.commentsCV.alpha = 0
                self.bottomView.alpha = 0
            }) { (completion) in
                if completion {
                    self.themesTV.isHidden = true
                    self.commentsCV.isHidden = true
                    self.bottomView.isHidden = true
//                    self.activityCV.isHidden = false
                    UIView.animate(withDuration: 0.5, animations: {
//                        self.activityCV.alpha = 1
                    })
                }
            }
            
            return
        case 2:
            print("Set to 2")
            UIView.animate(withDuration: 0.5, animations: {
                self.themesTV.alpha = 0
            }) { (completion) in
                if completion {
                    self.themesTV.isHidden = true
                    self.commentsCV.isHidden = false
                    self.bottomView.isHidden = false
                    UIView.animate(withDuration: 0.5, animations: {
                        self.commentsCV.alpha = 1
                        self.bottomView.alpha = 1
                    })
                }
            }
            return
        default:
            return
        }
        
    }
    
    



    
    var comments = ["Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry' standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries","Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry' standard dummy text ever since the 1500s","Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry' standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.","Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'","Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry' standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries","Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry' standard dummy text ever since the 1500s"]
    
    
    private func estimateFrameForText(_ text: String) -> CGRect {
        let size = CGSize(width: self.frame.width - 20, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.foregroundColor: Utilities().whiteColor, NSAttributedStringKey.font : UIFont(name: "AvenirNext-Medium", size: 16) as Any], context: nil)
    }
    
    
    public func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    @objc func handleKeyboardWillShow(_ notification: Notification) {
        print("Show")
        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        
        containerViewBottomAnchor?.constant = -keyboardFrame!.height
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.layoutIfNeeded()
        })
        
    }
    
    @objc func handleKeyboardWillHide(_ notification: Notification) {
        print("HIdde")
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        
        containerViewBottomAnchor?.constant = 0
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.layoutIfNeeded()
        })
    }
    
    @objc func sendHandler () {
        print("send")
        guard messageTF.text != "" && messageTF.text != nil else {print("No message to send");return}
//        print(comments.count)
        comments.append(messageTF.text!)
        messageTF.text = nil
        commentsCV.reloadData()
//        print(comments.count)
        commentsCV.scrollToItem(at: NSIndexPath(item: comments.count - 1 , section: 0) as IndexPath, at: .centeredVertically, animated: true)
    }
    
    @objc func hiddeKeyboardHandler () {
        print("Collection")
        self.messageTF.resignFirstResponder()
    }
    
    struct dataExample {
        var opened = Bool()
        var title = String()
    }
    
    var myData : [dataExample] = [
                                  dataExample(opened: false, title: "Animaciones en un plano 2D"),
                                  dataExample(opened: false, title: "Animaciones en un plano 3D"),
                                  dataExample(opened: false, title: "Sistemas de coordenada JOLG"),
                                  dataExample(opened: false, title: "CMAPS TOOLS")
                                  ]
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ClassView : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return myData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if myData[section].opened == true {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = themesTV.dequeueReusableCell(withIdentifier: "title", for: indexPath) as! themeTVCell
            cell.label.text = myData[indexPath.section].title
            return cell
        } else {
            let cell = themesTV.dequeueReusableCell(withIdentifier: "theme", for: indexPath) as! classTVCell
            cell.homeVC = self.homeViewController
            cell.separatorLbl.isHidden = true
            cell.classLbl.isHidden = true
            cell.themeLbl.isHidden = true
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if myData[indexPath.section].opened == true {
                myData[indexPath.section].opened = false
                let section = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(section, with: .automatic)
            } else {
                myData[indexPath.section].opened = true
                let section = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(section, with: .automatic)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 45
        } else {
            return 400
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 45
//    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let containerView = UIView()
//        containerView.backgroundColor = Utilities().darkBlueColor
//
//        let bgView = UIView()
//        bgView.backgroundColor = Utilities().lightBlueColor
//        bgView.layer.masksToBounds = false
//        bgView.layer.cornerRadius = 25
//        bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        bgView.clipsToBounds = true
//        containerView.addSubview(bgView)
//        bgView.translatesAutoresizingMaskIntoConstraints = false
//        bgView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
//        bgView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
//        bgView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
//        bgView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
//
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 418, height: 50))
//        view.backgroundColor = Utilities().darkBlueColor
//        view.layer.borderColor = Utilities().lightBlueColor.cgColor
//        view.layer.borderWidth = 2
//        view.layer.masksToBounds = false
//        view.layer.cornerRadius = 25
//        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        view.clipsToBounds = true
//        bgView.addSubview(view)
//        let label = UILabel()
//        label.backgroundColor = UIColor.clear
//        label.textAlignment = .center
//        label.text = "Animaciones en el plano 2D"
//        label.textColor = Utilities().whiteColor
//        label.adjustsFontSizeToFitWidth = true
//        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
//        view.addSubview(label)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
//        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
//        label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//
//        return containerView
//    }
    
}

class themeTVCell : UITableViewCell {
    
    
    let bgView = UIView()
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 418, height: 50))
    let label = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        //First Call Super
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        
        selectionStyle = .none
        backgroundColor = Utilities().darkBlueColor
        addSubview(bgView)
        
        bgView.backgroundColor = Utilities().lightBlueColor
        bgView.layer.masksToBounds = false
        bgView.layer.cornerRadius = 25
        bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bgView.clipsToBounds = true
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bgView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        bgView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        

        view.backgroundColor = Utilities().darkBlueColor
        view.layer.borderColor = Utilities().lightBlueColor.cgColor
        view.layer.borderWidth = 2
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        bgView.addSubview(view)

        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.text = "Animaciones en el plano 2D"
        label.textColor = Utilities().whiteColor
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        

    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class classTVCell : UITableViewCell {
    var homeVC : HomeViewController?
    
    var topView : UIView = {
        var topView = UIView()
        topView.backgroundColor = Utilities().darkBlueColor
        return topView
    }()
    
    var bottomView : UIView = {
        var bottomView = UIView()
        bottomView.backgroundColor = Utilities().darkBlueColor
        return bottomView
    }()
    
    //    Items CV
    var itemsCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.allowsMultipleSelection = false
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = Utilities().lightBlueColor
        return collection
    }()
    
    // profile
    var profileIV : UIImageView = {
        var imageView = UIImageView()
        imageView.layer.borderWidth = 0
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.backgroundColor = Utilities().lightBlueColor
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "me")
        return imageView
    }()
    
    var nameLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "Jacob Peralta"
        label.textAlignment = .left
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Regular", size: 14)
        return label
    }()
    
    var classLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "Fisica II"
        label.textAlignment = .left
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Regular", size: 14)
        return label
    }()
    
    var themeLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "Atomos en la fisica"
        label.textAlignment = .left
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Regular", size: 14)
        return label
    }()
    
    var separatorLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "•"
        label.textAlignment = .center
        label.textColor = Utilities().lightBlueColor
        label.font = UIFont(name: "AvenirNext-Regular", size: 18)
        return label
    }()
    var timeLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "1h"
        label.textAlignment = .left
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 10)
        return label
    }()
    
    var moreIV : UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = Utilities().darkBlueColor
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "more")
        return imageView
    }()
    
    //    items indicator CV
    var itemsIndicatorCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 3
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.allowsMultipleSelection = false
        collection.backgroundColor = Utilities().darkBlueColor
        return collection
    }()
    
    lazy var facesView : UIView = {
        var view = UIView()
        view.backgroundColor = Utilities().darkBlueColor
        
        view.addSubview(firstFace)
        firstFace.translatesAutoresizingMaskIntoConstraints = false
        firstFace.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        firstFace.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        firstFace.widthAnchor.constraint(equalToConstant: 20).isActive = true
        firstFace.heightAnchor.constraint(equalToConstant: 20).isActive = true
        firstFace.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(firstFaceHandler)))
        firstFace.isUserInteractionEnabled = true
        
        view.addSubview(secondFace)
        secondFace.translatesAutoresizingMaskIntoConstraints = false
        secondFace.leftAnchor.constraint(equalTo: firstFace.rightAnchor, constant: 10).isActive = true
        secondFace.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        secondFace.widthAnchor.constraint(equalToConstant: 20).isActive = true
        secondFace.heightAnchor.constraint(equalToConstant: 20).isActive = true
        secondFace.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(secondFaceHandler)))
        secondFace.isUserInteractionEnabled = true
        
        view.addSubview(thirdFace)
        thirdFace.translatesAutoresizingMaskIntoConstraints = false
        thirdFace.leftAnchor.constraint(equalTo: secondFace.rightAnchor, constant: 10).isActive = true
        thirdFace.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        thirdFace.widthAnchor.constraint(equalToConstant: 20).isActive = true
        thirdFace.heightAnchor.constraint(equalToConstant: 20).isActive = true
        thirdFace.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(thirdFaceHandler)))
        thirdFace.isUserInteractionEnabled = true
        
        view.addSubview(firstLbl)
        firstLbl.translatesAutoresizingMaskIntoConstraints = false
        firstLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        firstLbl.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        firstLbl.bottomAnchor.constraint(equalTo: firstFace.topAnchor).isActive = true
        firstLbl.widthAnchor.constraint(equalToConstant: 20).isActive = true
        firstLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(firstFaceHandler)))
        firstLbl.isUserInteractionEnabled = true
        
        view.addSubview(secondLbl)
        secondLbl.translatesAutoresizingMaskIntoConstraints = false
        secondLbl.leftAnchor.constraint(equalTo: firstLbl.rightAnchor, constant: 10).isActive = true
        secondLbl.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        secondLbl.bottomAnchor.constraint(equalTo: secondFace.topAnchor).isActive = true
        secondLbl.widthAnchor.constraint(equalToConstant: 20).isActive = true
        secondLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(secondFaceHandler)))
        secondLbl.isUserInteractionEnabled = true
        
        view.addSubview(thirdLbl)
        thirdLbl.translatesAutoresizingMaskIntoConstraints = false
        thirdLbl.leftAnchor.constraint(equalTo: secondLbl.rightAnchor, constant: 10).isActive = true
        thirdLbl.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        thirdLbl.bottomAnchor.constraint(equalTo: thirdFace.topAnchor).isActive = true
        thirdLbl.widthAnchor.constraint(equalToConstant: 20).isActive = true
        thirdLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(thirdFaceHandler)))
        thirdLbl.isUserInteractionEnabled = true
        
        return view
    }()
    
    var firstLbl : UILabel = {
        var label = UILabel()
        label.text = "7"
        label.textColor = Utilities().lightBlueColor
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 10)
        return label
    }()
    
    var secondLbl : UILabel = {
        var label = UILabel()
        label.text = "9"
        label.textColor = Utilities().lightBlueColor
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 10)
        return label
    }()
    
    var thirdLbl : UILabel = {
        var label = UILabel()
        label.text = "2"
        label.textColor = Utilities().lightBlueColor
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 10)
        return label
    }()
    
    var firstFace : UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = Utilities().darkBlueColor
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "feliz")
        return imageView
    }()
    
    var secondFace : UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = Utilities().darkBlueColor
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "esceptico")
        return imageView
    }()
    
    var thirdFace : UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = Utilities().darkBlueColor
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "triste")
        return imageView
    }()
    
    lazy var commentView : UIView = {
        var view = UIView()
        view.backgroundColor = Utilities().darkBlueColor
        var commentLbl : UILabel = {
            var label = UILabel()
            label.text = "Comentar"
            label.textColor = Utilities().lightBlueColor
            label.textAlignment = .right
            label.font = UIFont(name: "AvenirNext-Medium", size: 13)
            return label
        }()
        
        var commentIV : UIImageView = {
            var imageView = UIImageView()
            imageView.backgroundColor = Utilities().darkBlueColor
            imageView.contentMode = .scaleAspectFit
            imageView.image = #imageLiteral(resourceName: "comentario")
            return imageView
        }()
        
        view.addSubview(commentIV)
        commentIV.translatesAutoresizingMaskIntoConstraints = false
        commentIV.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        commentIV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        commentIV.widthAnchor.constraint(equalToConstant: 20).isActive = true
        commentIV.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        view.addSubview(commentLbl)
        commentLbl.translatesAutoresizingMaskIntoConstraints = false
        commentLbl.leftAnchor.constraint(equalTo: commentIV.rightAnchor).isActive = true
        commentLbl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        commentLbl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        commentLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        view.addSubview(commentCountLbl)
        commentCountLbl.translatesAutoresizingMaskIntoConstraints = false
        commentCountLbl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        commentCountLbl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        commentCountLbl.bottomAnchor.constraint(equalTo: commentLbl.topAnchor).isActive = true
        commentCountLbl.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        return view
        
        
    }()
    
    var commentCountLbl : UILabel = {
        var label = UILabel()
        label.text = "6 Comentarios"
        label.textColor = Utilities().lightBlueColor
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 10)
        return label
    }()
    
    lazy var shareView : UIView = {
        var view = UIView()
        view.backgroundColor = Utilities().darkBlueColor
        var commentLbl : UILabel = {
            var label = UILabel()
            label.text = "Compartir"
            label.textColor = Utilities().lightBlueColor
            label.textAlignment = .right
            label.font = UIFont(name: "AvenirNext-Medium", size: 13)
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shareHandler)))
            label.isUserInteractionEnabled = true
            return label
        }()
        
        var commentIV : UIImageView = {
            var imageView = UIImageView()
            imageView.backgroundColor = Utilities().darkBlueColor
            imageView.contentMode = .scaleAspectFit
            imageView.image = #imageLiteral(resourceName: "share")
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shareHandler)))
            imageView.isUserInteractionEnabled = true
            return imageView
        }()
        
        view.addSubview(commentIV)
        commentIV.translatesAutoresizingMaskIntoConstraints = false
        commentIV.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        commentIV.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        commentIV.widthAnchor.constraint(equalToConstant: 20).isActive = true
        commentIV.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        view.addSubview(commentLbl)
        commentLbl.translatesAutoresizingMaskIntoConstraints = false
        commentLbl.leftAnchor.constraint(equalTo: commentIV.rightAnchor).isActive = true
        commentLbl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        commentLbl.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        commentLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        
        return view
        
    }()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        //First Call Super
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        backgroundColor = Utilities().darkBlueColor
        addSubview(topView)
        addSubview(bottomView)
        addSubview(itemsCV)
        itemsCV.delegate = self
        itemsCV.dataSource = self
        itemsCV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "item")
        
        topView.addSubview(profileIV)
        topView.addSubview(nameLbl)
        topView.addSubview(themeLbl)
        topView.addSubview(classLbl)
        topView.addSubview(separatorLbl)
        topView.addSubview(timeLbl)
        topView.addSubview(moreIV)
        
        bottomView.addSubview(itemsIndicatorCV)
        itemsIndicatorCV.delegate = self
        itemsIndicatorCV.dataSource = self
        itemsIndicatorCV.register(itemsIndicatorCVCell.self, forCellWithReuseIdentifier: "itemIndicator")
        
        bottomView.addSubview(facesView)
        bottomView.addSubview(commentView)
        bottomView.addSubview(shareView)
        
        
        shareView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shareHandler)))
        shareView.isUserInteractionEnabled = true
        
        commentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(commentHandler)))
        commentView.isUserInteractionEnabled = true
        
        setupLayout()
    }
    
    func setupLayout () {
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bottomView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        itemsCV.translatesAutoresizingMaskIntoConstraints = false
        itemsCV.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        itemsCV.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        itemsCV.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        itemsCV.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        
        // profile
        profileIV.translatesAutoresizingMaskIntoConstraints = false
        profileIV.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        profileIV.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 10).isActive = true
        profileIV.heightAnchor.constraint(equalToConstant: 32).isActive = true
        profileIV.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        // separator
        separatorLbl.translatesAutoresizingMaskIntoConstraints = false
        separatorLbl.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: -8).isActive = true
        separatorLbl.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        separatorLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        separatorLbl.widthAnchor.constraint(equalToConstant: 8).isActive = true
        
        // name
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.topAnchor.constraint(equalTo: topView.topAnchor, constant: 7).isActive = true
        nameLbl.leftAnchor.constraint(equalTo: profileIV.rightAnchor, constant: 5).isActive = true
        nameLbl.rightAnchor.constraint(equalTo: separatorLbl.leftAnchor, constant: -5).isActive = true
        nameLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // class
        classLbl.translatesAutoresizingMaskIntoConstraints = false
        classLbl.topAnchor.constraint(equalTo: topView.topAnchor, constant: 7).isActive = true
        classLbl.leftAnchor.constraint(equalTo: separatorLbl.rightAnchor, constant: 5).isActive = true
        classLbl.rightAnchor.constraint(equalTo: moreIV.leftAnchor, constant: -5).isActive = true
        classLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // more
        moreIV.translatesAutoresizingMaskIntoConstraints = false
        moreIV.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        moreIV.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -10).isActive = true
        moreIV.heightAnchor.constraint(equalToConstant: 25).isActive = true
        moreIV.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        // time
        timeLbl.translatesAutoresizingMaskIntoConstraints = false
        timeLbl.leftAnchor.constraint(equalTo: profileIV.rightAnchor, constant: 5).isActive = true
        timeLbl.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -5).isActive = true
        timeLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        timeLbl.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        // theme
        themeLbl.translatesAutoresizingMaskIntoConstraints = false
        themeLbl.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -5).isActive = true
        themeLbl.leftAnchor.constraint(equalTo: timeLbl.rightAnchor, constant: 5).isActive = true
        themeLbl.rightAnchor.constraint(equalTo: moreIV.leftAnchor, constant: -5).isActive = true
        themeLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        itemsIndicatorCV.translatesAutoresizingMaskIntoConstraints = false
        itemsIndicatorCV.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 2).isActive = true
        itemsIndicatorCV.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 2).isActive = true
        itemsIndicatorCV.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -2).isActive = true
        itemsIndicatorCV.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        facesView.translatesAutoresizingMaskIntoConstraints = false
        facesView.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 5).isActive = true
        facesView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -5).isActive = true
        facesView.topAnchor.constraint(equalTo: itemsIndicatorCV.bottomAnchor, constant: 2).isActive = true
        facesView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        commentView.translatesAutoresizingMaskIntoConstraints = false
        commentView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
        commentView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        commentView.topAnchor.constraint(equalTo: itemsIndicatorCV.bottomAnchor, constant: 2).isActive = true
        commentView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        shareView.translatesAutoresizingMaskIntoConstraints = false
        shareView.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -5).isActive = true
        shareView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -5).isActive = true
        shareView.topAnchor.constraint(equalTo: itemsIndicatorCV.bottomAnchor, constant: 2).isActive = true
        shareView.widthAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    var itemsCount = 5
    
    @objc func firstFaceHandler () {
        print("first")
        firstLbl.textColor = Utilities().whiteColor
        firstFace.image = #imageLiteral(resourceName: "feliz_selected")
        
        secondLbl.textColor = Utilities().lightBlueColor
        secondFace.image = #imageLiteral(resourceName: "esceptico")
        
        thirdLbl.textColor = Utilities().lightBlueColor
        thirdFace.image = #imageLiteral(resourceName: "triste")
        
    }
    
    @objc func secondFaceHandler () {
        print("second")
        firstLbl.textColor = Utilities().lightBlueColor
        firstFace.image = #imageLiteral(resourceName: "feliz")
        
        secondLbl.textColor = Utilities().whiteColor
        secondFace.image = #imageLiteral(resourceName: "eseptico_selected")
        
        thirdLbl.textColor = Utilities().lightBlueColor
        thirdFace.image = #imageLiteral(resourceName: "triste")
    }
    
    @objc func thirdFaceHandler () {
        print("third")
        firstLbl.textColor = Utilities().lightBlueColor
        firstFace.image = #imageLiteral(resourceName: "feliz")
        
        secondLbl.textColor = Utilities().lightBlueColor
        secondFace.image = #imageLiteral(resourceName: "esceptico")
        
        thirdLbl.textColor = Utilities().whiteColor
        thirdFace.image = #imageLiteral(resourceName: "triste_selected")
    }
    
    @objc func shareHandler () {
        print("share")
        homeVC?.shareV.show()
        
    }
    
    @objc func commentHandler () {
        print("Comment")
        homeVC?.commentV.show()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension classTVCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == itemsCV {
            let cell = itemsCV.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath)
            let colors = [ UIColor.yellow, .red, .green, .blue, .brown]
            cell.backgroundColor = colors[indexPath.item]
            return cell
        } else {
            let cell = itemsIndicatorCV.dequeueReusableCell(withReuseIdentifier: "itemIndicator", for: indexPath) as! itemsIndicatorCVCell
            if indexPath.item == 0 {
                cell.backgroundColor = Utilities().whiteColor
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == itemsCV {
            return CGSize(width: self.frame.width, height: 300)
        } else {
            return CGSize(width: ((collectionView.frame.width - 4) / 5) - 1.5, height: 3)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == itemsIndicatorCV {
            for i in collectionView.indexPathsForVisibleItems {
                let cell = itemsIndicatorCV.cellForItem(at: i) as! itemsIndicatorCVCell
                cell.backgroundColor = Utilities().lightBlueColor
            }
            
            let cell = itemsIndicatorCV.cellForItem(at: indexPath) as! itemsIndicatorCVCell
            cell.backgroundColor = Utilities().whiteColor
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print(targetContentOffset.pointee.x / self.frame.width)
        
        let indexpath = NSIndexPath(item: Int(targetContentOffset.pointee.x / self.frame.width), section: 0)
        itemsIndicatorCV.selectItem(at: indexpath as IndexPath, animated: true, scrollPosition: .centeredHorizontally)
        collectionView(itemsIndicatorCV, didSelectItemAt: indexpath as IndexPath)
    }
}

extension ClassView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = commentsCV.dequeueReusableCell(withReuseIdentifier: "comment", for: indexPath) as! commentsCVCell
            cell.commentLbl.text = comments[indexPath.row ]
//            cell.commentV = self
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
            var height: CGFloat = 100
            //get estimated height somehow????
            height = estimateFrameForText(comments[indexPath.item]).height + 60
            return CGSize(width: commentsCV.frame.width, height: height)
        
    }
}
extension ClassView : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.sendHandler()
        return true
    }
}
