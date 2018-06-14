//
//  HomeViewController.swift
//  Digital Class
//
//  Created by Celina Martinez on 11/6/18.
//  Copyright © 2018 Jadapema. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController  {

    let utilities = Utilities()
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    lazy var menu : MenuBar = {
       let menu = MenuBar()
        menu.homeController = self
        return menu
    }()
    
    var sectionsCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.allowsMultipleSelection = false
        collection.backgroundColor = Utilities().darkBlueColor
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.backgroundColor = utilities.darkBlueColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(menu)
        view.addSubview(sectionsCollection)
        sectionsCollection.delegate = self
        sectionsCollection.dataSource = self
        
        sectionsCollection.register(sectionCell.self, forCellWithReuseIdentifier: "cellId")
        
        setupLayout()
    }
    
    private func setupLayout() {
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        menu.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        menu.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        menu.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        sectionsCollection.translatesAutoresizingMaskIntoConstraints = false
        sectionsCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        sectionsCollection.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        sectionsCollection.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        sectionsCollection.bottomAnchor.constraint(equalTo: menu.topAnchor, constant: 0).isActive = true
        
        
    }
        public var item : Int?
    public func scrollToMenuIndex (menuIndex: Int) {
        let indexpath = NSIndexPath(item: menuIndex, section: 0)
        sectionsCollection.scrollToItem(at: indexpath as IndexPath, at: .centeredHorizontally, animated: true)
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = sectionsCollection.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! sectionCell
        cell.setSeccion(seccion: indexPath.item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - menu.frame.height)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print(targetContentOffset.pointee.x / view.frame.width)
        
        let indexpath = NSIndexPath(item: Int(targetContentOffset.pointee.x / view.frame.width), section: 0)
        menu.menuCollection.selectItem(at: indexpath as IndexPath, animated: true, scrollPosition: .centeredHorizontally)
        menu.collectionView(menu.menuCollection, didSelectItemAt: indexpath as IndexPath)
        let cell = sectionsCollection.cellForItem(at: indexpath as IndexPath) as! sectionCell
        cell.setSeccion(seccion: indexpath.item)
        
    }
    
    
}

class sectionCell: UICollectionViewCell {
    
    var sectionView: UIView = {
        let view = UIView()

        return view
    }()
    
    var home : HomeView = {
        var view = HomeView(frame: CGRect(x: 0, y: 0, width: 414, height: 696))
        
        return view
    }()
    
    var library : LibraryView = {
        var view = LibraryView(frame: CGRect(x: 0, y: 0, width: 414, height: 696))
        
        return view
    }()
    var record : RecordView = {
        var view = RecordView(frame: CGRect(x: 0, y: 0, width: 414, height: 696))
        
        return view
    }()
    var dChat : DChatView = {
        var view = DChatView(frame: CGRect(x: 0, y: 0, width: 414, height: 696))
        
        return view
    }()
    
    var menu : MenuView = {
        var view = MenuView(frame: CGRect(x: 0, y: 0, width: 414, height: 696))
        
        return view
    }()
    
    var seccionIndex : Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("cell")
        addSubview(sectionView)
        addContraintsWithFormat("H:|[v0]|", views: sectionView)
        addContraintsWithFormat("V:|[v0]|", views: sectionView)
        
        
    }
    
    public func setSeccion(seccion : Int) {
        switch seccion {
        case 0:
            //
            print("seccion 0")
            sectionView.addSubview(home)
            return
        case 1:
            //
            print("seccion 1")
            sectionView.addSubview(library)
            return
        case 2:
            //
            print("seccion 2")
            sectionView.addSubview(record)
            return
        case 3:
            //
            print("seccion 3")
            sectionView.addSubview(dChat)
            return
        case 4:
            //
            print("seccion 4")
            sectionView.addSubview(menu)
            return
        default:
            print("default")
            return
        }
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

