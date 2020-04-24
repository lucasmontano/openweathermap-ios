//
//  BookmarkLocation.swift
//  openweathermap-ios
//
//  Created by Cassio Sousa on 24/04/20.
//

import Foundation

final class BookmarkLocation: NSObject {
    let title: String
    let latitude: String
    let longitude: String

    init(title: String, latitude: String, longitude: String) {
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
    }
}
