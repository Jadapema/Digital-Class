//
//  DChatView.swift
//  Digital Class
//
//  Created by Celina Martinez on 12/6/18.
//  Copyright © 2018 Jadapema. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class DChatView : UIView {
    

    var homeController : HomeViewController?
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
        imageView.image = #imageLiteral(resourceName: "flecha")
        return imageView
    }()
    
    //label
    let topLabel : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "DChat"
        label.textAlignment = .center
        //        label.adjustsFontSizeToFitWidth = true
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return label
    }()
    
    // right IV
    let rightIV : UIImageView = {
        var imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "newChat")
        return imageView
    }()
    
    var newChatTV : UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = Utilities().darkBlueColor
        tableView.separatorColor = Utilities().lightBlueColor
        tableView.tableFooterView = UIView()
        return tableView
    }()
   
    var chatsTV : UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = Utilities().darkBlueColor
        tableView.separatorColor = Utilities().lightBlueColor
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    var members : [User] = []
    
    var messages : [Message] = []
    
    var messagesDictionery = [String:Message]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Utilities().darkBlueColor
        addSubview(topView)
        topView.addSubview(leftIV)
        leftIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backNewChatHandler)))
        leftIV.isUserInteractionEnabled = true
        leftIV.isHidden = true
        topView.addSubview(topLabel)
        topView.addSubview(rightIV)
        rightIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(newChatHandler)))
        rightIV.isUserInteractionEnabled = true
        addSubview(newChatTV)
        newChatTV.delegate = self
        newChatTV.dataSource = self
        newChatTV.isHidden = true
        newChatTV.register(chatCell.self, forCellReuseIdentifier: "newchat")
        addSubview(chatsTV)
        chatsTV.delegate = self
        chatsTV.dataSource = self
        chatsTV.register(chatsCell.self, forCellReuseIdentifier: "chat")
        

