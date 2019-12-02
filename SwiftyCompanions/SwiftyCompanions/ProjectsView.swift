//
//  ProjectsView.swift
//  SwiftyCompanions
//
//  Created by Ihor KOVALENKO on 12/2/19.
//  Copyright © 2019 Ihor KOVALENKO. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProjectsView: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var projectsData: JSON?
    @IBOutlet weak var projectsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        projectsTable.delegate = self
        projectsTable.dataSource = self
        projectsTable.backgroundColor = UIColor.clear
        self.title = projectsData!["login"].string! + "'s projects"
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_intra.jpg")!)

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectsData!["projects_users"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = projectsTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProjectsTableViewCell
        let projectVal = projectsData!["projects_users"][indexPath.row]["validated?"].int
        cell.backgroundColor = UIColor.clear
        cell.projectLabel.text = projectsData!["projects_users"][indexPath.row]["project"]["name"].string
        switch projectVal {
        case 1:
            cell.markLable.textColor = UIColor.green
            cell.markLable.text = String(projectsData!["projects_users"][indexPath.row]["final_mark"].int!) + " ✅"
        case 0:
            cell.markLable.textColor = UIColor.red
            cell.markLable.text = String(projectsData!["projects_users"][indexPath.row]["final_mark"].int!) + " ❌"
        default:
            cell.markLable.textColor = UIColor.white
            cell.markLable.text = "In progress"
        }
        projectsTable.rowHeight = UITableViewAutomaticDimension
        projectsTable.estimatedRowHeight = 44
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
