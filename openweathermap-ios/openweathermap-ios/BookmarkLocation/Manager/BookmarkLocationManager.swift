import Foundation
import os.log

class BookmarkLocationManager {

    func save(bookmarkLocation: BookmarkLocation) throws -> [BookmarkLocation] {
        var allBookmarks = try getAll()
        let defaults = UserDefaults.standard
        allBookmarks.append(bookmarkLocation)
        let archiveData = try self.archiveData(allBookmarks)
        defaults.set(archiveData, forKey: Bookmark.location.rawValue)
        return allBookmarks
    }

    func getAll() throws -> [BookmarkLocation] {
        let bookmarks: [BookmarkLocation] = (try? unArchiveData()) ?? .init()
        return bookmarks
    }

    private func archiveData(_ allBokkmarks: [BookmarkLocation]) throws -> Data {
        do {
            let archiveData = try NSKeyedArchiver.archivedData( withRootObject: allBokkmarks, requiringSecureCoding: false)
            return archiveData
        } catch let error {
            throw BookmarkLocationError.archive("Unexpected error at unArchive data: \(error.localizedDescription)")
        }
    }

    private func unArchiveData() throws -> [BookmarkLocation]? {
        let defaults = UserDefaults.standard
        guard let data = defaults.data(forKey: Bookmark.location.rawValue) else {
            throw BookmarkLocationError.keyNotFound("Unexpected error at unArchive data: Key \(Bookmark.location.rawValue) not found.")
        }

        do {
            let bookmarkLocations = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
            guard let bookmarks = bookmarkLocations as? [BookmarkLocation] else {
                throw BookmarkLocationError.unArchive("Unexpected error at unArchive wasn't possible unwrapper bookmark location.")
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
