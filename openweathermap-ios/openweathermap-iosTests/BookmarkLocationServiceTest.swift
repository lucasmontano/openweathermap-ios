//
//  BookmarkLocationServiceTest.swift
//  openweathermap-ios
//
//  Created by Cassio Sousa on 24/04/20.
//

import XCTest

class BookmarkLocationServiceTest: XCTestCase {

    private var bookmarkLocationService = BookmarkLocationService()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /**
            It makes test to create one new Bookmark location
     */
    func testCcreateOneBookmarkLocation() throws {
        let bookmarkLocation = BookmarkLocation(title: "Florida - USA", latitude: "27.607668", longitude: "-81.604064")
        
        let results = bookmarkLocationService.save(bookmarkLocation: bookmarkLocation);
        XCTAssert(results.count == 1)
    }
    
    /**
           It makes test to create two new Bookmark location
    */
   func testCreateTwoBookmarkLocation() throws {
       let bookmarkLocationFlorida = BookmarkLocation(title: "Florida - USA", latitude: "27.607668", longitude: "-81.604064")
       let bookmarkLocationLisbon = BookmarkLocation(title: "Lisbon - PT", latitude: "38.7436883", longitude: "-9.1952225")
       
       let resultsFlorida = bookmarkLocationService.save(bookmarkLocation: bookmarkLocationFlorida);
       XCTAssert(resultsFlorida.count == 1)
    
       let resultsLisbon = bookmarkLocationService.save(bookmarkLocation: bookmarkLocationLisbon);
       XCTAssert(resultsLisbon.count == 2)
   }

}
