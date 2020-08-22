//
//  ProfileViewController.swift
//  100DaysOfCode
//
//  Created by William Huynh on 8/22/20.
//  Copyright © 2020 wi2. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var entrys = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let user = PFUser.current()!
        
        self.navigationItem.title = user.username
        
        loadEntrys()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadEntrys()
    }
    
    @objc func loadEntrys() {
        let query = PFQuery(className: "Entrys")
        query.includeKey("author")
        query.whereKey("author", equalTo: PFUser.current()!)
        query.limit = 20
         query.order(byDescending: "createdAt")
        
        query.findObjectsInBackground { (entrys, error) in
            if entrys != nil {
                self.entrys = entrys!
                self.tableView.reloadData()
            }
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entrys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileProjectEntryCell") as! ProfileProjectEntryCell
        
        let entry = entrys[indexPath.row]
        
        cell.titleLabel.text = "Day \(entry["day"]!) - \(entry["project_name"] as! String)"
        cell.builtUsingLabel.text = "Built using \((entry["built_using"] as! String))"
        
        return cell
    }
    
    
}
