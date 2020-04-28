import Foundation

final class BookmarkLocationManager {

    private let locationKey = "location"

    func save(bookmarkLocation: BookmarkLocation) throws -> [BookmarkLocation] {
        var allBookmarks = getAll()
        let defaults = UserDefaults.standard
        allBookmarks.append(bookmarkLocation)
        let archiveData = try self.archiveData(allBookmarks)
        defaults.set(archiveData, forKey: locationKey)
        return allBookmarks
    }

    func getAll() -> [BookmarkLocation] {
        return (try? unArchiveData()) ?? .init()
    }

    private func archiveData(_ allBokkmarks: [BookmarkLocation]) throws -> Data {
        do {
            return  try NSKeyedArchiver.archivedData( withRootObject: allBokkmarks, requiringSecureCoding: false)
        } catch let error {
            throw BookmarkLocationError.archive("Unexpected error at unArchive data: \(error.localizedDescription)")
        }
    }

    private func unArchiveData() throws -> [BookmarkLocation]? {
        let defaults = UserDefaults.standard
        guard let data = defaults.data(forKey: locationKey) else {
            throw BookmarkLocationError.keyNotFound("Unexpected error at unArchive data: Key \(locationKey) not found.")
        }

        do {
            let bookmarkLocations = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
            guard let bookmarks = bookmarkLocations as? [BookmarkLocation] else {
                throw BookmarkLocationError.unArchive(
                    "Unexpected error at unArchive wasn't possible unwrapper bookmark location."
                )
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
