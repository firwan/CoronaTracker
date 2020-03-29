//
//  ViewController.swift
//  CoronaTracker
//
//  Created by Firwan Moksin on 12/03/2020.
//  Copyright © 2020 FrostGarde Tech. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var locationHome: UILabel!
    @IBOutlet weak var numberOfInfected: UILabel!
    @IBOutlet weak var numberOfDeath: UILabel!
    @IBOutlet weak var numberOfCured: UILabel!
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
    }
    
    @IBAction func countryNameTextField(_ sender: UITextField) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let headers : HTTPHeaders = [
            "x-rapidapi-host": "covid-19-coronavirus-statistics.p.rapidapi.com",
            "x-rapidapi-key": "83d0c40c36msh3884d468151c6eep107c2bjsnd86081dbb941"
        ]
        
        let request = Alamofire.request("https://covid-19-coronavirus-statistics.p.rapidapi.com/v1/stats?country=Malaysia", headers: headers).responseJSON { respond in
            debugPrint(respond)
            if respond.result.isSuccess {
                print("#####Success get data#####")
                
                let dataJSON : JSON = JSON(respond.result.value!)
                print(dataJSON)
                
                self.locationHome.text =  dataJSON["data"]["covid19Stats"][0]["country"].stringValue
                self.numberOfInfected.text = String(dataJSON["data"]["covid19Stats"][0]["confirmed"].intValue)
                self.numberOfDeath.text = String(dataJSON["data"]["covid19Stats"][0]["deaths"].intValue)
                self.numberOfCured.text = String(dataJSON["data"]["covid19Stats"][0]["recovered"].intValue)
                
                //print(dataJSON[""])
                //self.processCoronaData(json: dataJSON)
            }
        }
        debugPrint(request)
        
    }
    
    func processCoronaData(json : JSON){
        //if let
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
    }


}

