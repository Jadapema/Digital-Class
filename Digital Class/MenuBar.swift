//
//  Menu.swift
//  Digital Class
//
//  Created by Celina Martinez on 11/6/18.
//  Copyright © 2018 Jadapema. All rights reserved.
//

import UIKit

class MenuBar : UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    var menuCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.allowsMultipleSelection = false
        return collection
    }()
    var separator : UIView = {
       let view = UIView(frame: CGRect(x: 0, y: 0, width: 415, height: 0.5))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Utilities().lightBlueColor
        return view
    }()
    
    var sections = [#imageLiteral(resourceName: "home"), #imageLiteral(resourceName: "library"), #imageLiteral(resourceName: "record"), #imageLiteral(resourceName: "chat"), #imageLiteral(resourceName: "menu")]
    var selectedSections = [#imageLiteral(resourceName: "home_selected"),#imageLiteral(resourceName: "library_selected"),#imageLiteral(resourceName: "record_selected"),#imageLiteral(resourceName: "chat_selected"),#imageLiteral(resourceName: "menu_selected")]
    var homeController : HomeViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init")
        backgroundColor = Utilities().lightBlueColor
        
        menuCollection.delegate = self
        menuCollection.dataSource = self

        menuCollection.backgroundColor = Utilities().darkBlueColor
        menuCollection.register(menuCell.self, forCellWithReuseIdentifier: "cellId")
        
        addSubview(menuCollection)

        menuCollection.reloadData()
        addContraintsWithFormat("H:|[v0]|", views: menuCollection)
        addContraintsWithFormat("V:|[v0]|", views: menuCollection)
        addSubview(separator)
        
        
        
    }
   
    public func addContraintsWithFormat(_ format: String, views: UIView...) {
        var viewDict = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDict[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = menuCollection.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! menuCell
        cell.imageView.image = sections[indexPath.item]
//        print("Collection")
        if indexPath.item == 0 {
            cell.imageView.image = selectedSections[indexPath.item]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 5, height: frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        for i in collectionView.indexPathsForVisibleItems {
            let cell = collectionView.cellForItem(at: i) as! menuCell
            cell.imageView.image = sections[i.item]
        }

        let cell = collectionView.cellForItem(at: indexPath) as! menuCell
        cell.imageView.image = selectedSections[indexPath.item]
        
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
}

class menuCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = Utilities().lightBlueColor
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        print("cell")
        addSubview(imageView)
        addContraintsWithFormat("H:[v0(27)]", views: imageView)
        addContraintsWithFormat("V:[v0(25)]", views: imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
    
    public func addContraintsWithFormat(_ format: String, views: UIView...) {
        var viewDict = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDict[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
