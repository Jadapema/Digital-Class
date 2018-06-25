//
//  MenuView.swift
//  Digital Class
//
//  Created by Celina Martinez on 12/6/18.
//  Copyright © 2018 Jadapema. All rights reserved.
//

import UIKit
import FirebaseAuth

class MenuView : UIView {
    
    var label : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "V 1.0.0 \n @Jadapema"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = Utilities().lightBlueColor
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 16)
        return label
    }()
    
    //  top view
    var topView : UIView = {
        var topView = UIView(frame: CGRect(x: 0, y: 0, width: 415, height: 60))
        let separator = UIView()
        topView.addSubview(separator)
        topView.backgroundColor = Utilities().darkBlueColor
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        separator.centerXAnchor.constraint(equalTo: topView.centerXAnchor, constant: 0).isActive = true
        separator.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 0).isActive = true
        separator.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: 0).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separator.backgroundColor = Utilities().lightBlueColor
        return topView
    }()
    
    var profileImage : UIImageView = {
       var imageView = UIImageView()
        imageView.backgroundColor = Utilities().darkBlueColor
        imageView.layer.borderColor = Utilities().lightBlueColor.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "me")
        return imageView
    }()
    
    var nameLbl : UILabel = {
       var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "Jacob Peralta"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return label
    }()
    
    var universityLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "UNI-ies"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Utilities().lightBlueColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return label
    }()
    
    var menuOptionsTV : UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = Utilities().darkBlueColor
//        tableView.separatorStyle = .none
        tableView.separatorColor = Utilities().lightBlueColor
        tableView.tableFooterView = UIView()
        
        return tableView
    }()
    
    var homeViewController : HomeViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
//        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logOutHandler)))
//        label.isUserInteractionEnabled = true
        backgroundColor = Utilities().darkBlueColor
        addSubview(topView)
        topView.addSubview(profileImage)
        topView.addSubview(nameLbl)
        topView.addSubview(universityLbl)
        addSubview(menuOptionsTV)
        menuOptionsTV.delegate = self
        menuOptionsTV.dataSource = self
        menuOptionsTV.register(chatCell.self, forCellReuseIdentifier: "menuOption")
        setupLayout()
    }
    
    func setupLayout () {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        profileImage.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 10).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.topAnchor.constraint(equalTo: topView.topAnchor, constant: 5).isActive = true
        nameLbl.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10).isActive = true
        nameLbl.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -10).isActive = true
        nameLbl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        universityLbl.translatesAutoresizingMaskIntoConstraints = false
        universityLbl.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -5).isActive = true
        universityLbl.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10).isActive = true
        universityLbl.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -5).isActive = true
        universityLbl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        menuOptionsTV.translatesAutoresizingMaskIntoConstraints = false
        menuOptionsTV.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        menuOptionsTV.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        menuOptionsTV.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        menuOptionsTV.bottomAnchor.constraint(equalTo: label.topAnchor).isActive = true
        
    }
    
    @objc func logOutHandler () {
        do {
            try Auth.auth().signOut()
        } catch let LogoutError {
            print("Error al salir de la sesion \(LogoutError)")
        }
        
        let modalStyle = UIModalTransitionStyle.crossDissolve
        let vc = ViewController()
        vc.modalTransitionStyle = modalStyle
        homeViewController?.present(vc, animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = menuOptionsTV.dequeueReusableCell(withIdentifier: "menuOption", for: indexPath) as! chatCell
        if indexPath.row == 0 {
            cell.nameLbl.text = "Configuracion"
            cell.profileIV.image = #imageLiteral(resourceName: "configuration")
            cell.profileIV.layer.cornerRadius = 0
            cell.profileIV.clipsToBounds = false
            cell.profileIV.backgroundColor = UIColor.clear
            cell.profileIV.contentMode = .scaleAspectFit
        } else if indexPath.row == 1 {
            cell.nameLbl.text = "Reportar un error"
            cell.profileIV.image = #imageLiteral(resourceName: "alert")
            cell.profileIV.layer.cornerRadius = 0
            cell.profileIV.clipsToBounds = false
            cell.profileIV.backgroundColor = UIColor.clear
            cell.profileIV.contentMode = .scaleAspectFit
        } else {
            cell.nameLbl.text = "Cerrar cesion"
            cell.profileIV.image = #imageLiteral(resourceName: "logout")
            cell.profileIV.layer.cornerRadius = 0
            cell.profileIV.clipsToBounds = false
            cell.profileIV.backgroundColor = UIColor.clear
            cell.profileIV.contentMode = .scaleAspectFit
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            logOutHandler()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
        
    }
    
}

