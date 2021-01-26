//
//  HomeMockInteractor.swift
//  iTunnesTopFreeBooksTests
//
//  Created by Gokhan Alp on 26.01.2021.
//

import XCTest
import Foundation
@testable import iTunnesTopFreeBooks

class HomeMockInteractor: HomeInteractor {
    
    var expectationFetchData: XCTestExpectation?
    var expectationFetchMockData: XCTestExpectation?
    
    override func fetchData(awaitingPageIndex: Int) {
        XCTAssertGreaterThanOrEqual(awaitingPageIndex, 0)
        super.fetchData(awaitingPageIndex: awaitingPageIndex)
        expectationFetchData?.fulfill()
    }
    
    func fetchMockData(awaitingPageIndex: Int, mockData: BooksDataModel) {
        XCTAssertGreaterThanOrEqual(awaitingPageIndex, 0)
        XCTAssertNotNil(mockData)
        XCTAssertNotNil(mockData.feed)
        XCTAssertNotNil(mockData.feed?.results)
        XCTAssertGreaterThan(mockData.feed?.results?.count ?? 0, 0)
        self.presenter.addFetchedData(data: mockData, pageIndex: awaitingPageIndex)
        expectationFetchMockData?.fulfill()
    }
    
}
