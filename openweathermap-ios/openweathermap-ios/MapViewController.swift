//
//  MapViewController.swift
//  openweathermap-ios
//


import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    
    func addAnnotation(location: CLLocationCoordinate2D){
        print("Coordenate center: \(mapView.centerCoordinate)")
        let circleCenter = MKCircle(center: location, radius: 50)
        let circleEdge = MKCircle(center: location, radius: 5)
        
        mapView.overlays.forEach { (overlay) in
            if (overlay is MKCircle){
                mapView.removeOverlay(overlay)
            }
        }
        mapView.addOverlay(circleCenter)
        mapView.addOverlay(circleEdge)
    }
}

extension MapViewController: MKMapViewDelegate{
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
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationUser = locations.last
        guard let latitude = locationUser?.coordinate.latitude else { return }
        guard let longitude = locationUser?.coordinate.longitude else { return }
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let mySpan = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: location, span: mySpan)
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
