//
//  UserViewController.swift
//  test
//
//  Created by Daenim on 9/9/18.
//  Copyright © 2018 rokobit. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet var avatarImageView: UIImageView?
    @IBOutlet var descriptionTextView: UITextView?


    typealias Model = User
    var model: Model? { didSet { updateUI() }}
    
    override func viewDidLoad() {
        updateUI()
    }
    
    func updateUI() {
        guard let _ = viewIfLoaded
            else { return }
        
        if let imageUrl = model?.data.avatar {
            NetworkService.shared.getImage(imageUrl) {
                self.avatarImageView?.image = $0
                print($1 as Any)
            }
        }
        
        descriptionTextView?.text = model.map { Mirror(reflecting: $0) }
            .map { $0.textRepresentation(indent: "\t") }
    }
    
    @IBAction func logOut() {
        performSegue(withIdentifier: "logOut", sender: nil)
        PersistenceService.shared.deleteLoginInfo()
    }
}

extension Mirror {
    func textRepresentation(indent: String, start: Int = 0) -> String {
        let base = repeatElement(indent, count: start).joined()
        var text = base + "\(subjectType)\(displayStyle.map { ":\($0)" } ?? "")" + "\n"

        for child in children {
            text.append(contentsOf: base + (child.label ?? "unnamed child") + "\n")
            let m = Mirror(reflecting: child.value)
            if m.children.count > 0 {
                text.append(contentsOf: m.textRepresentation(indent: indent, start: start + 1))
            } else {
                text.append(contentsOf: base + indent + "\(m.subjectType):\(child.value)" + "\n")
            }
        }

        return text
    }
}
