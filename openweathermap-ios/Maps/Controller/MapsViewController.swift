//
//  MapsViewController.swift
//  openweathermap-ios
//
//  Created by Felipe Weber on 13/03/20.
//  Copyright © 2020 Lucas Montano. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    

    @IBOutlet weak var mapView: MKMapView!
    var myLocationManager = CLLocationManager()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        myLocationManager.delegate = self
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        myLocationManager.requestWhenInUseAuthorization()
        myLocationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse{
            let alertController = UIAlertController(title: "Permission needed", message: "Without permission the app will not work correctly", preferredStyle: .alert)
            let actionConfig = UIAlertAction(title: "Settings", style: .default) { (alertConfig) in
                if let config = URL(string: UIApplication.openSettingsURLString){
                    UIApplication.shared.open(config)
                }
            }
            
            let actionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)

            alertController.addAction(actionConfig)
            alertController.addAction(actionCancel)
            present(alertController, animated: true, completion: nil)
        }
    }
    
}
