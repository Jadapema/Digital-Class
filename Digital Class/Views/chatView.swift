//
//  chatView.swift
//  Digital Class
//
//  Created by Celina Martinez on 16/6/18.
//  Copyright © 2018 Jadapema. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class chatView : UIView {
    
    var topView : UIView = {
        var topView = UIView(frame: CGRect(x: 0, y: 0, width: 415, height: 40))
        let separator = UIView()
        topView.addSubview(separator)
        topView.backgroundColor = Utilities().darkBlueColor
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        separator.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 0).isActive = true
        separator.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: 0).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separator.backgroundColor = Utilities().lightBlueColor
        return topView
    }()
    
    // left chat IV
    let leftIV : UIImageView = {
        var imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "flecha")
        let rotationAngle = 180 * (Double.pi/180)
        imageView.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
        return imageView
    }()
    
    // profile
    let profileIV : UIImageView = {
        var imageView = UIImageView()
        imageView.layer.borderWidth = 0
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.backgroundColor = Utilities().lightBlueColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //label top chat
    let nameLabel : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.text = "jacob"
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return label
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
    
    //    messages cv
    var messagesCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.allowsMultipleSelection = false
        collection.alwaysBounceVertical = true
        collection.backgroundColor = Utilities().darkBlueColor
        collection.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 10, right: 0)
        collection.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        collection.isScrollEnabled = true
        return collection
    }()
    
    var newVal : User?
    
    var user : User? {
        get {
            return newVal
        }
        set (newValue) {
            print("Set \(String(describing: newValue?.Name))")
            newVal = newValue
            nameLabel.text = newValue?.Name!
            profileIV.loadImageUsingCacheWithUrlString((newValue?.ProfileImageUrl)!)
            observeMessages()
        }
    }
    
    var dChatView : DChatView?
    var messages : [Message] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Utilities().darkBlueColor
        addSubview(topView)
        topView.addSubview(leftIV)
        leftIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backChatHandler)))
        leftIV.isUserInteractionEnabled = true
        topView.addSubview(nameLabel)
        topView.addSubview(profileIV)
        addSubview(bottomView)
        bottomView.addSubview(sendIV)
        sendIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendHandler)))
        sendIV.isUserInteractionEnabled = true
        bottomView.addSubview(messageTF)
        messageTF.delegate = self
        addSubview(messagesCV)
        messagesCV.delegate = self
        messagesCV.dataSource = self
        messagesCV.register(messagesCVCell.self, forCellWithReuseIdentifier: "buble")
        messagesCV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hiddeKeyboardHandler)))
        messagesCV.isUserInteractionEnabled = true
        setupKeyboardObservers()
        setupLayout()
    }
    
    var containerViewBottomAnchor: NSLayoutConstraint?
    
    func setupLayout () {
        leftIV.translatesAutoresizingMaskIntoConstraints = false
        leftIV.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 10).isActive = true
        leftIV.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 0).isActive = true
        leftIV.widthAnchor.constraint(equalToConstant: 28).isActive = true
        leftIV.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        containerViewBottomAnchor = bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        containerViewBottomAnchor?.isActive = true
