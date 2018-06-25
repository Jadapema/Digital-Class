//
//  ShareView.swift
//  Digital Class
//
//  Created by Celina Martinez on 20/6/18.
//  Copyright © 2018 Jadapema. All rights reserved.
//

import UIKit

class ShareView: UIView {

    lazy var bgView : UIView = {
       var view = UIView()
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.alpha = 0
//        view.backgroundColor = .red
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hidde)))
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var container : UIView = {
        var view = UIView()
        
        view.layer.borderWidth = 1
        view.layer.borderColor = Utilities().whiteColor.cgColor
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1921568627, blue: 0.2470588235, alpha: 0.6994595462)
        
        var shareOneLbl : UILabel = {
            var shareOneLbl = UILabel()
            shareOneLbl.backgroundColor = UIColor.clear
            shareOneLbl.textAlignment = .center
            shareOneLbl.text = "Compartir solamente esto"
            shareOneLbl.textColor = Utilities().whiteColor
            shareOneLbl.font = UIFont(name: "AvenirNext-Medium", size: 16)
            return shareOneLbl
        }()
        
        var separator : UIView = {
            var view = UIView()
            view.backgroundColor = Utilities().whiteColor
            return view
        }()
        
        var shareAllLbl : UILabel = {
            var label = UILabel()
            label.backgroundColor = UIColor.clear
            label.textAlignment = .center
            label.text = "Compartir grupo multimedia"
            label.textColor = Utilities().whiteColor
            label.font = UIFont(name: "AvenirNext-Medium", size: 16)
            
            return label
        }()
        
        view.addSubview(shareOneLbl)
        shareOneLbl.translatesAutoresizingMaskIntoConstraints = false
        shareOneLbl.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        shareOneLbl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        shareOneLbl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        shareOneLbl.heightAnchor.constraint(equalToConstant: 70).isActive = true
        shareOneLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(oneHandler)))
        shareOneLbl.isUserInteractionEnabled = true
        
        view.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        separator.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        separator.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        view.addSubview(shareAllLbl)
        shareAllLbl.translatesAutoresizingMaskIntoConstraints = false
        shareAllLbl.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        shareAllLbl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        shareAllLbl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        shareAllLbl.heightAnchor.constraint(equalToConstant: 70).isActive = true
        shareAllLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(allHandler)))
        shareAllLbl.isUserInteractionEnabled = true
        
        
        return view
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(container)
        container.isUserInteractionEnabled = true
        setupLayout()
    }
    
    func setupLayout () {
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bgView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bgView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        container.translatesAutoresizingMaskIntoConstraints = false
        container.centerYAnchor.constraint(equalTo: bgView.centerYAnchor).isActive = true
        container.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: 20).isActive = true
        container.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: -20).isActive = true
        container.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
    }
    
    func show () {
        print("show")
        self.isHidden = false
        UIView.animate(withDuration: 0.5) {
            self.bgView.alpha = 1
        }
    }
    
    @objc func hidde () {
        print("hidde")
        UIView.animate(withDuration: 0.5, animations: {
            self.bgView.alpha = 0
        }) { (completed) in
            if completed {
                self.isHidden = true
            }
        }
    }
    
    @objc func oneHandler () {
        print("one")
    }
    
    @objc func allHandler () {
        print("all")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
