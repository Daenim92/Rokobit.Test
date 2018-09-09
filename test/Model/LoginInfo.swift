//
//  LoginInfo.swift
//  test
//
//  Created by Daenim on 9/9/18.
//  Copyright © 2018 rokobit. All rights reserved.
//

import RealmSwift

class LoginInfo: Object {
    @objc dynamic var id : Int = 1
    
    @objc dynamic var login : String = ""
    @objc dynamic var password : String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
