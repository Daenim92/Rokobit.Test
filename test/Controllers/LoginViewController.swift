//
//  ViewController.swift
//  test
//
//  Created by Daenim on 9/7/18.
//  Copyright © 2018 rokobit. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController {
    @IBOutlet var passwordField: UITextField?
    @IBOutlet var phoneNumber: UITextField?
    
    @IBOutlet var loginButton: UIButton?
    @IBOutlet var errorLabel: UILabel?

    @IBAction func backToLogin(sender: UIStoryboardSegue) {
        //unwind segue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let info = PersistenceService.shared.getLoginInfo() {
            requestLogin(login: info.login, password: info.password)
        }
    }
    
    @IBAction func login() {
        let number = phoneNumber?.text ?? ""
        let password = passwordField?.text ?? ""
        
        let result = number.validate(rules: ValidationManager.login)
            .merge(with: password.validate(rules: ValidationManager.password))
        
        loginButton?.backgroundColor = {
            switch result {
            case .valid: return #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            case .invalid: return #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            }
        }()
        
        errorLabel?.isHidden = {
            switch result {
            case .valid: return true
            case .invalid: return false
            }
        }()
        
        errorLabel?.text = {
            switch result {
            case .valid: return ""
            case .invalid(let errors):
                return errors.map { "\($0)" }.joined(separator: "\n")
            }
        }()
        
        guard result == .valid else { return }
        
        let login = "+380" + number
        
        requestLogin(login: login, password: password)
    }
        
    func requestLogin(login: String, password: String) {
        SVProgressHUD.show()
        NetworkService.shared.login(username: login, password: password)
        { (user, error) in
            SVProgressHUD.dismiss()
            if let user = user {
                self.performSegue(withIdentifier: "toUser", sender: user)
            }
            if let error = error {
                self.errorLabel?.isHidden = false
                self.errorLabel?.text = error.localizedDescription
            }
        }
        PersistenceService.shared.save(login: login, password: password)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.destination, sender) {
        case (let vc as UserViewController, let user as User):
            vc.model = user
        default:
            break
        }
    }

}

