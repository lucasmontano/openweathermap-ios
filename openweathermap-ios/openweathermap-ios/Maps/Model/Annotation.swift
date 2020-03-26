import MapKit

final class Annotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }

    func image() -> UIImage {
        guard let image = UIImage(systemName: "mappin") else { return UIImage() }
        return image
    }
}
