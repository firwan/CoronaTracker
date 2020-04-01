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
        
        Alamofire.request("https://covid-19-coronavirus-statistics.p.rapidapi.com/v1/stats?country=Malaysia", headers: headers).responseJSON { respond in
            //debugPrint(respond)
            if respond.result.isSuccess {
                print("#####Success get data#####")
                
                let dataJSON : JSON = JSON(respond.result.value!)
                //print(dataJSON)
                
                //===========Totalling num array of JSON data============
                var numberInfected = 0
                var numberDeath = 0
                var numberCured = 0
                let totalConfirmed = dataJSON["data"]["covid19Stats"].arrayValue
                for i in 0..<totalConfirmed.count {
                    numberInfected = numberInfected + dataJSON["data"]["covid19Stats"][i]["confirmed"].intValue
                    numberDeath = numberDeath + dataJSON["data"]["covid19Stats"][i]["deaths"].intValue
                    numberCured = numberCured + dataJSON["data"]["covid19Stats"][i]["recovered"].intValue
                }
                
                self.locationHome.text =  dataJSON["data"]["covid19Stats"][0]["country"].stringValue
                self.numberOfInfected.text = String(numberInfected)
                self.numberOfDeath.text = String(numberDeath)
                self.numberOfCured.text = String(numberCured)
                
                //print(dataJSON[""])
                //self.processCoronaData(json: dataJSON)
            }
        }
        //debugPrint(request)
    }
    
    func processCoronaData(json : JSON){
        //if let
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
    }


}

