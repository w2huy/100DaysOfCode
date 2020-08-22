//
//  CameraViewController.swift
//  100DaysOfCode
//
//  Created by William Huynh on 8/22/20.
//  Copyright © 2020 wi2. All rights reserved.
//

import UIKit
import Parse

class AddProjectEntryViewController: UIViewController {

    @IBOutlet weak var projectNameField: UITextField!
    @IBOutlet weak var builtUsingField: UITextField!
    @IBOutlet weak var githubUrlField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func onSubmit(_ sender: Any) {
        
        let entry = PFObject(className: "Entrys")
        
        let user = PFUser.current()!
        entry["project_name"] = projectNameField.text
        entry["built_using"] = builtUsingField.text
        entry["github_url"] = githubUrlField.text
        entry["author"] = user
        entry["day"] = user["dayCount"]
        if let day = user["dayCount"] {
            user["dayCount"] = day as! Int + 1
        }
        
        user.saveInBackground(block: { (success, error) in
            if success {
                print("User Day Saved!")
            }
            else if let error = error {
                print("Error: \(error)")
            }
        })
        
        entry.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("Entry Saved!")
            }
            else if let error = error {
                print("Error: \(error)")
            }
        }
    }
    
}
