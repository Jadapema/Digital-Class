//
//  HomeView.swift
//  Digital Class
//
//  Created by Celina Martinez on 12/6/18.
//  Copyright © 2018 Jadapema. All rights reserved.
//

import UIKit

class HomeView : UIView {
    
    var homeViewController : HomeViewController?
    
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
        return topView
    }()
    
    // left IV
    let leftIV : UIImageView = {
        var imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "explorar")
        return imageView
    }()
    
    //label
    let topLabel : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "Inicio"
        label.textAlignment = .center
        //        label.adjustsFontSizeToFitWidth = true
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return label
    }()
    
    let subMenuStack : UIStackView = {
        let types = ["Notificaciones","Actividad","Mis Materias"]
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
            stack.addArrangedSubview(label)
        }
        let e = stack.arrangedSubviews[1] as! UILabel
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
    
    var selectedSubSection = 1
    
    //    Activity CV
    var activityCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.allowsMultipleSelection = false
        collection.backgroundColor = Utilities().lightBlueColor
        return collection
    }()

    //    Classes CV
    var myClassesCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 14
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.allowsMultipleSelection = false
        collection.backgroundColor = Utilities().darkBlueColor
        collection.alpha = 0
        collection.alwaysBounceVertical = true
        collection.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        collection.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Utilities().darkBlueColor
        addSubview(topView)
        topView.addSubview(leftIV)
        leftIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(exploreHandler)))
        leftIV.isUserInteractionEnabled = true
        topView.addSubview(topLabel)
        addSubview(subMenuStack)
        subMenuStack.arrangedSubviews[0].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(notificationsHandler)))
        subMenuStack.arrangedSubviews[0].isUserInteractionEnabled = true
        subMenuStack.arrangedSubviews[1].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(activityHandler)))
        subMenuStack.arrangedSubviews[1].isUserInteractionEnabled = true
        subMenuStack.arrangedSubviews[2].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(myClassesHandler)))
        subMenuStack.arrangedSubviews[2].isUserInteractionEnabled = true
        addSubview(subMenuDownBar)
        
        addSubview(activityCV)
        
        activityCV.delegate = self
        activityCV.dataSource = self
        activityCV.register(activityCVCell.self, forCellWithReuseIdentifier: "activity")
        
        addSubview(myClassesCV)
        myClassesCV.delegate = self
        myClassesCV.dataSource = self
        myClassesCV.register(classCVCell.self, forCellWithReuseIdentifier: "class")
        myClassesCV.isHidden = true
        
        setupLayout()
    }
    
    var subMenuDownBarCenterXAnchor : NSLayoutConstraint?
    var subMenuDownBarWidthAnchor : NSLayoutConstraint?
    
    func setupLayout () {
        leftIV.translatesAutoresizingMaskIntoConstraints = false
        leftIV.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 10).isActive = true
        leftIV.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 0).isActive = true
        leftIV.widthAnchor.constraint(equalToConstant: 28).isActive = true
        leftIV.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 0).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor, constant: 0).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: topView.frame.height - 1).isActive = true
        topLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        subMenuStack.translatesAutoresizingMaskIntoConstraints = false
        subMenuStack.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10).isActive = true
        subMenuStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        subMenuStack.heightAnchor.constraint(equalToConstant: 20).isActive = true
        subMenuStack.widthAnchor.constraint(equalToConstant: self.frame.width - 40).isActive = true
        
        subMenuDownBar.translatesAutoresizingMaskIntoConstraints = false
        subMenuDownBarCenterXAnchor = subMenuDownBar.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 5)
        subMenuDownBarCenterXAnchor?.isActive = true
        subMenuDownBar.topAnchor.constraint(equalTo: subMenuStack.bottomAnchor, constant: 0).isActive = true
        subMenuDownBarWidthAnchor = subMenuDownBar.widthAnchor.constraint(equalToConstant: 50)
        subMenuDownBarWidthAnchor?.isActive = true
        subMenuDownBar.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        activityCV.translatesAutoresizingMaskIntoConstraints = false
        activityCV.topAnchor.constraint(equalTo: subMenuStack.bottomAnchor, constant: 10).isActive = true
        activityCV.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        activityCV.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        activityCV.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        
        myClassesCV.translatesAutoresizingMaskIntoConstraints = false
        myClassesCV.topAnchor.constraint(equalTo: subMenuStack.bottomAnchor, constant: 10).isActive = true
        myClassesCV.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        myClassesCV.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        myClassesCV.rightAnchor.constraint(equalTo:self.rightAnchor, constant: -20).isActive = true
        
    }
    
    @objc func notificationsHandler () {
        
        switch selectedSubSection {
        case 1:
            setStateSelected(i: 0)
            subMenuDownBarCenterXAnchor?.constant -= 145
            subMenuDownBarWidthAnchor?.constant += 20
            UIView.animate(withDuration: 0.5) {
                self.layoutIfNeeded()
            }
            return
        case 2:
            setStateSelected(i: 0)
            subMenuDownBarCenterXAnchor?.constant -= 287
            UIView.animate(withDuration: 0.5) {
                self.layoutIfNeeded()
            }
            return
        default:
            print("default")
        }
        
    }
    
    @objc func activityHandler () {
        switch selectedSubSection {
        case 0:
            setStateSelected(i: 1)
            subMenuDownBarCenterXAnchor?.constant += 145
            subMenuDownBarWidthAnchor?.constant -= 20
            UIView.animate(withDuration: 0.5) {
                self.layoutIfNeeded()
            }
            return
        case 2:
            setStateSelected(i: 1)
            subMenuDownBarCenterXAnchor?.constant -= 142
            subMenuDownBarWidthAnchor?.constant -= 20
            UIView.animate(withDuration: 0.5) {
                self.layoutIfNeeded()
            }
            return
        default:
            print("default")
        }
        
    }
    
    @objc func myClassesHandler () {
        switch selectedSubSection {
        case 0:
            setStateSelected(i: 2)
            subMenuDownBarCenterXAnchor?.constant += 287
            UIView.animate(withDuration: 0.5) {
                self.layoutIfNeeded()
            }
            return
        case 1:
            setStateSelected(i: 2)
            subMenuDownBarCenterXAnchor?.constant += 142
            subMenuDownBarWidthAnchor?.constant += 20
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
                self.activityCV.alpha = 0
                self.myClassesCV.alpha = 0
            }) { (completion) in
                if completion {
                    self.activityCV.isHidden = true
                    self.myClassesCV.isHidden = true
                }
            }
            return
        case 1:
            print("Set to 1")
            UIView.animate(withDuration: 0.5, animations: {
                self.myClassesCV.alpha = 0
            }) { (completion) in
                if completion {
                    self.myClassesCV.isHidden = true
                    self.activityCV.isHidden = false
                    UIView.animate(withDuration: 0.5, animations: {
                        self.activityCV.alpha = 1
                    })
                }
            }
            
            return
        case 2:
            print("Set to 2")
            UIView.animate(withDuration: 0.5, animations: {
                self.activityCV.alpha = 0
            }) { (completion) in
                if completion {
                    self.activityCV.isHidden = true
                    self.myClassesCV.isHidden = false
                    UIView.animate(withDuration: 0.5, animations: {
                        self.myClassesCV.alpha = 1
                    })
                }
            }
            return
        default:
            return
        }
        
    }
    
    @objc func exploreHandler () {
        
    }
    
    func addClass () {
        print("Add Class")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == activityCV {
            let cell = activityCV.dequeueReusableCell(withReuseIdentifier: "activity", for: indexPath) as! activityCVCell
            cell.homeVC = self.homeViewController
            return cell
        } else {
            let cell = myClassesCV.dequeueReusableCell(withReuseIdentifier: "class", for: indexPath) as! classCVCell
//            cell.backgroundColor = .red
            if indexPath.item == 4 {
                cell.setupAddCell()
            } else {
                cell.setStars(stars: indexPath.item)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == myClassesCV {
            if indexPath.item == 4 {
                addClass()
            } else {
                homeViewController?.classV.show()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == activityCV {
            return CGSize(width: self.frame.width, height: 400)
        } else {
            return CGSize(width: 180, height: 90)
        }
    }
}

class activityCVCell : UICollectionViewCell {
    
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
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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

extension activityCVCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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

class itemsCVCell : UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Utilities().darkBlueColor

    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class itemsIndicatorCVCell : UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Utilities().lightBlueColor
        self.layer.cornerRadius = 1.5
        self.clipsToBounds = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class classCVCell : UICollectionViewCell {
    
    var addIV : UIImageView = {
        var imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "add")
        imageView.isHidden = true
        return imageView
    }()
    
    // Class Name
    let classNameLabel : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "Programacion Grafica"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 15)
        return label
    }()
    
    var professorIV : UIImageView = {
        var imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "professor")
        return imageView
    }()
    
    // professor Name
    let professorNameLabel : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "Ing. Jacob Peralta"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 12)
        return label
    }()
    
    // themes Count
    let themesLabel : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "Temas: 15"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 12)
        return label
    }()
    
    // Class Name
    let groupLabel : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "Grupo: 3T1-CO"
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 12)
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Utilities().darkBlueColor
        self.layer.borderColor = Utilities().grayColor.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        addSubview(addIV)
        addSubview(classNameLabel)
        addSubview(professorIV)
        addSubview(professorNameLabel)
        addSubview(themesLabel)
        addSubview(groupLabel)
        addSubview(starStack)
        
        setupLayout()
    }
    
    func setupLayout() {
        addIV.translatesAutoresizingMaskIntoConstraints = false
        addIV.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        addIV.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        addIV.widthAnchor.constraint(equalToConstant: 58).isActive = true
        addIV.heightAnchor.constraint(equalToConstant: 58).isActive = true
        
        classNameLabel.translatesAutoresizingMaskIntoConstraints = false
        classNameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        classNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        classNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        classNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        professorIV.translatesAutoresizingMaskIntoConstraints = false
        professorIV.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        professorIV.topAnchor.constraint(equalTo: classNameLabel.bottomAnchor).isActive = true
        professorIV.widthAnchor.constraint(equalToConstant: 10).isActive = true
        professorIV.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        professorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        professorNameLabel.topAnchor.constraint(equalTo: classNameLabel.bottomAnchor).isActive = true
        professorNameLabel.leftAnchor.constraint(equalTo: professorIV.rightAnchor, constant: 5).isActive = true
        professorNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        professorNameLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        themesLabel.translatesAutoresizingMaskIntoConstraints = false
        themesLabel.topAnchor.constraint(equalTo: professorNameLabel.bottomAnchor, constant: 5).isActive = true
        themesLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        themesLabel.widthAnchor.constraint(equalToConstant: (self.frame.width / 2) - 10).isActive = true
        themesLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        groupLabel.translatesAutoresizingMaskIntoConstraints = false
        groupLabel.topAnchor.constraint(equalTo: professorNameLabel.bottomAnchor, constant: 5).isActive = true
        groupLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        groupLabel.widthAnchor.constraint(equalToConstant: (self.frame.width / 2) - 10).isActive = true
        groupLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        starStack.translatesAutoresizingMaskIntoConstraints = false
        starStack.topAnchor.constraint(equalTo: themesLabel.bottomAnchor).isActive = true
        starStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        starStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        starStack.widthAnchor.constraint(equalToConstant: (self.frame.width / 2) - 10).isActive = true
        
    }
    
    func setupAddCell () {
        addIV.isHidden = false
        classNameLabel.isHidden = true
        professorNameLabel.isHidden = true
        professorIV.isHidden = true
        themesLabel.isHidden = true
        groupLabel.isHidden = true
        starStack.isHidden = true
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
