import Foundation
import os.log

class BookmarkLocationManager {

    func save(bookmarkLocation: BookmarkLocation) throws -> [BookmarkLocation] {
        var allBookmarks = [BookmarkLocation]()
        do {
            try allBookmarks = getAll()
        } catch BookmarkLocationError.keyNotFound {
            os_log(.info,
                   "In this method this error occur when %{WHO}@ doesn't exists in UserDefaults int the first time. This message is expect in this case.",
                    Bookmark.location.rawValue
            )
        }

        let defaults = UserDefaults.standard
        allBookmarks.append(bookmarkLocation)
        let archiveData = try self.archiveData(allBookmarks)
        defaults.set(archiveData, forKey: Bookmark.location.rawValue)
        return allBookmarks
    }

    func getAll() throws -> [BookmarkLocation] {
        return try unArchiveData()
    }

    private func archiveData(_ allBokkmarks: [BookmarkLocation]) throws -> Data {
        do {
            let archiveData = try NSKeyedArchiver.archivedData( withRootObject: allBokkmarks, requiringSecureCoding: false)
            return archiveData
        } catch let error {
            print(error)
            throw BookmarkLocationError.archive("Unexpected error at unArchive data: \(error.localizedDescription)")
        }
    }

    private func unArchiveData() throws -> [BookmarkLocation] {
        let defaults = UserDefaults.standard
        guard let data = defaults.data(forKey: Bookmark.location.rawValue) else {
            throw BookmarkLocationError.keyNotFound("Unexpected error at unArchive data: Key \(Bookmark.location.rawValue) not found.")
        }

        do {
            let bookmarkLocations = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
            guard let bookmarks = bookmarkLocations as? [BookmarkLocation] else {
                return [BookmarkLocation]()
            }
            return  bookmarks
        } catch let error {
            throw BookmarkLocationError.unArchive("Unexpected error at unArchive data: \(error.localizedDescription)")
        }
    }
}

// MARK: Extension BookmarLocation enum error
extension BookmarkLocationManager {
    enum BookmarkLocationError: Error {
        case unArchive(String)
        case keyNotFound(String)
        case archive(String)
    }
}
