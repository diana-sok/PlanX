//
//  ViewController.swift
//  WeatherPortion
//
//  Created by Roshini  Malempati  on 7/24/19.
//  Copyright © 2019 Roshini  Malempati . All rights reserved.
//
//
//import UIKit
//import Alamofire
//import SwiftyJSON
//import NVActivityIndicatorView
//import CoreLocation
//
//class ViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {
//    
//    // variables
//    @IBOutlet weak var weatherSearch: UISearchBar!
//    @IBOutlet weak var locationLbl: UILabel!
//    @IBOutlet weak var dayLbl: UILabel!
//    @IBOutlet weak var weatherImg: UIImageView!
//    @IBOutlet weak var weatherCondLbl: UILabel!
//    @IBOutlet weak var tempLbl: UILabel!
//    @IBOutlet weak var cityEntered: UITextField!
//    
//    let apikey = "237d5b4cee204fc6017dbb2410d31ace"
//    // coordinates for SJ
//    var lat = 13.35
//    var lon = 123.550003
//    var activityIndicator: NVActivityIndicatorView!
//    let locationManager = CLLocationManager()
//    
//    @IBAction func getWeatherofCityEntered(_ sender: AnyObject) {
//        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?q=\(cityEntered.text!)&APPID=\(apikey)&units=imperial").responseJSON {
//            response in
//            //self.activityIndicator.stopAnimating()
//            if let responseStr = response.result.value {
//                let jsonResponse = JSON(responseStr)
//                let jsonWeather = jsonResponse["weather"].array![0]
//                let jsonTemp = jsonResponse["main"]
//                let iconName = jsonWeather["icon"].stringValue
//                
//                self.locationLbl.text = jsonResponse["name"].stringValue
//                self.weatherImg.image = UIImage(named: iconName)
//                self.weatherCondLbl.text = jsonWeather["main"].stringValue
//                self.tempLbl.text = "\(Int(round(jsonTemp["temp"].doubleValue)))"
//                
//                let date = Date()
//                let dateFormat = DateFormatter()
//                dateFormat.dateFormat = "EEEE"
//                self.dayLbl.text = dateFormat.string(from: date)
//                
//            }
//        }
//            self.locationManager.stopUpdatingLocation()
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Do any additional setup after loading the view.
//       /*let indicatorSize: CGFloat = 70
//        let indicatorFrame = CGRect(x: (view.frame.width-indicatorSize)/2,y: (view.frame.height-indicatorSize)/2,width: indicatorSize,height: indicatorSize)
//        activityIndicator = NVActivityIndicatorView(frame: indicatorFrame, type: .lineScale, color: UIColor.white, padding: 20.0)
//        activityIndicator.backgroundColor = UIColor.black*/
//        
//        locationManager.requestWhenInUseAuthorization()
//        
//        //activityIndicator.startAnimating()
//        
//        if (CLLocationManager.locationServicesEnabled()) {
//            //weatherSearch.delegate = self
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.requestWhenInUseAuthorization()
//            locationManager.startUpdatingLocation()
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations[0]
//        lat = location.coordinate.latitude
//        lon = location.coordinate.longitude
//    Alamofire.request("http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&APPID=\(apikey)&units=imperial").responseJSON {
//            response in
//            //self.activityIndicator.stopAnimating()
//            if let responseStr = response.result.value {
//                let jsonResponse = JSON(responseStr)
//                let jsonWeather = jsonResponse["weather"].array![0]
//                let jsonTemp = jsonResponse["main"]
//                let iconName = jsonWeather["icon"].stringValue
//                
//                self.locationLbl.text = jsonResponse["name"].stringValue
//                self.weatherImg.image = UIImage(named: iconName)
//                self.weatherCondLbl.text = jsonWeather["main"].stringValue
//                self.tempLbl.text = "\(Int(round(jsonTemp["temp"].doubleValue)))"
//                
//                let date = Date()
//                let dateFormat = DateFormatter()
//                dateFormat.dateFormat = "EEEE"
//                self.dayLbl.text = dateFormat.string(from: date)
//                
//            }
//        }
//        if(location.horizontalAccuracy > 0) {
//            self.locationManager.stopUpdatingLocation()
//        }
//    }
//    
//}
//