//        observeMessages()
        observeUserMessages()
        fetchMembers()
        setupLayout()
    }
    
    
    
    
    func setupLayout () {
        leftIV.translatesAutoresizingMaskIntoConstraints = false
        leftIV.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 10).isActive = true
        leftIV.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 0).isActive = true
        leftIV.widthAnchor.constraint(equalToConstant: 28).isActive = true
        leftIV.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        rightIV.translatesAutoresizingMaskIntoConstraints = false
        rightIV.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -10).isActive = true
        rightIV.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 0).isActive = true
        rightIV.widthAnchor.constraint(equalToConstant: 28).isActive = true
        rightIV.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 0).isActive = true
        topLabel.leftAnchor.constraint(equalTo: leftIV.rightAnchor, constant: 5).isActive = true
        topLabel.rightAnchor.constraint(equalTo: rightIV.leftAnchor, constant: -5).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: topView.frame.height - 1).isActive = true
        
        newChatTV.translatesAutoresizingMaskIntoConstraints = false
        newChatTV.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        newChatTV.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        newChatTV.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        newChatTV.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        chatsTV.translatesAutoresizingMaskIntoConstraints = false
        chatsTV.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        chatsTV.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        chatsTV.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        chatsTV.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        
    }
    
    @objc func backNewChatHandler() {
        print("back")
        if chatsTV.isHidden {
            rightIV.frame.size.width -= 5
            rightIV.frame.size.height += 3
            rightIV.frame.origin.x += 5
        }
        newChatTV.isHidden = true
        leftIV.isHidden = true
        chatsTV.isHidden = false
        rightIV.image = #imageLiteral(resourceName: "newChat")
        rightIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(newChatHandler)))
        rightIV.isUserInteractionEnabled = true

    }
    
    @objc func newChatHandler () {
        print("new")
        newChatTV.isHidden = false
        leftIV.isHidden = false
        chatsTV.isHidden = true
        rightIV.image = #imageLiteral(resourceName: "group")
        let rotationAngle = 180 * (Double.pi/180)
        leftIV.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
        rightIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(newGroupHandler)))
        rightIV.isUserInteractionEnabled = true
        rightIV.frame.size.width += 5
        rightIV.frame.size.height -= 3
        rightIV.frame.origin.x -= 5
        
    }
    
    @objc func newGroupHandler () {
        print("group")
    }
    
    func observeUserMessages() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let ref = Database.database().reference().child("user-messages").child(uid)
        ref.observe(.childAdded, with: { (snapshot) in
//            print(snapshot)
            let messageId = snapshot.key
            let messagesReference = Database.database().reference().child("Messages").child(messageId)
            
            messagesReference.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    
                    if let toId = dictionary["toId"] as? String, let fromId = dictionary["fromId"] as? String, let text = dictionary["text"] as? String, let timestamp = dictionary["timestamp"] as? Int {
                        let message = Message()
                        message.toId = toId
                        message.fromId = fromId
                        message.text = text
                        message.timestamp = timestamp
                        
                        if let chatPartnerId = message.chatPartnerId() {
                            self.messagesDictionery[chatPartnerId] = message
                            self.messages = Array(self.messagesDictionery.values)
                            
                            self.messages.sort(by: { (message1, message2) -> Bool in
                                return message1.timestamp! > message2.timestamp!
                            })
                        }
                        
                        self.timer?.invalidate()
//                        print("we just canceled our timer")
                        
                        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.handleReloadTable), userInfo: nil, repeats: false)
//                        print("schedule a table reload in 0.1 sec")
                        
                    }

                }
                
            }, withCancel: nil)
            
        }, withCancel: nil)
    }
    
    var timer: Timer?
    
    @objc func handleReloadTable() {
        //this will crash because of background thread, so lets call this on dispatch_async main thread
        DispatchQueue.main.async(execute: {
//            print("we reloaded the table")
            self.chatsTV.reloadData()
        })
    }

    
    func observeMessages () {
        let ref = Database.database().reference().child("Messages")
        ref.observe(.childAdded, with: { snapshot in
            if let dictionary = snapshot.value as? [String:AnyObject] {
                if let toId = dictionary["toId"] as? String, let fromId = dictionary["fromId"] as? String, let text = dictionary["text"] as? String, let timestamp = dictionary["timestamp"] as? Int {
                    
                    let message = Message()
                    message.toId = toId
                    message.fromId = fromId
                    message.text = text
                    message.timestamp = timestamp
                    
//                    print(message.text)
                    
                    //                self.messages.append(message)
                    
                    self.messagesDictionery[toId] = message
                    self.messages = Array(self.messagesDictionery.values)
                    self.messages.sort(by: { (message1, message2) -> Bool in
                        return message1.timestamp! > message2.timestamp!
                    })
                        
                    
                    
                    DispatchQueue.main.async(execute: {
                        self.chatsTV.reloadData()
                    })
                    
                }
            }
            
        })
    }
    
    func fetchMembers() {
        self.members.removeAll()
        // Esperamos a que se haga un cambio en la base de datos
        Database.database().reference().observe(.value, with: { snapshot in
            //Creamos un diccionario con la base de datos completa
            if let dictionary = snapshot.value as? [String:AnyObject] {
                //Creamos un diccionario con la seccion de los Usuarios
                if let Users = dictionary["Users"] as? Dictionary<String,AnyObject> {
                    //Recorremos la seccion de usuarios con un ciclo para obtener el valor de cada uno
                    for (Key,value) in Users {
                        let UId = Key
                        if let Profile = value["Profile"] as? Dictionary<String,String> {
                            if let Name = Profile["Name"], let ProfileImageUrl = Profile["ProfileImageUrl"], let Email = Profile["Email"] {
                                let user : User = User()
                                user.Name = Name
                                user.Email = Email
                                user.UserId = UId
                                user.isSelected = false
                                user.ProfileImageUrl = ProfileImageUrl
                                if user.UserId == Auth.auth().currentUser?.uid {
                                    
                                } else {
                                    self.members.append(user)
                                }
                                //this will crash because of background thread, so lets use dispatch_async to fix
                                DispatchQueue.main.async(execute: {
                                    //Refrescamos los valores de nuestra tabla
                                    self.newChatTV.reloadData()
                                })
                            }
                        }
                    }
                    
                }
                
            }
            
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DChatView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == newChatTV {
            return members.count
        } else {
            return messages.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == newChatTV {
            let cell = newChatTV.dequeueReusableCell(withIdentifier: "newchat", for: indexPath) as! chatCell
            cell.nameLbl.text = members[indexPath.row].Name
            cell.profileIV.loadImageUsingCacheWithUrlString(members[indexPath.row].ProfileImageUrl)
            return cell
        } else {
            let cell = chatsTV.dequeueReusableCell(withIdentifier: "chat", for: indexPath) as! chatsCell
            cell.message = messages[indexPath.row]
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == newChatTV {
            homeController?.chatV.dChatView = self
            homeController?.chatV.isHidden = false
            homeController?.chatV.setupKeyboardObservers()
            homeController?.chatV.user = members[indexPath.row]
        } else {
            
            let message = messages[indexPath.row]
            
            guard let chatPartnerId = message.chatPartnerId() else {return}
            
            let ref = Database.database().reference().child("Users").child(chatPartnerId)
            ref.observeSingleEvent(of: .value) { (snapshot) in
                guard let dictionary = snapshot.value as? [String:AnyObject] else {return}
                guard let profile = dictionary["Profile"] as? Dictionary<String,AnyObject> else {return}
                
                if let name = profile["Name"] as? String, let email = profile["Email"] as? String, let imageUrl = profile["ProfileImageUrl"] as? String {
                    let user = User()
                    user.Name = name
                    user.Email = email
                    user.UserId = chatPartnerId
                    user.isSelected = false
                    user.ProfileImageUrl = imageUrl
                    
                    self.homeController?.chatV.dChatView = self
                    self.homeController?.chatV.isHidden = false
                    self.homeController?.chatV.setupKeyboardObservers()
                    self.homeController?.chatV.user = user
                }
            }
            
//            homeController?.chatV.messages = messages
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == newChatTV {
            return 55
        } else {
            return 65
        }

    }
    
}

class chatsCell : UITableViewCell {
    
    var m : Message?
    var message : Message? {
        get {
            return m
        }
        set (newMessage) {
            
            m = newMessage
            setupNameAndProfileImage()
            
            lastMessageLbl.text = newMessage?.text
            
            if newMessage?.timestamp != nil {
                let timestampDate = Date(timeIntervalSince1970: Double((newMessage?.timestamp)!))
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm a"
                timeLbl.text = dateFormatter.string(from: timestampDate)
            }

        }
    }
    
    
    
    func setupNameAndProfileImage() {
//        let chatPartnerId: String?
//
//        if m?.fromId == Auth.auth().currentUser?.uid {
//
//            chatPartnerId = message?.toId
//        } else {
//            chatPartnerId = message?.fromId
//        }
        
        
        if let id = m?.chatPartnerId() {
            let ref = Database.database().reference().child("Users").child(id)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    if let profile = dictionary["Profile"] as? Dictionary<String,AnyObject> {
                        self.nameLbl.text = profile["Name"] as? String
                        self.profileIV.loadImageUsingCacheWithUrlString(profile["ProfileImageUrl"] as! String)
                    }
                }
                
            }, withCancel: nil)
        }
    }
    
    var nameLbl : UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return label
    }()
    var lastMessageLbl : UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.textColor = Utilities().lightBlueColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        return label
    }()
    var timeLbl: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 12)
        return label
    }()
    var profileIV : UIImageView = {
        var imageView = UIImageView()
        imageView.layer.borderWidth = 0
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.backgroundColor = Utilities().lightBlueColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    var rightIV = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        //First Call Super
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        self.contentView.backgroundColor = Utilities().darkBlueColor
        addSubview(profileIV)
        addSubview(nameLbl)
        addSubview(rightIV)
        addSubview(lastMessageLbl)
        addSubview(timeLbl)
        rightIV.image = #imageLiteral(resourceName: "flecha")
        
        profileIV.translatesAutoresizingMaskIntoConstraints = false
        profileIV.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        profileIV.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        profileIV.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileIV.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.leftAnchor.constraint(equalTo: profileIV.rightAnchor, constant: 15).isActive = true
        nameLbl.rightAnchor.constraint(equalTo: rightIV.leftAnchor, constant: 10).isActive = true
        nameLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        nameLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        lastMessageLbl.translatesAutoresizingMaskIntoConstraints = false
        lastMessageLbl.leftAnchor.constraint(equalTo: profileIV.rightAnchor, constant: 15).isActive = true
        lastMessageLbl.rightAnchor.constraint(equalTo: rightIV.leftAnchor, constant: 10).isActive = true
        lastMessageLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 0).isActive = true
        lastMessageLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        rightIV.translatesAutoresizingMaskIntoConstraints = false
        rightIV.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        rightIV.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        rightIV.widthAnchor.constraint(equalToConstant: 25).isActive = true
        rightIV.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        timeLbl.translatesAutoresizingMaskIntoConstraints = false
        timeLbl.bottomAnchor.constraint(equalTo: rightIV.topAnchor, constant: 0).isActive = true
        timeLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        timeLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        timeLbl.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class chatCell : UITableViewCell {
    
    var nameLbl : UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return label
    }()
    var profileIV : UIImageView = {
        var imageView = UIImageView()
        imageView.layer.borderWidth = 0
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.backgroundColor = Utilities().lightBlueColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    var rightIV = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        //First Call Super
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        self.contentView.backgroundColor = Utilities().darkBlueColor
        addSubview(profileIV)
        addSubview(nameLbl)
        addSubview(rightIV)
        rightIV.image = #imageLiteral(resourceName: "flecha")
        
        profileIV.translatesAutoresizingMaskIntoConstraints = false
        profileIV.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        profileIV.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        profileIV.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileIV.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.leftAnchor.constraint(equalTo: profileIV.rightAnchor, constant: 15).isActive = true
        nameLbl.rightAnchor.constraint(equalTo: rightIV.leftAnchor, constant: 10).isActive = true
        nameLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        nameLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        rightIV.translatesAutoresizingMaskIntoConstraints = false
        rightIV.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        rightIV.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        rightIV.widthAnchor.constraint(equalToConstant: 25).isActive = true
        rightIV.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
