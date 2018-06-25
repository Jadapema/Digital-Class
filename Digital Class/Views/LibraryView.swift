//
//  LibraryView.swift
//  Digital Class
//
//  Created by Celina Martinez on 12/6/18.
//  Copyright © 2018 Jadapema. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

import MobileCoreServices
import PDFKit

@available(iOS 11.0, *)

class LibraryView : UIView, PDFViewDelegate {
    
    //  top view
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
    
    // left IV
    let leftIV : UIImageView = {
        var imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "explore_Book")
        return imageView
    }()
    
    //label
    let topLabel : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.text = "Biblioteca"
        label.textAlignment = .center
//        label.adjustsFontSizeToFitWidth = true
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return label
    }()
        
    // right IV
    let rightIV : UIImageView = {
        var imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "uploadBook")
        return imageView
    }()
    
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
    
    var selectedCategory = ""
    
    // categories books table View
    
    var categoriesBooksTV : UITableView = {
       var tableView = UITableView()
        tableView.backgroundColor = Utilities().darkBlueColor
        tableView.separatorColor = Utilities().lightBlueColor
        
        return tableView
    }()
    
    var categoryBooksTV : UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = Utilities().darkBlueColor
        tableView.separatorColor = Utilities().lightBlueColor
        
        return tableView
    }()
    var sectionBooks : [Book] = []
    
    // Section Name FireBase
    var selectedCategoryFB : String!
    
    
    
    
    // Book Name
    var bookNameLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return label
    }()
    
    // Cover IV
    var coverIV : UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()
    
    // Book Name
    var writerLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 18)
        return label
    }()
    
    // Add Label
    var addLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.textAlignment = .center
        label.text = "Agregar"
        label.textColor = Utilities().whiteColor
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.137254902, green: 0.6352941176, blue: 0.3019607843, alpha: 1)
        label.layer.masksToBounds = false
        label.layer.cornerRadius = 3
        label.clipsToBounds = true
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        return label
    }()
    
    let separator01 : UIView = {
       let view = UIView()
        view.backgroundColor = Utilities().lightBlueColor
        return view
    }()
    
    let descriptiontTitleLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Acerca del libro"
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        return label
    }()
    
    var descriptionLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 18)
        return label
    }()
    
    let separator02 : UIView = {
        let view = UIView()
        view.backgroundColor = Utilities().lightBlueColor
        return view
    }()

    let informationLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Informacion"
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        return label
    }()
    
    let idiomLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.textAlignment = .right
        label.numberOfLines = 0
        label.text = "Idioma"
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        return label
    }()
    
    let categoryLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.textAlignment = .right
        label.numberOfLines = 0
        label.text = "Categoria"
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        return label
    }()
    
    let publishedLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.textAlignment = .right
        label.numberOfLines = 0
        label.text = "Publicado"
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        return label
    }()
    
    let pagesLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.textAlignment = .right
        label.numberOfLines = 0
        label.text = "Paginas"
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        return label
    }()
    
    let idiomBookLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 18)
        return label
    }()
    
    let categoryBookLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 18)
        return label
    }()
    
    let publishedBookLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 18)
        return label
    }()
    
    let pagesBookLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 18)
        return label
    }()

    var isMine : Bool!
    var selectedBook : Book!
    var myBooks : [Book] = []
    
