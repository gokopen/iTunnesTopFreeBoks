//
//  HomeModuleTests.swift
//  iTunnesTopFreeBooksTests
//
//  Created by Gokhan Alp on 16.01.2021.
//

import XCTest
@testable import iTunnesTopFreeBooks

class HomeModuleTest: XCTestCase {
    
    let viewController = HomeMockViewController()
    let interactor = HomeMockInteractor()
    let presenter = HomePresenter()
    let router = HomeRouter()
    
    let timeout: TimeInterval = 60.0

    override func setUpWithError() throws {
        RouterInitializer.createModule(view: viewController, interactor: interactor, presenter: presenter, router: router)
    }

    override func tearDownWithError() throws {
    }

    func testModuleItems() {
        let expectation = XCTestExpectation(description: "JobLastEnd")
        XCTAssertNotNil(self.presenter.interactor)
        XCTAssertNotNil(self.presenter.viewController)
        XCTAssertNotNil(self.presenter.router)
        XCTAssertNotNil(self.viewController.presenter)
        XCTAssertNotNil(self.interactor.presenter)
        expectation.fulfill()
        wait(for: [expectation], timeout: self.timeout)
    }
    
    func testViewControllerToPresenter() {
        let expectation = XCTestExpectation(description: "JobLastEnd")
        expectation.fulfill()
        wait(for: [expectation], timeout: self.timeout)
    }
    
    func testViewController() {
        let expectation = XCTestExpectation(description: "JobLastEnd")
        let expectationAddItems = XCTestExpectation(description: "AddItemsExpectation")
        let expectationFailedToFetchData = XCTestExpectation(description: "FailedToFetchDataExpectation")
        let expectationReloadData = XCTestExpectation(description: "ReloadDataExpectation")
        
        self.viewController.expectationAddItems = expectationAddItems
        self.viewController.expectationFailedToFetchData = expectationFailedToFetchData
        self.viewController.expectationReloadData = expectationReloadData
        
        XCTAssertNoThrow(self.presenter.router)
        XCTAssertNoThrow(self.presenter.viewController)
        XCTAssertNoThrow(self.viewController.presenter)
        XCTAssertNotNil(self.presenter.router)
        XCTAssertNotNil(self.presenter.viewController)
        XCTAssertNotNil(self.viewController.presenter)
        
        let mockItems = [ BooksUIModel(id: "1", title: "Title One", imageUrl: "https://imageurlone.com", releaseDate: Date(), artistName: "Artist Name One"),
                          BooksUIModel(id: "2", title: "Title Two", imageUrl: "https://imageurlone.com", releaseDate: Date(), artistName: "Artist Name Two") ]
        let mockIndex = 3
        self.viewController.mockExpectedResult = mockItems
        self.viewController.mockExpectedPageIndex = mockIndex
        self.presenter.viewController.addItems(uiItems: mockItems, pageIndex: mockIndex)
        
        // Failed to fetch data expecatation will be runned.
        self.presenter.failedToFetchData()
        
        // When screen viewDidAppear VC calls Presenter's viewLoaded. After that data is fetching. Below viewLoaded method will work for everything. AddItem and ReloadDataExpectation will be runned.
        self.viewController.mockExpectedResult = nil
        self.viewController.mockExpectedPageIndex = nil
        let expectationAddItemsThisTimeForApi = XCTestExpectation(description: "AddItemsExpectationThisTimeFromApi")
        let expectationReloadDataThisTimeForApi = XCTestExpectation(description: "ReloadhDataExpectationThisTimeFromApi")
        self.viewController.expectationAddItems = expectationAddItemsThisTimeForApi
        self.viewController.expectationReloadData = expectationReloadDataThisTimeForApi
        self.presenter.viewLoaded()
    
        expectation.fulfill()
        wait(for: [expectation, expectationAddItems, expectationFailedToFetchData, expectationReloadData, expectationAddItemsThisTimeForApi, expectationReloadDataThisTimeForApi], timeout: self.timeout)
    }
    
    func testInteractor() {
        let expectation = XCTestExpectation(description: "JobLastEnd")
        
        let expectationFetchData = XCTestExpectation(description: "FetchData")
        let expectationFetchMockData = XCTestExpectation(description: "FetchMockData")
        
        let expectationAddItems = XCTestExpectation(description: "AddItemsExpectation")
        let expectationReloadData = XCTestExpectation(description: "ReloadDataExpectation")
        self.viewController.expectationAddItems = expectationAddItems
        self.viewController.expectationReloadData = expectationReloadData
        
        self.interactor.expectationFetchData = expectationFetchData
        self.interactor.expectationFetchMockData = expectationFetchMockData
        
        let mockModel = BooksDataModel()
        mockModel.feed = BooksFeedDataModel()
        let res = BooksFeedResultsDataModel()
        res.id = "1"
        res.releaseDate = "2020-01-01"
        res.artistName = "Artist"
        res.name = "Name"
        res.artworkUrl100 = "http://image.url"
        let genre = BooksFeedResultsGenresDataModel()
        genre.genreId = "g1"
        genre.name = "genreName"
        genre.url = "http://genre.url"
        res.genres = [ genre ]
        mockModel.feed?.results = [ res ]
        
        let mockItems = [ BooksUIModel(id: res.id!, title: res.name!, imageUrl: res.artworkUrl100!, releaseDate: Utils.stringToDate(string: res.releaseDate!)!, artistName:  res.artistName!)]
        let mockIndex = 2
        self.viewController.mockExpectedResult = mockItems
        self.viewController.mockExpectedPageIndex = mockIndex
        
        self.interactor.fetchMockData(awaitingPageIndex: 2, mockData: mockModel)
        
        self.viewController.mockExpectedResult = nil
        self.viewController.mockExpectedPageIndex = nil
        let expectationAddItemsThisTimeForApi = XCTestExpectation(description: "AddItemsExpectationThisTimeFromApi")
        let expectationReloadDataThisTimeForApi = XCTestExpectation(description: "ReloadhDataExpectationThisTimeFromApi")
        self.viewController.expectationAddItems = expectationAddItemsThisTimeForApi
        self.viewController.expectationReloadData = expectationReloadDataThisTimeForApi
        self.presenter.viewLoaded()
        
        expectation.fulfill()
        wait(for: [expectation, expectationFetchData, expectationFetchMockData, expectationAddItems, expectationReloadData, expectationAddItemsThisTimeForApi, expectationReloadDataThisTimeForApi], timeout: self.timeout)
    }
  

}
