import Foundation

final class BookmarkLocation: NSObject, NSCoding {
    let title: String
    let latitude: String
    let longitude: String

    init?(coder: NSCoder) {
        guard
            let title = coder.decodeObject(forKey: BookmarkLocationKeys.title.rawValue) as? String,
            let latitude = coder.decodeObject(forKey: BookmarkLocationKeys.latitude.rawValue) as? String,
            let longitude = coder.decodeObject(forKey: BookmarkLocationKeys.longitude.rawValue) as? String
        else {
            self.title = ""
            self.latitude = ""
            self.longitude = ""
            return
        }
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
    }
    init(title: String, latitude: String, longitude: String) {
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
    }
    func encode(with coder: NSCoder) {
        coder.encode(self.title, forKey: BookmarkLocationKeys.title.rawValue)
        coder.encode(self.latitude, forKey: BookmarkLocationKeys.latitude.rawValue)
        coder.encode(self.longitude, forKey: BookmarkLocationKeys.longitude.rawValue)
    }
}

// MARK: Extension BookmarkLocationKeys enum
extension BookmarkLocation {
    private enum BookmarkLocationKeys: String {
        case title, latitude, longitude
    }
}
