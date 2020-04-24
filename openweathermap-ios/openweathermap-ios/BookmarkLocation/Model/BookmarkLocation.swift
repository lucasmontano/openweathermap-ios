//
//  BookmarkLocation.swift
//  openweathermap-ios
//
//  Created by Cassio Sousa on 24/04/20.
//

import Foundation

private enum BookmarkLocationKeys: String {
    case title, latitude, longitude
}

final class BookmarkLocation: NSObject, NSCoding {
    let title: String?
    let latitude: String?
    let longitude: String?

    init?(coder: NSCoder) {
        self.title = coder.decodeObject(forKey: BookmarkLocationKeys.title.rawValue) as? String
        self.latitude = coder.decodeObject(forKey: BookmarkLocationKeys.latitude.rawValue) as? String
        self.longitude = coder.decodeObject(forKey: BookmarkLocationKeys.longitude.rawValue) as? String
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
