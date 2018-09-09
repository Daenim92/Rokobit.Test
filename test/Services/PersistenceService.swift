//
//  CoreDataService.swift
//  test
//
//  Created by Daenim on 9/9/18.
//  Copyright © 2018 rokobit. All rights reserved.
//

import PluggableApplicationDelegate
import RealmSwift

class PersistenceService: NSObject, ApplicationService {
    static let shared = PersistenceService()
    
    ///
    
    let realm = try! Realm()
    
    func save(login: String, password: String) {
        let loginInfo = realm.objects(LoginInfo.self).first ?? LoginInfo()
        try! realm.write {
            loginInfo.login = login
            loginInfo.password = password
            realm.add( loginInfo )
        }
    }
    
    func getLoginInfo() -> (login: String, password: String)? {
        return realm.objects(LoginInfo.self).first.map { return ($0.login, $0.password) }
    }
    
    func deleteLoginInfo() {
        let loginInfo = realm.objects(LoginInfo.self)
        guard loginInfo.count > 0 else
        { return }
        
        try! realm.write {
            realm.delete(loginInfo)
        }
    }

}