//        bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        bottomView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        bottomView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        profileIV.translatesAutoresizingMaskIntoConstraints = false
        profileIV.leftAnchor.constraint(equalTo: leftIV.rightAnchor, constant: 110).isActive = true
        profileIV.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 0).isActive = true
        profileIV.widthAnchor.constraint(equalToConstant: 30).isActive = true
        profileIV.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 0).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -1).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: profileIV.rightAnchor, constant: 10).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: 0).isActive = true
        
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
        
        messagesCV.translatesAutoresizingMaskIntoConstraints = false
        messagesCV.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        messagesCV.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0).isActive = true
        messagesCV.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        messagesCV.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
    }
    
    
    
    public func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
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
    
    @objc func handleKeyboardDidShow(_ notification: Notification) {
        reorderMessages()
    }
    
    
    @objc func backChatHandler() {
        print("Back")
        hiddeKeyboardHandler()
        self.isHidden = true
        dChatView?.backNewChatHandler()
        NotificationCenter.default.removeObserver(self)
        
    }
    
    @objc func sendHandler() {
        print("send")
        guard user != nil else { print("User = nil"); return}
        guard messageTF.text != "" && messageTF.text != nil else {print("No message to send");return}
        

        let timeStamp = Int(Date().timeIntervalSince1970)
        let ref = Database.database().reference().child("Messages").childByAutoId()
        let values : [String:Any] = ["toId" : "\(user!.UserId!)", "fromId" : "\((Auth.auth().currentUser?.uid)!)", "text" : "\(messageTF.text!)", "timestamp" : timeStamp]
        
        self.messageTF.text = nil
        
        ref.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
            
            let userMessageRef = Database.database().reference().child("user-messages").child((Auth.auth().currentUser?.uid)!)
            
            let messageId = ref.key
            userMessageRef.updateChildValues([messageId:1])
            
            let recipientRef = Database.database().reference().child("user-messages").child(self.user!.UserId!)
            recipientRef.updateChildValues([messageId:1])
            
        }
        
    }
    
    func observeMessages() {
        self.messages.removeAll()
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let userMessagesRef = Database.database().reference().child("user-messages").child(uid)
        userMessagesRef.observe(.childAdded, with: { (snapshot) in
            let messageId = snapshot.key
            let messagesRef = Database.database().reference().child("Messages").child(messageId)
            messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard let dictionary = snapshot.value as? [String: AnyObject] else {
                    return
                }
                if let toId = dictionary["toId"] as? String, let fromId = dictionary["fromId"] as? String, let text = dictionary["text"] as? String, let timestamp = dictionary["timestamp"] as? Int {
                    let message = Message()
                    message.toId = toId
                    message.fromId = fromId
                    message.text = text
                    message.timestamp = timestamp
                    message.id = messageId
                    
                    if message.chatPartnerId() == self.user?.UserId {
                        if !self.checkIfMessageIsAdded(messageId: message.id!) {
                            self.messages.append(message)
                            DispatchQueue.main.async(execute: {
                                self.messagesCV.reloadData()
                                self.reorderMessages()
                            })
                        }
                    }
                    
                }
                
                
            }, withCancel: nil)
            
        }, withCancel: nil)
    }
    
    func reorderMessages () {
        
        if messages.count > 0 {
            let indexpath = NSIndexPath(item: self.messages.count - 1, section: 0)
            self.messagesCV.scrollToItem(at: indexpath as IndexPath, at: .centeredVertically, animated: true)
        }

    }
    
    func checkIfMessageIsAdded (messageId : String) -> Bool {
        var isIn = false
        for m in messages {
            if m.id == messageId {
                isIn = true
            }
        }
        return isIn
    }
    
    @objc func newGroupHandler () {
        print("group")
    }
    
    @objc func hiddeKeyboardHandler () {
        print("Collection")
        self.messageTF.resignFirstResponder()
    }
    
    private func estimateFrameForText(_ text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.foregroundColor: Utilities().whiteColor, NSAttributedStringKey.font : UIFont(name: "AvenirNext-Medium", size: 16) as Any], context: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            if touch.view != bottomView && touch.view != sendIV {
                self.messageTF.resignFirstResponder()
            } else {
                print("Es the bottom view!")
                return
            }
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension chatView : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendHandler()
        return true
    }
}

extension chatView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = messagesCV.dequeueReusableCell(withReuseIdentifier: "buble", for: indexPath) as! messagesCVCell
        let message = messages[indexPath.item]
        cell.textView.text = message.text
//        cell.backgroundColor = .blue
        
        if let profileImageUrl = self.user?.ProfileImageUrl {
            cell.profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
        }
        
        if message.fromId == Auth.auth().currentUser?.uid {
            cell.bubbleView.backgroundColor = Utilities().darkBlueColor
            cell.bubbleView.layer.borderWidth = 1
            cell.profileImageView.isHidden = true
            
            cell.bubbleViewRightAnchor?.isActive = true
            cell.bubbleViewLeftAnchor?.isActive = false
        } else {
            cell.bubbleView.backgroundColor = Utilities().lightBlueColor
            cell.bubbleView.layer.borderWidth = 0
            cell.profileImageView.isHidden = false
            
            cell.bubbleViewRightAnchor?.isActive = false
            cell.bubbleViewLeftAnchor?.isActive = true
        }
        
        cell.bubbleWidthAnchor?.constant = estimateFrameForText(message.text!).width + 32
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 80
        
        //get estimated height somehow????
        if let text = messages[indexPath.item].text {
            height = estimateFrameForText(text).height + 20
        }
        
        return CGSize(width: frame.width, height: height)
    }
}

class messagesCVCell : UICollectionViewCell {
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE TEXT FOR NOW"
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isEditable = false
        tv.backgroundColor = UIColor.clear
        tv.textColor = Utilities().whiteColor
        tv.isSelectable = false
        return tv
    }()
    
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = Utilities().lightBlueColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = Utilities().grayColor.cgColor
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "nedstark")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var bubbleWidthAnchor: NSLayoutConstraint?
    var bubbleViewRightAnchor: NSLayoutConstraint?
    var bubbleViewLeftAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bubbleView)
        addSubview(textView)
        addSubview(profileImageView)
        
        //x,y,w,h
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        //x,y,w,h
        
        bubbleViewRightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
        bubbleViewRightAnchor?.isActive = true
        bubbleViewLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8)
        //        bubbleViewLeftAnchor?.active = false
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor?.isActive = true
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        //ios 9 constraints
        //x,y,w,h
        //        textView.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
        //        textView.widthAnchor.constraintEqualToConstant(200).active = true
        textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
