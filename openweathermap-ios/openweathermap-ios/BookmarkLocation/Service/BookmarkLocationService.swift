//
//  BookmarkLocationService.swift
//  openweathermap-ios
//
//  Created by Cassio Sousa on 24/04/20.
//

import Foundation

class BookmarkLocationService: NSObject {

    func save(bookmarkLocation: BookmarkLocation) -> [BookmarkLocation] {

        return getAll()
    }

    func getAll() -> [BookmarkLocation] {
        return []
    }
}
