//
//  Skills.swift
//  SwiftyCompanions
//
//  Created by Ihor KOVALENKO on 11/20/19.
//  Copyright © 2019 Ihor KOVALENKO. All rights reserved.
//

import UIKit

class Skills: UITableViewCell {

    @IBOutlet weak var skillName: UILabel!
    @IBOutlet weak var progressSkill: UIProgressView!
    
    @IBOutlet weak var expLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
