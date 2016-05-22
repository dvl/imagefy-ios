//
//  User.swift
//  imagefy
//
//  Created by Guilherme Augusto on 22/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String
    var email: String
    var firstName: String
    var lastName: String
    var imageUrl: String
    
    init(name: String, email: String, firstName: String, lastName: String, imageUrl: String) {
        self.name = name
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.imageUrl = imageUrl
    }
}

