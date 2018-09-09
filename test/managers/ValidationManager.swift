//
//  ValidationManager.swift
//  test
//
//  Created by Daenim on 9/9/18.
//  Copyright © 2018 rokobit. All rights reserved.
//

import Validator

extension String: Error { }

class ValidationManager {
    

    static let login: ValidationRuleSet<String> = {

        var s = ValidationRuleSet<String>()
        s.add(rule: ValidationRuleLength(min: 9, max: 9,
                                         error: NSLocalizedString("Number must be exactly 9 digits", comment: "")))
        s.add(rule: ValidationRulePattern(pattern: "^[0-9]*$",
                                          error: NSLocalizedString("Number must contain only digits", comment: "")))
        s.add(rule: ValidationRuleRequired(error: "Please, enter login"))
        return s
    }()
    
    static let password: ValidationRuleSet<String> = {
        
        var s = ValidationRuleSet<String>()
        s.add(rule: ValidationRuleLength(min: 4,
                                         error: NSLocalizedString("Password be no less than 4 symbols", comment: "")))
        s.add(rule: ValidationRuleRequired(error: "Please, enter password"))
        return s
    }()
    
}
