//
//  IntraProfile.swift
//  SwiftyCompanions
//
//  Created by Ihor KOVALENKO on 11/18/19.
//  Copyright © 2019 Ihor KOVALENKO. All rights reserved.
//

import UIKit
import SwiftyJSON

class IntraProfile: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var skillsTable: UITableView!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var correctionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var profileData: JSON?
    
    override func viewDidLoad() {
        skillsTable.delegate = self
        skillsTable.dataSource = self
        skillsTable.backgroundColor = UIColor.clear
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_intra.jpg")!)
        if let value = profileData!["displayname"].string {
            if let value1 = profileData!["login"].string {
                loginLabel.text = value + " (\(value1))"
            }
        }
        if let value = profileData!["email"].string {
            emailLabel.text = value
        }
        if let value = profileData!["location"].string {
            locationLabel.text = "Available - \(value)"
        } else {
            locationLabel.text = "Unavailable"
        }
        if let value = profileData!["correction_point"].int {
            correctionLabel.text = "Correction points: \(value)"
        }
        let image = profileData!["image_url"].string!
        if let url = URL(string : image) {
            if let data = NSData(contentsOf: url) {
                photoView.image = UIImage(data: data as Data)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileData!["cursus_users"][0]["skills"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = skillsTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Skills
        let level = profileData!["cursus_users"][0]["skills"][indexPath.row]["level"].float!
        cell.backgroundColor = UIColor.clear
        cell.skillName.text = profileData!["cursus_users"][0]["skills"][indexPath.row]["name"].string
        cell.expLabel.text = String (level)
        cell.progressSkill.progress = level/50
        skillsTable.rowHeight = UITableViewAutomaticDimension
        skillsTable.estimatedRowHeight = 44
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProjectsView" {
            let new = segue.destination as! ProjectsView
            new.projectsData = profileData
        }
    }
}
