//
//  BookmarkLocationServiceTest.swift
//  openweathermap-ios
//
//  Created by Cassio Sousa on 24/04/20.
//

import XCTest

final class BookmarkLocationManagerTest: XCTestCase {

    private let sut = BookmarkLocationManager()
    private let userDefaults = UserDefaults.standard
    
    override func setUp() {
        removeBookmarkFromUserDefaults()
    }
    /**
        It validates if not exits elements
     */
    func testNoElementsBookmarkLocation() throws {
        XCTAssertThrowsError(try sut.getAll(),"Unexpected error at unArchive data: Key \(BookmarkLocationEnumaration.bookmarkLocation.rawValue) not found.")
    }
    
    /**
        It makes test to create one new Bookmark location
     */
    func testCcreateOneBookmarkLocation() throws {
        let bookmark = BookmarkLocation(title: "Florida - USA", latitude: "27.607668", longitude: "-81.604064")
        let results = try sut.save(bookmarkLocation: bookmark);
        XCTAssertEqual(1, results.count)
        XCTAssertEqual("Florida - USA", results[0].title)
    }
    
    /**
        It makes test to create two new Bookmark location
    */
   func testCreateTwoBookmarkLocation() throws {
       let bookmarkFlorida = BookmarkLocation(title: "Florida - USA", latitude: "27.607668", longitude: "-81.604064")
       let bookmarLisbon = BookmarkLocation(title: "Lisbon - PT", latitude: "38.7436883", longitude: "-9.1952225")
       
       let resultsFlorida = try sut.save(bookmarkLocation: bookmarkFlorida);

        XCTAssertEqual(1, resultsFlorida.count)
        XCTAssertEqual("Florida - USA", resultsFlorida[0].title)
    
       let results = try sut.save(bookmarkLocation: bookmarLisbon);

       XCTAssertEqual(2, results.count)
       XCTAssertEqual("Florida - USA", results[0].title)
       XCTAssertEqual("Lisbon - PT", results[1].title)
    }
    
    /**
        It validates if contains two elements in UserDefaults
     */
    func testExistsTwoElementsBookmarkLocation() throws {
        let bookmarkLocationFlorida = BookmarkLocation(title: "Florida - USA", latitude: "27.607668", longitude: "-81.604064")
        let bookmarkLocationLisbon = BookmarkLocation(title: "Lisbon - PT", latitude: "38.7436883", longitude: "-9.1952225")
        
        let _ = try sut.save(bookmarkLocation: bookmarkLocationFlorida);
        let _ = try sut.save(bookmarkLocation: bookmarkLocationLisbon);
        let results = try sut.getAll()
        XCTAssertEqual(2, results.count)
    }
    
    private func removeBookmarkFromUserDefaults() {
        userDefaults.removeObject(forKey: BookmarkLocationEnumaration.bookmarkLocation.rawValue)
    }

}
