//
//  Book.swift
//  Digital Class
//
//  Created by Celina Martinez on 14/6/18.
//  Copyright © 2018 Jadapema. All rights reserved.
//

import UIKit

// will be a struct ********
class Book : NSObject {
    var BookId : String!
    var URL : String!
    var Category : String!
    var Cover : String!
    var Date : String!
    var Description : String!
    var Idiom : String!
    var Name : String!
    var PagesCount : Int!
    var Writer : String!
    
    
    override init() {}
    
    required init(BookId : String,URL : String ,Category : String, Cover:String, Date:String,Description : String, Idiom:String,Name:String,PagesCount : Int,Writer:String) {
        self.BookId = BookId
        self.URL = URL
        self.Category = Category
        self.Cover = Cover
        self.Date = Date
        self.Description = Description
        self.Idiom = Idiom
        self.Name = Name
        self.PagesCount = PagesCount
        self.Writer = Writer
    }
}
