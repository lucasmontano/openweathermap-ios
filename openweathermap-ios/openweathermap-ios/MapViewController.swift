//
//  MapViewController.swift
//  openweathermap-ios
//


import UIKit
import MapKit

final class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet private weak var mapView: MKMapView!
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    
    func addAnnotation(location: CLLocationCoordinate2D){
        let circleCenter = MKCircle(center: location, radius: 5)
        let circleEdge = MKCircle(center: location, radius: 50)
        
        mapView.overlays.forEach { overlay in
            if overlay is MKCircle{
                mapView.removeOverlay(overlay)
            }
        }
        mapView.addOverlay(circleCenter)
        mapView.addOverlay(circleEdge)
    }
}

extension MapViewController: MKMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse {
            let localizedTitleAlertController = NSLocalizedString("titleUIAlertController", comment: "")
            let localizedContentAlertController = NSLocalizedString("messageUIAlertController", comment: "")
            let alertController = UIAlertController(title: localizedTitleAlertController, message: localizedContentAlertController, preferredStyle: .alert)
            
            let localizedTitleAlertActionConfig = NSLocalizedString("settingsUIAlertAction", comment: "")
            let actionConfig = UIAlertAction(title: localizedTitleAlertActionConfig, style: .default) { alertConfig in
                if let config = URL(string: UIApplication.openSettingsURLString){
                    UIApplication.shared.open(config)
                }
            }
            
            let localizedTitleAlertActionCancel = NSLocalizedString("cancelUIAlertAction", comment: "")
            let actionCancel = UIAlertAction(title: localizedTitleAlertActionCancel, style: .default, handler: nil)
            
            alertController.addAction(actionConfig)
            alertController.addAction(actionCancel)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationUser = locations.last else { return }
        let latitude = locationUser.coordinate.latitude
        let longitude = locationUser.coordinate.longitude
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle{
            let renderer = MKCircleRenderer(overlay: overlay)
            renderer.fillColor = UIColor.black.withAlphaComponent(0.5)
            renderer.strokeColor = UIColor.black
            renderer.lineWidth = 1
            return renderer
        }
        
        return MKOverlayRenderer()
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        addAnnotation(location: mapView.centerCoordinate)
    }
}

extension String {
    func localizableString(loc: String) -> String {
        guard let path = Bundle.main.path(forResource: loc, ofType: "lproj") else { return ""}
        guard let bundle = Bundle(path: path) else { return ""}
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
