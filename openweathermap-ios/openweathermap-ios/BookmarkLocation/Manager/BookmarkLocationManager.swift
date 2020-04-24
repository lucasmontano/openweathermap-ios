//
//  BookmarkLocationService.swift
//  openweathermap-ios
//
//  Created by Cassio Sousa on 24/04/20.
//

import Foundation

class BookmarkLocationManager: NSObject {

    func save(bookmarkLocation: BookmarkLocation) -> [BookmarkLocation] {
        var allBookmarks = getAll()
        let defaults = UserDefaults.standard
        allBookmarks.append(bookmarkLocation)
        let archiveData = self.archiveData(allBookmarks)
        defaults.set(archiveData, forKey: BookmarLocationEnumaration.bookmarkLocation.rawValue)
        return allBookmarks
    }

    func getAll() -> [BookmarkLocation] {
        return unArchiveData()
    }

    fileprivate func archiveData(_ allBokkmarks: [BookmarkLocation]) -> Data {
        do {
            let archiveData = try NSKeyedArchiver.archivedData(withRootObject: allBokkmarks, requiringSecureCoding: false)
            return archiveData
        } catch let error {
            debugPrint(error)
        }
        return Data()
    }

    fileprivate func unArchiveData() -> [BookmarkLocation] {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: BookmarLocationEnumaration.bookmarkLocation.rawValue) {
            do {
                let bookmarkLocations = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
                return bookmarkLocations as? [BookmarkLocation] ?? [BookmarkLocation]()
            } catch let error {
                debugPrint(error)
           }
        }
        return [BookmarkLocation]()
    }
}