//    myBooksCV
    var myBooksCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.allowsMultipleSelection = false
        collection.backgroundColor = Utilities().darkBlueColor
        return collection
    }()
    
    
    // LoadignBG
    var loadignBGV : UIView = {
       var view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1921568627, blue: 0.2470588235, alpha: 0.7009043236)
        var circle = UIImageView()
        view.addSubview(circle)
        circle.image = #imageLiteral(resourceName: "loading")
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        circle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        circle.widthAnchor.constraint(equalToConstant: 120).isActive = true
        circle.heightAnchor.constraint(equalToConstant: 120).isActive = true
        return view
    }()
    
    // percent label
    var percentLbl : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 25)
        return label
    }()
    
    let pdfV = PDFView()
    
    var thumbnailBGV : UIView = {
       var view = UIView()
        view.backgroundColor = Utilities().darkBlueColor
        return view
    }()
    
    //    thumbnailsCV
    var thumbnailsCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.allowsMultipleSelection = false
        collection.backgroundColor = Utilities().darkBlueColor
        return collection
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(emptyLbl)
        backgroundColor = Utilities().darkBlueColor
        addSubview(topView)
        topView.addSubview(leftIV)
        leftIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(exploreBookHandler)))
        leftIV.isUserInteractionEnabled = true
        topView.addSubview(topLabel)
        topView.addSubview(rightIV)
        rightIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(uploadBookHandler)))
        rightIV.isUserInteractionEnabled = true
        addSubview(lineIV)
        categoriesBooksTV.delegate = self
        categoriesBooksTV.dataSource = self
        categoriesBooksTV.register(categoriesTVCells.self, forCellReuseIdentifier: "Categories")
        categoriesBooksTV.isHidden = true
        addSubview(categoriesBooksTV)
        categoryBooksTV.delegate = self
        categoryBooksTV.dataSource = self
        categoryBooksTV.register(categoriesBooksTVCells.self, forCellReuseIdentifier: "books")
        categoryBooksTV.isHidden = true
        addSubview(categoryBooksTV)
        
        addSubview(coverIV)
        addSubview(bookNameLbl)
        addSubview(writerLbl)
        addSubview(addLbl)
        addLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addHandler)))
        addLbl.isUserInteractionEnabled = true
        addSubview(separator01)
        addSubview(descriptiontTitleLbl)
        addSubview(descriptionLbl)
        addSubview(separator02)
        addSubview(informationLbl)
        addSubview(idiomLbl)
        addSubview(categoryLbl)
        addSubview(publishedLbl)
        addSubview(pagesLbl)
        addSubview(idiomBookLbl)
        addSubview(categoryBookLbl)
        addSubview(publishedBookLbl)
        addSubview(pagesBookLbl)
        
        coverIV.isHidden = true
        bookNameLbl.isHidden = true
        writerLbl.isHidden = true
        addLbl.isHidden = true
        separator01.isHidden = true
        descriptiontTitleLbl.isHidden = true
        descriptionLbl.isHidden = true
        separator02.isHidden = true
        informationLbl.isHidden = true
        idiomLbl.isHidden = true
        categoryLbl.isHidden = true
        publishedLbl.isHidden = true
        pagesLbl.isHidden = true
        idiomBookLbl.isHidden = true
        categoryBookLbl.isHidden = true
        publishedBookLbl.isHidden = true
        pagesBookLbl.isHidden = true
        
        addSubview(myBooksCV)
        myBooksCV.delegate = self
        myBooksCV.dataSource = self
        myBooksCV.register(booksCVCell.self, forCellWithReuseIdentifier: "mybooks")
        
        addSubview(loadignBGV)
        loadignBGV.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        loadignBGV.isHidden = true
        loadignBGV.addSubview(percentLbl)
        
        pdfV.delegate = self
        
        addSubview(thumbnailBGV)
//        thumbnailBGV.frame = CGRect(x: (self.frame.width - 110), y: topView.frame.height, width: 110, height: (self.frame.height - topView.frame.height))
        thumbnailBGV.isHidden = true
        fetchMyBooks()
        
