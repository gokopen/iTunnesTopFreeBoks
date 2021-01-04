//
//  iTunnesTopFreeBooksTests.swift
//  iTunnesTopFreeBooksTests
//
//  Created by Gokhan Alp on 2.01.2021.
//

import XCTest
@testable import iTunnesTopFreeBooks

class iTunnesTopFreeBooksTests: XCTestCase {
    
    let api = Api()
    let timeout: TimeInterval = 60.0

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testApiOfGetTopFreeBooks() {
        let expectation = XCTestExpectation(description: "JobEnd")
        api.getTopFreeBooks { (success, response) in
            XCTAssertEqual(success, true)
            XCTAssertNotNil(response)
            XCTAssertNotNil(response?.feed)
            XCTAssertNotNil(response?.feed?.results)
            XCTAssertGreaterThan(response?.feed?.results?.count ?? 0, 0)
            if let results = response?.feed?.results, results.count > 0 {
                for item in results {
                    XCTAssertNotNil(item.id)
                    XCTAssertNotNil(item.name)
                    XCTAssertNotNil(item.artworkUrl100)
                    XCTAssertNotNil(item.releaseDate)
                    XCTAssertNotNil(item.artistName)
                    XCTAssertNotNil(item.genres)
                    if let grs = item.genres {
                        for g in grs {
                            XCTAssertNotNil(g.genreId)
                            XCTAssertNotNil(g.name)
                            XCTAssertNotNil(g.url)
                        }
                    }
                }
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: self.timeout)
    }
    
    func testApiOfGetTopFreeBooksWithPagination() {
        let expectation = XCTestExpectation(description: "JobEnd")
        api.getTopFreeBooksWithPaging(index: 0) { (success, index, response) in
            XCTAssertEqual(success, true)
            XCTAssertNotNil(response)
            XCTAssertNotNil(response?.feed)
            XCTAssertNotNil(response?.feed?.results)
            XCTAssertGreaterThan(response?.feed?.results?.count ?? 0, 0)
            if let results = response?.feed?.results, results.count > 0 {
                for item in results {
                    XCTAssertNotNil(item.id)
                    XCTAssertNotNil(item.name)
                    XCTAssertNotNil(item.artworkUrl100)
                }
            }
            XCTAssertEqual(index, 0)
            XCTAssertEqual(response?.feed?.results?.count ?? 0, 20)
            self.api.getTopFreeBooksWithPaging(index: 1) { (successTwo, indexTwo, responseTwo) in
                XCTAssertNotNil(responseTwo)
                XCTAssertEqual(indexTwo, 1)
                XCTAssertNotNil(responseTwo?.feed?.results)
                XCTAssertEqual(responseTwo?.feed?.results?.count ?? 0, 20)
                XCTAssertNotEqual(response, responseTwo)
                
                // Check is response result items same with same index data..
                self.api.getTopFreeBooksWithPaging(index: 1) { (successTwoAgain, indexTwoAgain, responseTwoAgain) in
                    XCTAssertNotNil(responseTwoAgain)
                    XCTAssertNotNil(responseTwo?.feed?.results)
                    XCTAssertEqual(indexTwo, 1)
                    XCTAssertEqual(responseTwoAgain?.feed?.results?.count ?? 0, 20)
                    XCTAssertEqual(responseTwoAgain?.feed?.results, responseTwoAgain?.feed?.results)
                    
                    expectation.fulfill()
                }
            }
        }
        wait(for: [expectation], timeout: self.timeout)
    }
    
    
    func testCompareBooksDataModelAndUIModel() {
        let expectation = XCTestExpectation(description: "JobEnd")
        api.getTopFreeBooks { (success, response) in
            XCTAssertEqual(success, true)
            if let results = response?.feed?.results, results.count > 0 {
                for item in results {
                    if let id = item.id, let name = item.name, let artwork = item.artworkUrl100, let releaseDate = Utils.stringToDate(string: item.releaseDate), let artistName = item.artistName {
                        let uiModel = BooksUIModel(id: id, title: name, imageUrl: artwork, releaseDate: releaseDate, artistName: artistName)
                        XCTAssertEqual(item.id, uiModel.id)
                        XCTAssertEqual(item.name, uiModel.title)
                        XCTAssertEqual(item.artworkUrl100, uiModel.imageUrl)
                    } else {
                        XCTAssertEqual(true, false)
                    }
                }
            } else {
                XCTAssertEqual(true, false)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: self.timeout)
    }
    
    func testCompareBooksSearchDataModelAndUIModel() {
        let expectation = XCTestExpectation(description: "JobEnd")
        api.getTopFreeBooks { (success, response) in
            XCTAssertEqual(success, true)
            if let results = response?.feed?.results, results.count > 0 {
                for item in results {
                    if let id = item.id, let name = item.name, let artwork = item.artworkUrl100, let releaseDate = Utils.stringToDate(string: item.releaseDate), let artistName = item.artistName, let genres = item.genres {
                        var uiGenres = [String]()
                        for g in genres {
                            XCTAssertNotNil(g)
                            XCTAssertNotNil(g.name)
                            if let gName = g.name {
                                uiGenres.append(gName)
                            }
                        }
                        
                        let uiModel = BooksSearchUIModel(id: id, title: name, imageUrl: artwork, releaseDate: releaseDate, artistName: artistName, genres: uiGenres)
                        XCTAssertEqual(item.id, uiModel.id)
                        XCTAssertEqual(item.name, uiModel.title)
                        XCTAssertEqual(item.artworkUrl100, uiModel.imageUrl)
                        
                        XCTAssertEqual(uiModel.genres.count, genres.count)
                        if uiModel.genres.count == genres.count {
                            var i = -1
                            for ug in uiModel.genres {
                                i += 1
                                XCTAssertEqual(ug, genres[i].name)
                            }
                        }
                        
                    } else {
                        XCTAssertEqual(true, false)
                    }
                }
            } else {
                XCTAssertEqual(true, false)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: self.timeout)
    }
    
    // MARK: - Other Functional Tests
    func testDateConverters() {
        let expectation = XCTestExpectation(description: "JobEnd")
        let dateSTR = "2020-11-09"
        let date = Utils.stringToDate(string: dateSTR)
        XCTAssertNotNil(date)
        if let secureDate = date {
            let year = Calendar.current.component(.year, from: secureDate)
            XCTAssertEqual(year, 2020)
            let month = Calendar.current.component(.month, from: secureDate)
            XCTAssertEqual(month, 11)
            let day = Calendar.current.component(.day, from: secureDate)
            XCTAssertEqual(day, 9)
            
            let trDateSTR = Utils.dateToStringTRFormat(date: secureDate)
            XCTAssertEqual("09-11-2020", trDateSTR)
        } else {
            XCTAssertEqual(true, false)
        }
       
        
        expectation.fulfill()
    }
    

}
