//
//  LocationLoad.swift
//  MBAComing
//
//  Created by 江城 on 2018/10/24.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import Foundation
import CoreLocation

class LocationLoad: NSObject, CLLocationManagerDelegate {
    private static let manager = LocationLoad()
    private override init() {
        super.init()
    }
    
    static var share: LocationLoad {
        return manager
    }
    
    private var locationManager = CLLocationManager()
    
    private var currentLocation : CLLocation?
    
    var city : String?
    
    func startLoading() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        //始终允许访问位置信息
        locationManager.requestAlwaysAuthorization()
        //使用应用程序期间允许访问位置数据
        locationManager.requestWhenInUseAuthorization()
        //开始开启定位
        locationManager.startUpdatingLocation()
    }
    
    /// 定位成功
    ///
    /// - Parameters:
    ///   - manager: 定位handle
    ///   - locations: location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
        if let _ = currentLocation {
            //解析定位
            analysisLocation()
            //停止定位
            locationManager.stopUpdatingLocation()
        }
    }
    
    /// 定位失败
    ///
    /// - Parameters:
    ///   - manager: 定位handle
    ///   - error: 描述
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        JCLog(message: error?.localizedDescription)
        //发送失败通知
        NotificationCenter.default.post(name: NSNotification.Name.updateLocationFail, object: nil)
    }
    
    private func analysisLocation() {
        let gec = CLGeocoder.init()
        gec.reverseGeocodeLocation(currentLocation!) { (placeMark, error) in
            if let err = error {
                //发送失败通知
                NotificationCenter.default.post(name: NSNotification.Name.updateLocationFail, object: nil)
                JCLog(message: err.localizedDescription)
            }else{
                if let places = placeMark,
                    let mark = places.first,
                    let address = mark.addressDictionary,
                    let city = address["City"] as? String {
                    let tCity = NSString.init(string: city)
                    let citynameStr : String = tCity.replacingOccurrences(of: "市", with: "")
                    self.city = citynameStr
                    JCLog(message: citynameStr)
                    //发送成功通知
                    NotificationCenter.default.post(name: NSNotification.Name.updateLocationSuccess, object: nil, userInfo: ["City" : citynameStr])
                }
            }
        }
    }
}
