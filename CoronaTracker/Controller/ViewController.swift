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
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    //========Constant for Google Geocoding========
    // Sample url : https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=API_KEY
    // Parameters : latlng & key[GMAP_API_KEY]
    let GMAP_API_KEY : String = "AIzaSyDTbednIGfvKoSEt0jDX68QxRBJIeCYdbc"
    let GMAP_URL : String = "https://maps.googleapis.com/maps/api/geocode/json"
    
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
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //==========Get corana data in JSON==========
        let headers : HTTPHeaders = [
            "x-rapidapi-host": "covid-19-coronavirus-statistics.p.rapidapi.com",
            "x-rapidapi-key": "83d0c40c36msh3884d468151c6eep107c2bjsnd86081dbb941"
        ]
        
        let request = Alamofire.request("https://covid-19-coronavirus-statistics.p.rapidapi.com/v1/stats?country=Malaysia", headers: headers).responseJSON { respond in
            //debugPrint(respond)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
    }
    
    func getCountryName(url : String, parameters : [String : String]) {
        Alamofire.request(url, method : .get, parameters : parameters).responseJSON {
            respond in
            if respond.result.isSuccess {
                print("*****GOT JSON LOCATION DATA******")
                
                let locationJSON : JSON = JSON(respond.result.value!)
                print(locationJSON)
            }
            else {
                print(respond.result.error!)
                self.locationHome.text = "Network Error!"
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            print("longitude = \(location.coordinate.longitude) , latitude = \(location.coordinate.latitude)")
            
            let longitude = String(location.coordinate.longitude)
            let latitude = String(location.coordinate.latitude)
            
            let params : [String : String] = ["latlng" : "\(latitude),\(longitude)", "key" : GMAP_API_KEY]
            
            getCountryName(url: GMAP_URL, parameters: params)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        locationHome.text = "Error loading location!"
    }
    
}

