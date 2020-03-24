//
//  RTAUser.swift
//  RegistrationTestApp
//
//  Created by Вячеслав on 23/03/2020.
//Copyright © 2020 PaRaDoX. All rights reserved.
//

import Foundation
import RealmSwift

class RTAUser: Object {
    @objc dynamic var name = ""
    @objc dynamic var email = ""
    @objc dynamic var password = ""

    
    convenience init(email: String, name: String, password: String) {
        self.init()
        self.email = email
        self.name = name
        self.password = password
    }
    
    override class func primaryKey() -> String? {
        return "email"
    }
}
