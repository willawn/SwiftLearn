//
//  WeatherViewController.swift
//  SwiftLearn
//
//  Created by iimgal on 2018/12/24.
//  Copyright © 2018 jerry. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

let GD_KEY = "374d34e4c13da1543a1198556679dc7f"

class WeatherViewController: UIViewController, LocationServiceDelegate {
    @IBOutlet weak var tableWeather: UITableView!
    private var locationService:LocationService = LocationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationService.delegate = self
        locationService.requestLocation()
    }
    
    func locationDidUpdate(_ service: LocationService, location: CLLocation) {
        print("定位成功 \(location)")
        
        //通过经纬度查询城市码
        Alamofire.request("https://restapi.amap.com/v3/assistant/coordinate/convert?locations=\(location.coordinate.longitude),\(location.coordinate.latitude)&coordsys=gps&output=json&key=\(GD_KEY)").responseJSON { (response) in
            print(response)
            
            if response.result.isSuccess {
                if let jsonCity = response.result.value {
                    print("通过经纬度查询城市码\nJSON: \(jsonCity)")
                    //通过城市码查询天气
                    var adcode = self.parseJSONBySwiftJson(jsonCity)
                    if !adcode.isEqual("440300") {
                        adcode = "440300"
                    }
                    Alamofire.request("https://restapi.amap.com/v3/weather/weatherInfo?city=\(adcode)&key=\(GD_KEY)").responseJSON(completionHandler: { (response) in
                        if response.result.isSuccess {
                            if let jsonWeather = response.result.value {
                                print("通过城市码查询天气\nJSON: \(jsonWeather)")
                                let json = JSON(jsonWeather)
//                                let adcode = json["infocode"].stringValue
                            }
                        }
                    })
                }
            }
        }
    }
    
    func locationDidFail(_ service: LocationService, error: Error) {
        print("定位失败 \(error)")
    }
    
    func requestAdcode(location: CLLocation) -> Int {
        return 0;
    }
    
    func parseJSONBySwiftJson(_ jsonValue: Any?) -> String {
        let json = JSON(jsonValue!)
        let adcode = json["infocode"].stringValue
        
        return adcode
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