//        thumbnailsCV.frame = CGRect(x: 10, y: 10, width: 90, height: (thumbnailBGV.frame.height - 10))
        thumbnailsCV.delegate = self
        thumbnailsCV.dataSource = self
        thumbnailBGV.addSubview(thumbnailsCV)
        thumbnailsCV.register(thumbnailsCVCell.self, forCellWithReuseIdentifier: "Thumbnail")
        
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
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 0).isActive = true
        topLabel.leftAnchor.constraint(equalTo: leftIV.rightAnchor, constant: 5).isActive = true
        topLabel.rightAnchor.constraint(equalTo: rightIV.leftAnchor, constant: -5).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: topView.frame.height - 1).isActive = true
        
        categoriesBooksTV.translatesAutoresizingMaskIntoConstraints = false
        categoriesBooksTV.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        categoriesBooksTV.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        categoriesBooksTV.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        categoriesBooksTV.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        categoryBooksTV.translatesAutoresizingMaskIntoConstraints = false
        categoryBooksTV.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        categoryBooksTV.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10).isActive = true
        categoryBooksTV.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        categoryBooksTV.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        // coverIv
        coverIV.translatesAutoresizingMaskIntoConstraints = false
        coverIV.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5 ).isActive = true
        coverIV.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 5).isActive = true
        coverIV.widthAnchor.constraint(equalToConstant: 100).isActive = true
        coverIV.heightAnchor.constraint(equalToConstant: 135).isActive = true
        
        // bookNameLbl
        bookNameLbl.translatesAutoresizingMaskIntoConstraints = false
        bookNameLbl.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 5).isActive = true
        bookNameLbl.leftAnchor.constraint(equalTo: coverIV.rightAnchor, constant: 5).isActive = true
        bookNameLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        bookNameLbl.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        // writerLbl
        writerLbl.translatesAutoresizingMaskIntoConstraints = false
        writerLbl.bottomAnchor.constraint(equalTo: separator01.topAnchor, constant: -5).isActive = true
        writerLbl.leftAnchor.constraint(equalTo: coverIV.rightAnchor, constant: 5).isActive = true
        writerLbl.rightAnchor.constraint(equalTo: addLbl.leftAnchor, constant: 5).isActive = true
        writerLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // addLbl
        addLbl.translatesAutoresizingMaskIntoConstraints = false
        addLbl.bottomAnchor.constraint(equalTo: separator01.topAnchor, constant: -5).isActive = true
        addLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        addLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addLbl.widthAnchor.constraint(equalToConstant: 65).isActive = true
        
        // separator01
        separator01.translatesAutoresizingMaskIntoConstraints = false
        separator01.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        separator01.topAnchor.constraint(equalTo: coverIV.bottomAnchor, constant: 5).isActive = true
        separator01.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator01.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        
        // descriptiontTitleLbl
        descriptiontTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        descriptiontTitleLbl.topAnchor.constraint(equalTo: separator01.bottomAnchor, constant: 5).isActive = true
        descriptiontTitleLbl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        descriptiontTitleLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 5).isActive = true
        descriptiontTitleLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // descriptionLbl
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        descriptionLbl.topAnchor.constraint(equalTo: descriptiontTitleLbl.bottomAnchor, constant: 5).isActive = true
        descriptionLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        descriptionLbl.heightAnchor.constraint(equalToConstant: 200).isActive = true
        descriptionLbl.widthAnchor.constraint(equalToConstant: self.frame.width * 0.95).isActive = true
        
        // separator02
        separator02.translatesAutoresizingMaskIntoConstraints = false
        separator02.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        separator02.topAnchor.constraint(equalTo: descriptionLbl.bottomAnchor, constant: 3).isActive = true
        separator02.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator02.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        
        // informationLbl
        informationLbl.translatesAutoresizingMaskIntoConstraints = false
        informationLbl.topAnchor.constraint(equalTo: separator02.bottomAnchor, constant: 5).isActive = true
        informationLbl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        informationLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 5).isActive = true
        informationLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // idiomLbl
        idiomLbl.translatesAutoresizingMaskIntoConstraints = false
        idiomLbl.topAnchor.constraint(equalTo: informationLbl.bottomAnchor, constant: 10).isActive = true
        idiomLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -100).isActive = true
        idiomLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        idiomLbl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        // categoryLbl
        categoryLbl.translatesAutoresizingMaskIntoConstraints = false
        categoryLbl.topAnchor.constraint(equalTo: idiomLbl.bottomAnchor, constant: 5).isActive = true
        categoryLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -100).isActive = true
        categoryLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        categoryLbl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        // publishedLbl
        publishedLbl.translatesAutoresizingMaskIntoConstraints = false
        publishedLbl.topAnchor.constraint(equalTo: categoryLbl.bottomAnchor, constant: 5).isActive = true
        publishedLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -100).isActive = true
        publishedLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        publishedLbl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        // pagesLbl
        pagesLbl.translatesAutoresizingMaskIntoConstraints = false
        pagesLbl.topAnchor.constraint(equalTo: publishedLbl.bottomAnchor, constant: 5).isActive = true
        pagesLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -100).isActive = true
        pagesLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        pagesLbl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        // idiomBookLbl
        idiomBookLbl.translatesAutoresizingMaskIntoConstraints = false
        idiomBookLbl.topAnchor.constraint(equalTo: informationLbl.bottomAnchor, constant: 5).isActive = true
        idiomBookLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 100).isActive = true
        idiomBookLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        idiomBookLbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        // categoryBookLbl
        categoryBookLbl.translatesAutoresizingMaskIntoConstraints = false
        categoryBookLbl.topAnchor.constraint(equalTo: idiomBookLbl.bottomAnchor, constant: 5).isActive = true
        categoryBookLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 100).isActive = true
        categoryBookLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        categoryBookLbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        // publishedBookLbl
        publishedBookLbl.translatesAutoresizingMaskIntoConstraints = false
        publishedBookLbl.topAnchor.constraint(equalTo: categoryBookLbl.bottomAnchor, constant: 5).isActive = true
        publishedBookLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 100).isActive = true
        publishedBookLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        publishedBookLbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        // pagesBookLbl
        pagesBookLbl.translatesAutoresizingMaskIntoConstraints = false
        pagesBookLbl.topAnchor.constraint(equalTo: publishedBookLbl.bottomAnchor, constant: 5).isActive = true
        pagesBookLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 100).isActive = true
        pagesBookLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        pagesBookLbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        // my books
        myBooksCV.translatesAutoresizingMaskIntoConstraints = false
        myBooksCV.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 15).isActive = true
        myBooksCV.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        myBooksCV.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        myBooksCV.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        
        percentLbl.translatesAutoresizingMaskIntoConstraints = false
        percentLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        percentLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        percentLbl.widthAnchor.constraint(equalToConstant: 120).isActive = true
        percentLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        thumbnailBGV.translatesAutoresizingMaskIntoConstraints = false
        thumbnailBGV.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        thumbnailBGV.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        thumbnailBGV.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        thumbnailBGV.widthAnchor.constraint(equalToConstant: 110).isActive = true
        
        thumbnailsCV.translatesAutoresizingMaskIntoConstraints = false
        thumbnailsCV.topAnchor.constraint(equalTo: thumbnailBGV.topAnchor, constant: 10).isActive = true
        thumbnailsCV.leftAnchor.constraint(equalTo: thumbnailBGV.leftAnchor, constant: 10).isActive = true
        thumbnailsCV.rightAnchor.constraint(equalTo: thumbnailBGV.rightAnchor, constant: -10).isActive = true
        thumbnailsCV.bottomAnchor.constraint(equalTo: thumbnailBGV.bottomAnchor, constant: 0).isActive = true
        
        
    }
    
    @objc func exploreBookHandler () {
        print("Explore")
        topLabel.text = "Explore"
        rightIV.image = #imageLiteral(resourceName: "busqueda")
        rightIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchBookHandler)))
        rightIV.frame.size.width -= 5
        leftIV.image = #imageLiteral(resourceName: "flecha")
        leftIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backHandler)))
        let rotationAngle = 180 * (Double.pi/180)
        leftIV.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
        lineIV.isHidden = true
        emptyLbl.isHidden = true
        myBooksCV.isHidden = true
        categoriesBooksTV.isHidden = false
    }
    
    @objc func uploadBookHandler () {
        print("Upload")
    }
    
    @objc func backHandler () {
        print("back")
        topLabel.text = "Biblioteca"
        leftIV.image = #imageLiteral(resourceName: "explore_Book")
        leftIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(exploreBookHandler)))
        let rotationAngle = 0 * (Double.pi/180)
        leftIV.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
        rightIV.image = #imageLiteral(resourceName: "uploadBook")
        rightIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(uploadBookHandler)))
        rightIV.frame.size.width += 5
        lineIV.isHidden = false
        emptyLbl.isHidden = false
        categoriesBooksTV.isHidden = true
    }
    
    @objc func searchBookHandler () {
        print("Search")
    }
    
    @objc func backCategoryHandler () {
        print("back Category")
        topLabel.text = "Explore"
        rightIV.image = #imageLiteral(resourceName: "busqueda")
        rightIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchBookHandler)))
        leftIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backHandler)))
        categoryBooksTV.isHidden = true
        categoriesBooksTV.isHidden = false
    }
    
    @objc func backBookHandler () {
        print("back Book")
        topLabel.text = selectedCategory
        categoryBooksTV.isHidden = false
        leftIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backCategoryHandler)))
        
        coverIV.isHidden = true
        bookNameLbl.isHidden = true
        writerLbl.isHidden = true
        addLbl.isHidden = true
        separator01.isHidden = true
        descriptiontTitleLbl.isHidden = true
        descriptionLbl.isHidden = true
        separator02.isHidden = true
        informationLbl.isHidden = true
        idiomLbl.isHidden = true
        categoryLbl.isHidden = true
        publishedLbl.isHidden = true
        pagesLbl.isHidden = true
        idiomBookLbl.isHidden = true
        categoryBookLbl.isHidden = true
        publishedBookLbl.isHidden = true
        pagesBookLbl.isHidden = true
    }
    
    @objc func estanteHandler () {
        print("Estante")
        fetchMyBooks()
        coverIV.isHidden = true
        bookNameLbl.isHidden = true
        writerLbl.isHidden = true
        addLbl.isHidden = true
        separator01.isHidden = true
        descriptiontTitleLbl.isHidden = true
        descriptionLbl.isHidden = true
        separator02.isHidden = true
        informationLbl.isHidden = true
        idiomLbl.isHidden = true
        categoryLbl.isHidden = true
        publishedLbl.isHidden = true
        pagesLbl.isHidden = true
        idiomBookLbl.isHidden = true
        categoryBookLbl.isHidden = true
        publishedBookLbl.isHidden = true
        pagesBookLbl.isHidden = true
        categoryBooksTV.isHidden = true
        
        topLabel.text = "Biblioteca"
        leftIV.image = #imageLiteral(resourceName: "explore_Book")
        leftIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(exploreBookHandler)))
        let rotationAngle = 0 * (Double.pi/180)
        leftIV.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
        rightIV.image = #imageLiteral(resourceName: "uploadBook")
        rightIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(uploadBookHandler)))
        rightIV.frame.size.width += 5
        
        if myBooks.isEmpty {
            lineIV.isHidden = false
            emptyLbl.isHidden = false
        } else {
            lineIV.isHidden = true
            emptyLbl.isHidden = true
            myBooksCV.isHidden = false
        }
        
        
    }
    
    func showCategory (name: String) {
        topLabel.text = name
        categoriesBooksTV.isHidden = true
        leftIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backCategoryHandler)))
        rightIV.image = #imageLiteral(resourceName: "estante")
        rightIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(estanteHandler)))
        categoryBooksTV.isHidden = false
    }
    
    func showBookDetails (book : Book) {
        selectedBook = book
        CheckIfIsMine()
        print("show detail of : \(book.Name!)")
        topLabel.text = ""
        categoryBooksTV.isHidden = true
        leftIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBookHandler)))
        
        coverIV.isHidden = false
        bookNameLbl.isHidden = false
        writerLbl.isHidden = false
        addLbl.isHidden = false
        separator01.isHidden = false
        descriptiontTitleLbl.isHidden = false
        descriptionLbl.isHidden = false
        separator02.isHidden = false
        informationLbl.isHidden = false
        idiomLbl.isHidden = false
        categoryLbl.isHidden = false
        publishedLbl.isHidden = false
        pagesLbl.isHidden = false
        idiomBookLbl.isHidden = false
        categoryBookLbl.isHidden = false
        publishedBookLbl.isHidden = false
        pagesBookLbl.isHidden = false
        
        coverIV.loadImageUsingCacheWithUrlString(book.Cover)
        bookNameLbl.text = book.Name
        writerLbl.text = book.Writer
        descriptionLbl.text = book.Description
        idiomBookLbl.text = book.Idiom
        categoryBookLbl.text = book.Category
        publishedBookLbl.text = book.Date
        pagesBookLbl.text = "\(book.PagesCount!) Paginas"
        
    }
    
    @objc func backReadingHandler () {
        print("back reading")
        topLabel.text = "Biblioteca"
        leftIV.image = #imageLiteral(resourceName: "explore_Book")
        leftIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(exploreBookHandler)))
        let rotationAngle = 0 * (Double.pi/180)
        leftIV.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
        rightIV.image = #imageLiteral(resourceName: "uploadBook")
        rightIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(uploadBookHandler)))
