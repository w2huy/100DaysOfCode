//
//  ProjectEntryCell.swift
//  100DaysOfCode
//
//  Created by William Huynh on 8/22/20.
//  Copyright © 2020 wi2. All rights reserved.
//

import UIKit

class ProjectEntryCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var builtUsingLabel: UILabel!
    @IBOutlet weak var dateSubmittedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
