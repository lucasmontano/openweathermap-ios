//
//  BookmarkLocationServiceTest.swift
//  openweathermap-ios
//
//  Created by Cassio Sousa on 24/04/20.
//

import XCTest

class BookmarkLocationManagerTest: XCTestCase {

    private var bookmarkLocationManager = BookmarkLocationManager()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /**
        It validates if not exits elementes
     */
    func testNoElementsBookmarkLocation() throws {
        UserDefaults.standard.removeObject(forKey: BookmarLocationEnumaration.bookmarkLocation.rawValue)
        
        let results = bookmarkLocationManager.getAll();
        XCTAssert(results.count == 0)
    }
    
    /**
        It makes test to create one new Bookmark location
     */
    func testCcreateOneBookmarkLocation() throws {
        UserDefaults.standard.removeObject(forKey: BookmarLocationEnumaration.bookmarkLocation.rawValue)
        let bookmarkLocation = BookmarkLocation(title: "Florida - USA", latitude: "27.607668", longitude: "-81.604064")
        
        let results = bookmarkLocationManager.save(bookmarkLocation: bookmarkLocation);
        XCTAssert(results.count == 1)
        XCTAssert(results[0].title == "Florida - USA")
    }
    
    /**
        It makes test to create two new Bookmark location
    */
   func testCreateTwoBookmarkLocation() throws {
       UserDefaults.standard.removeObject(forKey: BookmarLocationEnumaration.bookmarkLocation.rawValue)
       let bookmarkLocationFlorida = BookmarkLocation(title: "Florida - USA", latitude: "27.607668", longitude: "-81.604064")
       let bookmarkLocationLisbon = BookmarkLocation(title: "Lisbon - PT", latitude: "38.7436883", longitude: "-9.1952225")
       
       let resultsFlorida = bookmarkLocationManager.save(bookmarkLocation: bookmarkLocationFlorida);

       XCTAssert(resultsFlorida.count == 1)
       XCTAssert(resultsFlorida[0].title == "Florida - USA")
    
       let resultsLisbon = bookmarkLocationManager.save(bookmarkLocation: bookmarkLocationLisbon);

       XCTAssert(resultsLisbon.count == 2)
       XCTAssert(resultsLisbon[0].title == "Florida - USA")
       XCTAssert(resultsLisbon[1].title == "Lisbon - PT")
    }
    
    /**
        It validates if contains two elements in UserDefaults
     */
    func testExistsTwoElementsBookmarkLocation() throws {
        UserDefaults.standard.removeObject(forKey: BookmarLocationEnumaration.bookmarkLocation.rawValue)
        let bookmarkLocationFlorida = BookmarkLocation(title: "Florida - USA", latitude: "27.607668", longitude: "-81.604064")
        let bookmarkLocationLisbon = BookmarkLocation(title: "Lisbon - PT", latitude: "38.7436883", longitude: "-9.1952225")
        
        let _ = bookmarkLocationManager.save(bookmarkLocation: bookmarkLocationFlorida);
        let _ = bookmarkLocationManager.save(bookmarkLocation: bookmarkLocationLisbon);
        let results = bookmarkLocationManager.getAll()
        XCTAssert(results.count == 2)
    }

}