//        rightIV.frame.size.width += 5
        pdfV.isHidden = true
        
        if myBooks.isEmpty {
            lineIV.isHidden = false
            emptyLbl.isHidden = false
        } else {
            lineIV.isHidden = true
            emptyLbl.isHidden = true
            myBooksCV.isHidden = false
        }
        
    }
    
    @objc func thumbnailButtomHandler () {
        print("Thumbnail")
        
        self.thumbnailsCV.reloadData()
        
        if thumbnailBGV.isHidden == true {
            // si esta oculto
            thumbnailBGV.isHidden = false
        } else {
            // si no esta oculto
            thumbnailBGV.isHidden = true
        }
        
    }
    
    @objc func addHandler () {
        print("addRemove")
        
        if isMine == true {
            // Quitar libro
            print("Quitar!!!!!!!!!!!!!!!!!!!!!!")
            Database.database().reference().child("Users").child("\((Auth.auth().currentUser?.uid)!)").child("Books").child("\((selectedBook.BookId)!)").removeValue()
        } else {
            // Agregar libro
            print("agregar!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            Database.database().reference().child("Users").child("\((Auth.auth().currentUser?.uid)!)").child("Books").child("\((selectedBook.BookId)!)").setValue(true)
        }
        
        CheckIfIsMine()
        
    }
    
    func CheckIfIsMine () {
        Database.database().reference().observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject] {
                if let Users = dictionary["Users"] as? Dictionary<String,AnyObject> {
                    for (userId,value) in Users {
                        if userId == Auth.auth().currentUser?.uid {
                            if let UserBooks = value["Books"] as? Dictionary<String, AnyObject> {
                                var helper : Bool = false
                                for (BookID, _) in UserBooks {
                                    print(BookID)
                                    
                                    if BookID == self.selectedBook.BookId {
                                        helper = true
                                    }
                                }
                                
                                self.SetButton(ButtonIsMine: helper)
                            } else {
                                self.SetButton(ButtonIsMine: false)
                            }
                        }
                    }
                } else {
                    self.SetButton(ButtonIsMine: false)
                }
                
            }
            
        })
        
    }
    
    func SetButton(ButtonIsMine : Bool) {
        print("Button set in : \(ButtonIsMine)")
        if ButtonIsMine == true {
            self.addLbl.text = "Remover"
            self.addLbl.layer.borderColor = Utilities().redColor.cgColor
            isMine = true
            
        } else {
            self.addLbl.text = "Obtener"
            self.addLbl.layer.borderColor = Utilities().greenColor.cgColor
            isMine = false
        }
        
//        self.AddRemoveButton.isHidden = false
        
    }
    
    func FetchAll() {
        Database.database().reference().observe(.value, with: { snapshot in
            self.sectionBooks.removeAll()
            //Creamos un diccionario con la base de datos completa
            if let dictionary = snapshot.value as? [String:AnyObject] {
                
                if let Categories = dictionary["BooksCategories"] as? Dictionary<String,AnyObject> {
                    
                    for (CatId, V) in Categories {
                        if CatId == self.selectedCategoryFB {
                            if let BooksCategory = V["Books"] as? Dictionary<String,AnyObject> {
                                for (BID,_) in BooksCategory {
                                    if let Books = dictionary["Books"] as? Dictionary<String,AnyObject> {
                                        //Recorremos la seccion de usuarios con un ciclo para obtener el valor de cada uno
                                        for (bookId,value) in Books {
                                            if BID == bookId {
                                                if value is Dictionary<String,AnyObject> {
                                                    let book = Book()
                                                    book.BookId = bookId
                                                    if let bookURL = value["BookURL"] as? String {
                                                        book.URL = bookURL
                                                    }
                                                    if let Category = value["Category"] as? String {
                                                        book.Category = Category
                                                    }
                                                    if let Cover = value["Cover"] as? String {
                                                        book.Cover = Cover
                                                    }
                                                    if let Date = value["Date"] as? String {
                                                        book.Date = Date
                                                    }
                                                    if let Description = value["Description"] as? String {
                                                        book.Description = Description
                                                    }
                                                    if let Idiom = value["Idiom"] as? String {
                                                        book.Idiom = Idiom
                                                    }
                                                    if let Name = value["Name"] as? String {
                                                        book.Name = Name
                                                    }
                                                    if let PagesCount = value["PagesCount"] as? Int {
                                                        book.PagesCount = PagesCount
                                                    }
                                                    if let Writer = value["Writer"] as? String {
                                                        book.Writer = Writer
                                                    }
                                                    
                                                    self.sectionBooks.append(book)
                                                }
                                            }
                                        }
                                        
                                        DispatchQueue.main.async(execute: {
                                            self.categoryBooksTV.reloadData()
                                        })
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
        })
    }
    
    func fetchMyBooks() {
        
        Database.database().reference().observe(.value, with: { snapshot in
            self.myBooks.removeAll()
            //Creamos un diccionario con la base de datos completa
            if let dictionary = snapshot.value as? [String:AnyObject] {
                //Creamos un diccionario con la seccion de los Usuarios
                if let users = dictionary["Users"] as? Dictionary<String,AnyObject> {
                    for (userid, value) in users {
                        if userid == Auth.auth().currentUser?.uid {
                            if let mybooks = value["Books"] as? Dictionary<String,AnyObject> {
                                for (mybookid,_) in mybooks {
                                    if let Books = dictionary["Books"] as? Dictionary<String,AnyObject> {
                                        //Recorremos la seccion de usuarios con un ciclo para obtener el valor de cada uno
                                        for (bookId,value) in Books {
                                            if bookId == mybookid {
                                                if let val = value as? Dictionary<String,AnyObject> {
                                                    let book = Book()
                                                    book.BookId = bookId
                                                    if let bookURL = value["BookURL"] as? String {
                                                        book.URL = bookURL
                                                    }
                                                    if let Category = value["Category"] as? String {
                                                        book.Category = Category
                                                    }
                                                    if let Cover = value["Cover"] as? String {
                                                        book.Cover = Cover
                                                    }
                                                    if let Date = value["Date"] as? String {
                                                        book.Date = Date
                                                    }
                                                    if let Description = value["Description"] as? String {
                                                        book.Description = Description
                                                    }
                                                    if let Idiom = value["Idiom"] as? String {
                                                        book.Idiom = Idiom
                                                    }
                                                    if let Name = value["Name"] as? String {
                                                        book.Name = Name
                                                    }
                                                    if let PagesCount = value["PagesCount"] as? Int {
                                                        book.PagesCount = PagesCount
                                                    }
                                                    if let Writer = value["Writer"] as? String {
                                                        book.Writer = Writer
                                                    }
                                                    
                                                    self.myBooks.append(book)
                                                }
                                            }
                                        }
                                        
                                        DispatchQueue.main.async(execute: {
                                            if !self.myBooks.isEmpty {
                                                self.lineIV.isHidden = true
                                                self.emptyLbl.isHidden = true
                                                
                                            }
                                            self.myBooksCV.reloadData()
                                        })
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
        })
    }
    
    func loadBook(selectedBook : Book)  {
        loadignBGV.isHidden = false
        print("Hola")
        pdfV.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pdfV)
        pdfV.layer.zPosition = -0.5
        pdfV.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        pdfV.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        pdfV.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        pdfV.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        let dowloadtask =  Storage.storage().reference(forURL: selectedBook.URL).getData(maxSize: 60 * 1024 * 1024) { (data, error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Hola")
                if let document = PDFDocument.init(data: data!) {
                    print("si! :D")
                    self.pdfV.document = document
                    self.pdfV.goToFirstPage(nil)
                    self.pdfV.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                    self.pdfV.displayMode = .singlePageContinuous
                    self.pdfV.autoScales = true
                    let IV = UIImageView(frame: self.frame)
                    IV.image = UIImage(view: self.pdfV)
                }
            }
        }
        
        let observer = dowloadtask.observe(.progress, handler: { snapshot in
            
            if snapshot.progress?.completedUnitCount != 0 {
                let porcent = 100 * Int(snapshot.progress!.completedUnitCount)/Int(snapshot.progress!.totalUnitCount)
                print(Int(porcent))
                self.percentLbl.text = "\(porcent)%"
                if porcent == 100 {
                    print("Done")
                    self.pdfV.isHidden = false
                    self.loadignBGV.isHidden = true
                    self.myBooksCV.isHidden = true
                    self.topLabel.text = selectedBook.Name
                    self.rightIV.image = #imageLiteral(resourceName: "tumbnail")
                    self.rightIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.thumbnailButtomHandler)))
//                    self.rightIV.frame.size.width -= 5
                    self.leftIV.image = #imageLiteral(resourceName: "flecha")
                    self.leftIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backReadingHandler)))
                    let rotationAngle = 180 * (Double.pi/180)
                    self.leftIV.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
                    self.bringSubview(toFront: self.thumbnailBGV)
//                    self.view.bringSubview(toFront: self.ThumbnailView)
                    
                }
            }
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LibraryView :  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == categoriesBooksTV {
            return 9
        } else {
            return sectionBooks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == categoriesBooksTV {
            let cell = categoriesBooksTV.dequeueReusableCell(withIdentifier: "Categories", for: indexPath) as! categoriesTVCells
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.1491528427, blue: 0.2637124495, alpha: 1)
            if indexPath.row == 0 {
                cell.category.text = "Informatica"
                cell.cover.image = #imageLiteral(resourceName: "informatica")
                return cell
            } else if indexPath.row == 1 {
                cell.category.text = "Novelas"
                cell.cover.image = #imageLiteral(resourceName: "novelas")
                return cell
            } else if indexPath.row == 2 {
                cell.category.text = "Ciencia Ficcion"
                cell.cover.image = #imageLiteral(resourceName: "ciencia ficcion")
                return cell
            } else if indexPath.row == 3 {
                cell.category.text = "Biografias"
                cell.cover.image = #imageLiteral(resourceName: "biografias")
                return cell
            } else if indexPath.row == 4 {
                cell.category.text = "Ciencia y Naturaleza"
                cell.cover.image = #imageLiteral(resourceName: "ciencia y naturaleza")
                return cell
            } else if indexPath.row == 5 {
                cell.category.text = "Literatura"
                cell.cover.image = #imageLiteral(resourceName: "literatura")
                return cell
            }  else if indexPath.row == 6 {
                cell.category.text = "Politica"
                cell.cover.image = #imageLiteral(resourceName: "politica")
                return cell
            } else if indexPath.row == 7 {
                cell.category.text = "Misterio y Suspenso"
                cell.cover.image = #imageLiteral(resourceName: "suspenso")
                return cell
            } else if indexPath.row == 8 {
                cell.category.text = "Tecnicos y Profesionales"
                cell.cover.image = #imageLiteral(resourceName: "tecnicos")
                return cell
            } else {
                return cell
            }
        } else {
            let cell = categoryBooksTV.dequeueReusableCell(withIdentifier: "books", for: indexPath) as! categoriesBooksTVCells
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.1491528427, blue: 0.2637124495, alpha: 1)
            cell.cover.loadImageUsingCacheWithUrlString(sectionBooks[indexPath.row].Cover)
            cell.name.text = sectionBooks[indexPath.row].Name
            cell.date.text = sectionBooks[indexPath.row].Date
            cell.writer.text = sectionBooks[indexPath.row].Writer
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        if tableView == categoriesBooksTV {
            if indexPath.row == 0 {
                selectedCategory = "Informatica"
                selectedCategoryFB = "Informatica"
            } else if indexPath.row == 1 {
                selectedCategory = "Novelas"
                selectedCategoryFB = "Novelas"
            } else if indexPath.row == 2 {
                selectedCategory = "Ciencia Ficcion"
                selectedCategoryFB = "CienciaFiccion"
            } else if indexPath.row == 3 {
                selectedCategory = "Biografias"
                selectedCategoryFB = "Biografias"
            } else if indexPath.row == 4 {
                selectedCategory = "Ciencia y Naturaleza"
                selectedCategoryFB = "CienciaYNaturaleza"
            } else if indexPath.row == 5 {
                selectedCategory = "Literatura"
                selectedCategoryFB = "Literatura"
            } else if indexPath.row == 6 {
                selectedCategory = "Historia"
                selectedCategoryFB = "Historia"
            } else if indexPath.row == 7 {
                selectedCategory = "Politica"
                selectedCategoryFB = "Politica"
            } else if indexPath.row == 8 {
                selectedCategory = "Misterio y Suspenso"
                selectedCategoryFB = "MisterioYSuspenso"
            } else if indexPath.row == 9 {
                selectedCategory = "Tecnicos y Profesionales"
                selectedCategoryFB = "TecnicosYProfesionales"
            }
            
            FetchAll()
            
            showCategory(name: selectedCategory)
        } else {
            showBookDetails(book: sectionBooks[indexPath.row])
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == categoriesBooksTV {
            return 120
        } else {
            return 150
        }
    }
    
    
    
}

class categoriesTVCells : UITableViewCell {
    var category : UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-Medium", size: 24)
        return label
    }()
    var cover = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        //First Call Super
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        self.contentView.backgroundColor = Utilities().darkBlueColor
        addSubview(cover)
        addSubview(category)
        
        cover.translatesAutoresizingMaskIntoConstraints = false
        cover.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        cover.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        cover.widthAnchor.constraint(equalToConstant: 55).isActive = true
        cover.heightAnchor.constraint(equalToConstant: 88).isActive = true
        
        category.translatesAutoresizingMaskIntoConstraints = false
        category.leftAnchor.constraint(equalTo: cover.rightAnchor, constant: 15).isActive = true
        category.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        category.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        category.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class categoriesBooksTVCells : UITableViewCell {
    var name : UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.textColor = Utilities().whiteColor
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "AvenirNext-Medium", size: 22)
        return label
    }()
    var date : UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 18)
        return label
    }()
    var writer : UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.textColor = Utilities().whiteColor
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 18)
        return label
    }()
    
    var cover = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        //First Call Super
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        self.contentView.backgroundColor = Utilities().darkBlueColor
        addSubview(cover)
        addSubview(name)
        addSubview(date)
        addSubview(writer)
        
        cover.translatesAutoresizingMaskIntoConstraints = false
        cover.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        cover.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        cover.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cover.heightAnchor.constraint(equalToConstant: 135).isActive = true
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leftAnchor.constraint(equalTo: cover.rightAnchor, constant: 10).isActive = true
        name.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        name.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        name.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        date.translatesAutoresizingMaskIntoConstraints = false
        date.leftAnchor.constraint(equalTo: cover.rightAnchor, constant: 10).isActive = true
        date.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        date.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        date.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        writer.translatesAutoresizingMaskIntoConstraints = false
        writer.leftAnchor.constraint(equalTo: cover.rightAnchor, constant: 10).isActive = true
        writer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        writer.bottomAnchor.constraint(equalTo: date.topAnchor, constant: 0).isActive = true
        writer.heightAnchor.constraint(equalToConstant: 30).isActive = true
        

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension LibraryView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == myBooksCV {
            return myBooks.count
        } else {
            if selectedBook != nil {
                return selectedBook.PagesCount
            } else {
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == myBooksCV {
            let cell = myBooksCV.dequeueReusableCell(withReuseIdentifier: "mybooks", for: indexPath) as! booksCVCell
            cell.backgroundColor = Utilities().lightBlueColor
            cell.cover.loadImageUsingCacheWithUrlString(myBooks[indexPath.row].Cover)
            return cell
        } else {
            let cell = thumbnailsCV.dequeueReusableCell(withReuseIdentifier: "Thumbnail", for: indexPath) as! thumbnailsCVCell
            cell.backgroundColor = Utilities().lightBlueColor
            if let page = pdfV.document?.page(at: indexPath.item) {
                let thumbnail = page.thumbnail(of: cell.bounds.size, for: PDFDisplayBox.cropBox)
                cell.thumbnail.image = thumbnail
                cell.pageNumber.text = page.label
            }

            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == myBooksCV {
            loadBook(selectedBook: myBooks[indexPath.row])
            selectedBook = myBooks[indexPath.row]
        } else {
            if let page = pdfV.document?.page(at: indexPath.row) {
                pdfV.go(to: page)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == myBooksCV {
            return CGSize(width: 116, height: 152)
        } else {
            return CGSize(width: 90, height: 133)
        }

    }
}

class booksCVCell : UICollectionViewCell {
    var cover : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cover = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        addSubview(cover)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

class thumbnailsCVCell : UICollectionViewCell {
    var thumbnail : UIImageView!
    
    var pageNumber : UILabel = {
        var label = UILabel()
        label.backgroundColor = Utilities().darkBlueColor
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Utilities().whiteColor
        label.layer.borderWidth = 1
        label.layer.borderColor = Utilities().lightBlueColor.cgColor
        label.layer.masksToBounds = false
        label.layer.cornerRadius = 7
        label.clipsToBounds = true
        label.font = UIFont(name: "AvenirNext-Medium", size: 9)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        thumbnail = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        addSubview(thumbnail)
        
        addSubview(pageNumber)
        
        pageNumber.translatesAutoresizingMaskIntoConstraints = false
        pageNumber.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        pageNumber.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        pageNumber.heightAnchor.constraint(equalToConstant: 14).isActive = true
        pageNumber.widthAnchor.constraint(equalToConstant: 14).isActive = true
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

let imageCache = NSCache<NSString, AnyObject>()
extension UIImageView {
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        self.image = nil
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        //otherwise fire off a new download
        let url = URL(string: urlString)
        if url != nil {
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            //download hit an error so lets return out
            if let error = error {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    self.image = downloadedImage
                }
            })
        }).resume()
        }
    }
}

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
}

