//
//  MapViewController.swift
//  openweathermap-ios
//

import UIKit
import MapKit

final class MapViewController: UIViewController {

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
    
    func updateAnnotation(location: CLLocationCoordinate2D) {
        let annotation = Annotation(coordinate: location, title: "Rio Grande", subtitle: "Mostly Cloudy")
        if let removeAnnotation = mapView.annotations.first {
            mapView.removeAnnotation(removeAnnotation)
        }
        mapView.addAnnotation(annotation)
    }
    
    func updateTarget(location: CLLocationCoordinate2D) {
        let circleCenter = MKCircle(center: location, radius: 5)
        let circleEdge = MKCircle(center: location, radius: 50)
        
        mapView.overlays.forEach { overlay in
            if overlay is MKCircle {
                mapView.removeOverlay(overlay)
            }
        }
        mapView.addOverlay(circleCenter)
        mapView.addOverlay(circleEdge)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard overlay is MKCircle else {
            return MKOverlayRenderer()
        }
        let renderer = MKCircleRenderer(overlay: overlay)
        renderer.fillColor = UIColor.black.withAlphaComponent(0.5)
        renderer.strokeColor = UIColor.black
        renderer.lineWidth = 1
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        updateAnnotation(location: mapView.centerCoordinate)
        mapView.overlays.forEach { overlay in
            if overlay is MKCircle {
                mapView.removeOverlay(overlay)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        if let annotation = mapView.annotations.first {
            mapView.removeAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        let annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "annotation")
        annotationView.canShowCallout = true
        annotationView.isSelected = true
        return annotationView
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        updateTarget(location: mapView.centerCoordinate)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse {
            let alertTitle = NSLocalizedString("titleUIAlertController", comment: "")
            let alertMessage = NSLocalizedString("messageUIAlertController", comment: "")
            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            
            let settingsTitle = NSLocalizedString("settingsUIAlertAction", comment: "")
            let settingsAction = UIAlertAction(title: settingsTitle, style: .default) { _ in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
            
            let cancelTitle = NSLocalizedString("cancelUIAlertAction", comment: "")
            let cancelAction = UIAlertAction(title: cancelTitle, style: .default, handler: nil)
            
            alertController.addAction(settingsAction)
            alertController.addAction(cancelAction)
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
}
