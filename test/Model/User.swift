//
//  User.swift
//  test
//
//  Created by Daenim on 9/9/18.
//  Copyright © 2018 rokobit. All rights reserved.
//

import Foundation

struct User: Codable {
    let data : Data
    
    struct Data: Codable {
        let id: Int
        let first_name: String
        let last_name: String
        let avatar: URL
    }
}
