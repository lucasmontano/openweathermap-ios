
import XCTest

final class BookmarkLocationManagerTest: XCTestCase {

    private let locationKey = "location"
    private let sut = BookmarkLocationManager()
    private let userDefaults = UserDefaults.standard
    
    override func setUp() {
        super.setUp()
        removeBookmarkFromUserDefaults()
    }
    /**
        It validates if not exits elements
     */
    func testNoElementsBookmarkLocation() throws {
        let results = try sut.getAll()
        XCTAssertEqual(0, results.count)
    }
    
    /**
        It makes test to create one new Bookmark location
     */
    func testCcreateOneBookmarkLocation() throws {
        let bookmark = BookmarkLocation(title: "Florida - USA", latitude: "27.607668", longitude: "-81.604064")
        let results = try sut.save(bookmarkLocation: bookmark);
        XCTAssertEqual(1, results.count)
        XCTAssertEqual("Florida - USA", results.first?.title)
    }
    
    /**
        It makes test to create two new Bookmark location
    */
   func testCreateTwoBookmarkLocation() throws {
       let florida = BookmarkLocation(title: "Florida - USA", latitude: "27.607668", longitude: "-81.604064")
       let lisbon = BookmarkLocation(title: "Lisbon - PT", latitude: "38.7436883", longitude: "-9.1952225")
       
       let resultsFlorida = try sut.save(bookmarkLocation: florida);

        XCTAssertEqual(1, resultsFlorida.count)
    XCTAssertEqual("Florida - USA", resultsFlorida.first?.title)
    
       let results = try sut.save(bookmarkLocation: lisbon);

       XCTAssertEqual(2, results.count)
       XCTAssertEqual("Florida - USA", results.first?.title)
       XCTAssertEqual("Lisbon - PT", results.last?.title)
    }
    
    /**
        It validates if contains two elements in UserDefaults
     */
    func testExistsTwoElementsBookmarkLocation() throws {
        let florida = BookmarkLocation(title: "Florida - USA", latitude: "27.607668", longitude: "-81.604064")
        let lisbon = BookmarkLocation(title: "Lisbon - PT", latitude: "38.7436883", longitude: "-9.1952225")
        
        let _ = try sut.save(bookmarkLocation: florida);
        let _ = try sut.save(bookmarkLocation: lisbon);
        let results = try sut.getAll()
        XCTAssertEqual(2, results.count)
    }
    
    private func removeBookmarkFromUserDefaults() {
        userDefaults.removeObject(forKey: locationKey)
    }

}
