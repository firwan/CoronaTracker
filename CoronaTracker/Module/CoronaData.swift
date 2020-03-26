//
//  CoronaData.swift
//  CoronaTracker
//
//  Created by Firwan Moksin on 20/03/2020.
//  Copyright © 2020 FrostGarde Tech. All rights reserved.
//

import Foundation
import Alamofire

func header() {
    let headers : HTTPHeaders = [
        "x-rapidapi-host": "covid-19-coronavirus-statistics.p.rapidapi.com",
        "x-rapidapi-key": "83d0c40c36msh3884d468151c6eep107c2bjsnd86081dbb941"
    ]
    
    let request = Alamofire.request("https://covid-19-coronavirus-statistics.p.rapidapi.com/v1/stats?country=Malaysia", headers: headers).responseJSON { respond in
        debugPrint(respond)
    }
    debugPrint(request)
}



//let request = NSMutableURLRequest(url: NSURL(string: "https://covid-19-coronavirus-statistics.p.rapidapi.com/v1/stats?country=Canada")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
//
//request.httpMethod = "GET"
//request.allHTTPHeaderFields = headers
//
//let session = URLSession.shared
//let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//    if (error != nil) {
//        print(error)
//    } else {
//        let httpResponse = response as? HTTPURLResponse
//        print(httpResponse)
//    }
//})
//
//dataTask.resume()
