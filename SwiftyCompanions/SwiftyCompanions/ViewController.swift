//
//  ViewController.swift
//  SwiftyCompanions
//
//  Created by Ihor KOVALENKO on 11/8/19.
//  Copyright © 2019 Ihor KOVALENKO. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var searchBtn : UIButton!
    @IBOutlet weak var textField: UITextField!
    
    let client_id = "85a13d24b7da211945f6566835b38999eeb84f5485dd516f51519e5ccc730a0a"
    let client_secret = "1dbeb96d6336f0f78ed96e8c1f21a64bb9e20ed18dda11a779abb36cdb08068a"
    
    var token = "";
    var data: JSON?
    
    
    func getToken() {
        let params: Parameters = ["grant_type": "client_credentials", "client_id": client_id, "client_secret": client_secret]
            Alamofire.request("https://api.intra.42.fr/oauth/token", method: .post, parameters: params).responseJSON {
                response in
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        self.token = json["access_token"].string!
                    }
                case .failure:
                    print("Error: Failed to load token")
                        
                }
            }
}
    
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        if sender.text != "" {
            searchBtn.isEnabled = true;
        }
        else {
            searchBtn.isEnabled = false;
        }
    }
    
    @IBAction func searchButton(_ sender: Any) {
        print(token);
        if let login = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            Alamofire.request("https://api.intra.42.fr/v2/users/" + login, method: .get, parameters: ["access_token": self.token]).responseJSON { response in
                switch response.result {
                case .success:
                 //   print(response.result.value)
                    if let value = response.result.value {
                        let json = JSON(value)
                        if json.count == 0 {
                            let alert = UIAlertController(title: "Error", message: "This login does not exist", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true)
                            print("Couldn't find login")
                            return
                        }
                        self.data = json;
                        self.performSegue(withIdentifier: "IntraProfile", sender: nil)
                    }
                case .failure:
                    print("Couldn't do a request");
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "IntraProfile" {
            let new = segue.destination as! IntraProfile
            new.profileData = data;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_intra.jpg")!)
        getToken()
        searchBtn.isEnabled = false;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

