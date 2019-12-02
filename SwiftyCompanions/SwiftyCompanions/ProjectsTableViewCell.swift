//
//  ProjectsTableViewCell.swift
//  SwiftyCompanions
//
//  Created by Ihor KOVALENKO on 12/2/19.
//  Copyright © 2019 Ihor KOVALENKO. All rights reserved.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var markLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
