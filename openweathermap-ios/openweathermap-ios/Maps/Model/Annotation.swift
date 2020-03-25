//
//  Annotation.swift
//  openweathermap-ios
//

import MapKit

class Annotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }

    func image() -> UIImage {
        return UIImage(systemName: "mappin")!
    }
}
