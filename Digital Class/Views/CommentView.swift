//
//  CommentView.swift
//  Digital Class
//
//  Created by Celina Martinez on 21/6/18.
//  Copyright © 2018 Jadapema. All rights reserved.
//

import UIKit

class CommentView: UIView {

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
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hidde)))
        view.isUserInteractionEnabled = true
        return view
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
    
    var topLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.textAlignment = .center
        label.text = "Las Animaciones en un plano 2D gdfgdfgdfgdfg"
        label.textColor = Utilities().whiteColor
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return label
    }()
    
    //    comments CV
    var commentsCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0.5
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.allowsMultipleSelection = false
        collection.backgroundColor = Utilities().lightBlueColor
        return collection
    }()
    
    var bottomView : UIView = {
        var bottomView = UIView()
        let separator = UIView(frame: CGRect(x: 0, y: 0, width: 415, height: 0.5))
        bottomView.addSubview(separator)
        bottomView.backgroundColor = Utilities().darkBlueColor
        separator.backgroundColor = Utilities().lightBlueColor
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
        containerView.addSubview(topLbl)
        containerView.addSubview(commentsCV)
        commentsCV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hiddeKeyboardHandler)))
        commentsCV.isUserInteractionEnabled = true
        commentsCV.delegate = self
        commentsCV.dataSource = self
        commentsCV.register(activityCVCell.self, forCellWithReuseIdentifier: "activity")
        commentsCV.register(commentsCVCell.self, forCellWithReuseIdentifier: "comment")
        
        addSubview(bottomView)
        bottomView.addSubview(sendIV)
        sendIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendHandler)))
        sendIV.isUserInteractionEnabled = true
        bottomView.addSubview(messageTF)
        messageTF.delegate = self
        
        setupKeyboardObservers()
        setupLayout()
    }
    
    var containerTopAnchor : NSLayoutConstraint?
    var containerViewBottomAnchor: NSLayoutConstraint?
    func setupLayout () {
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bgView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bgView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerTopAnchor =  containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: (self.frame.height - 78) + 80)
        containerTopAnchor?.isActive = true
        containerView.heightAnchor.constraint(equalToConstant: self.frame.height - 78).isActive = true
        containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -2).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 2).isActive = true
        
        topLbl.translatesAutoresizingMaskIntoConstraints = false
        topLbl.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        topLbl.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20).isActive = true
        topLbl.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20).isActive = true
        topLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        commentsCV.translatesAutoresizingMaskIntoConstraints = false
        commentsCV.topAnchor.constraint(equalTo: topLbl.bottomAnchor).isActive = true
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
                    self.containerTopAnchor?.constant -= self.frame.height - 78
                    self.layoutIfNeeded()
                }
            }
        }

    }
    
    @objc func hidde () {
        print("hidde")
      
        UIView.animate(withDuration: 0.3, animations: {
            self.containerTopAnchor?.constant += self.frame.height - 78
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
        comments.append(messageTF.text!)
        messageTF.text = nil
        commentsCV.reloadData()
        commentsCV.scrollToItem(at: NSIndexPath(item: comments.count , section: 0) as IndexPath, at: .centeredVertically, animated: true)
    }
    
    @objc func hiddeKeyboardHandler () {
        print("Collection")
        self.messageTF.resignFirstResponder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CommentView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = commentsCV.dequeueReusableCell(withReuseIdentifier: "activity", for: indexPath) as! activityCVCell
            cell.homeVC = self.homeViewController
            cell.commentView.isUserInteractionEnabled = false
            cell.separatorLbl.isHidden = true
            cell.classLbl.isHidden = true
            cell.themeLbl.isHidden = true
            return cell
        } else {
            let cell = commentsCV.dequeueReusableCell(withReuseIdentifier: "comment", for: indexPath) as! commentsCVCell
            cell.commentLbl.text = comments[indexPath.row - 1]
            cell.commentV = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: commentsCV.frame.width, height: 400)
        } else {
            var height: CGFloat = 100
            //get estimated height somehow????
            height = estimateFrameForText(comments[indexPath.item - 1]).height + 60
            return CGSize(width: commentsCV.frame.width, height: height)
        }
    }
}

class commentsCVCell : UICollectionViewCell {
    
    var commentV : CommentView?
    
    var topView : UIView = {
        var topView = UIView()
        topView.backgroundColor = Utilities().darkBlueColor
        return topView
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
    
    var commentLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.textAlignment = .left
        label.textColor = Utilities().whiteColor
        label.numberOfLines = 0
        label.font = UIFont(name: "AvenirNext-Regular", size: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Utilities().darkBlueColor
        addSubview(topView)
        
        topView.addSubview(profileIV)
        topView.addSubview(nameLbl)
        topView.addSubview(timeLbl)
        topView.addSubview(moreIV)
        addSubview(commentLbl)
        
        setupLayout()
    }
    

    func setupLayout () {
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // profile
        profileIV.translatesAutoresizingMaskIntoConstraints = false
        profileIV.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        profileIV.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 10).isActive = true
        profileIV.heightAnchor.constraint(equalToConstant: 32).isActive = true
        profileIV.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        // name
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.topAnchor.constraint(equalTo: topView.topAnchor, constant: 7).isActive = true
        nameLbl.leftAnchor.constraint(equalTo: profileIV.rightAnchor, constant: 5).isActive = true
        nameLbl.rightAnchor.constraint(equalTo: moreIV.leftAnchor, constant: -5).isActive = true
        nameLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
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
        
        commentLbl.translatesAutoresizingMaskIntoConstraints = false
        commentLbl.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        commentLbl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        commentLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        commentLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CommentView : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.sendHandler()
        return true
    }
}
