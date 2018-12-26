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
import MBProgressHUD

let GD_KEY = "374d34e4c13da1543a1198556679dc7f"

class WeatherViewController: UIViewController, LocationServiceDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableWeather: UITableView!
    private var array:[String] = []
    private var locationService:LocationService = LocationService()
    private var hud: MBProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        //小矩形的背景色
        hud?.bezelView.color = UIColor.clear
        //显示的文字
        hud?.label.text = "加载中..."
        //细节文字
        hud?.detailsLabel.text = "请耐心等待..."
        //设置背景，加遮罩
        hud?.backgroundView.style = .blur
        
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
                                for (wKey, wValue) in json["lives"][0] {
                                    print("遍历结果：\(wKey)\t\(wValue)")
                                    self.array.append("\(wKey):\(wValue)")
                                }
                                
                                self.hud?.hide(animated: true, afterDelay: 1)
                                self.tableWeather.reloadData()
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "UITableViewCell"
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell(style: .default, reuseIdentifier: identifier)
        cell.textLabel?.text = self.array[indexPath.row]
        
        return cell
    }
}
