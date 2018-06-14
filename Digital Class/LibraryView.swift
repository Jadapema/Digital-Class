//
//  LibraryView.swift
//  Digital Class
//
//  Created by Celina Martinez on 12/6/18.
//  Copyright © 2018 Jadapema. All rights reserved.
//

import UIKit

class LibraryView : UIView {
    
    //  top view
    var topView : UIView = {
        var topView = UIView(frame: CGRect(x: 0, y: 0, width: 415, height: 40))
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



        let label = UILabel()
        topView.addSubview(label)
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "Biblioteca"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: topView.centerXAnchor, constant: 0).isActive = true
        label.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 0).isActive = true
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return topView
    }()
    
    // left IV
    let leftIV = UIImageView()
    
    // right IV
    let rightIV = UIImageView()
    
    //  line IV
    var lineIV : UIImageView = {
        var imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "libraryLine")
        return imageView
    }()
    
    // empty label
    var emptyLbl : UILabel = {
        let label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "Aun no tienes libros en tu estante, puedes obtener libros explorando las categorias."
        label.textAlignment = .center
        label.numberOfLines = 0 
        label.textColor = Utilities().lightBlueColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 24)
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(emptyLbl)
        backgroundColor = Utilities().darkBlueColor
        addSubview(topView)
        topView.addSubview(leftIV)
        leftIV.image = #imageLiteral(resourceName: "explore_Book")
        leftIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(exploreBookHandler)))
        leftIV.isUserInteractionEnabled = true
        topView.addSubview(rightIV)
        rightIV.image = #imageLiteral(resourceName: "uploadBook")
        rightIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(uploadBookHandler)))
        rightIV.isUserInteractionEnabled = true
        addSubview(lineIV)
        
        setupLayout()
    }
    
    func setupLayout () {
        emptyLbl.translatesAutoresizingMaskIntoConstraints = false
        emptyLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        emptyLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        emptyLbl.widthAnchor.constraint(equalToConstant: 382).isActive = true
        emptyLbl.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        leftIV.translatesAutoresizingMaskIntoConstraints = false
        leftIV.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 10).isActive = true
        leftIV.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 0).isActive = true
        leftIV.widthAnchor.constraint(equalToConstant: 28).isActive = true
        leftIV.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        rightIV.translatesAutoresizingMaskIntoConstraints = false
        rightIV.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -10).isActive = true
        rightIV.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 0).isActive = true
        rightIV.widthAnchor.constraint(equalToConstant: 30).isActive = true
        rightIV.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        lineIV.translatesAutoresizingMaskIntoConstraints = false
        lineIV.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3 ).isActive = true
        lineIV.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 5).isActive = true
        lineIV.widthAnchor.constraint(equalToConstant: 260).isActive = true
        lineIV.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    @objc func exploreBookHandler () {
        print("Explore")
    }
    
    @objc func uploadBookHandler () {
        print("Upload")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
