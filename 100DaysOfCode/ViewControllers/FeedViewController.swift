//
//  FeedViewController.swift
//  100DaysOfCode
//
//  Created by William Huynh on 8/22/20.
//  Copyright © 2020 wi2. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController {

    var entrys = [PFObject]()
    let myRefreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadEntrys()
        myRefreshControl.addTarget(self, action: #selector(loadEntrys), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadEntrys()
    }
    
    @objc func loadEntrys() {
        let query = PFQuery(className: "Entrys")
        query.includeKey("author")
        query.limit = 20
         query.order(byDescending: "createdAt")
        
        query.findObjectsInBackground { (entrys, error) in
            if entrys != nil {
                self.entrys = entrys!
                self.tableView.reloadData()
                self.myRefreshControl.endRefreshing()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sender = sender as? UITableViewCell {
            let cell = sender
            let indexpath = tableView.indexPath(for: cell)!
            
            let entry = entrys[indexpath.row]
            
            let webVC = segue.destination as! WebViewController
            webVC.entry = entry
        }
        
    }

}

extension FeedViewController: UITableViewDelegate {
    
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entrys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectEntryCell") as! ProjectEntryCell
        
        let entry = entrys[indexPath.row]
        
        let user = entry["author"] as! PFUser
        cell.titleLabel.text = "Day \(entry["day"]!) - \(entry["project_name"] as! String)"
        cell.builtUsingLabel.text = "\(user.username!) - Built using \((entry["built_using"] as! String))"
        
        
        let date = entry.createdAt
        
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
         
        // US English Locale (en_US)
        df.locale = Locale(identifier: "en_US")
        cell.dateSubmittedLabel.text = "Submitted \(df.string(from: date!))"
        
        return cell
    }
    
    
}
