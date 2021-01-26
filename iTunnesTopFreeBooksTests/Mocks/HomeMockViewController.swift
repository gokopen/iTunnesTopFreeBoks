//
//  HomeMockViewController.swift
//  iTunnesTopFreeBooksTests
//
//  Created by Gokhan Alp on 24.01.2021.
//

import XCTest
import Foundation
@testable import iTunnesTopFreeBooks

class HomeMockViewController: ViewController, HomePresenterToViewControllerProtocol {
    
    var presenter: HomeViewControllerToPresenterProtocol! { get { return getPresenter(type: HomePresenter.self)} }
    
    var expectationAddItems: XCTestExpectation?
    var expectationReloadData: XCTestExpectation?
    var expectationFailedToFetchData: XCTestExpectation?
    
    var mockExpectedResult: [BooksUIModel]?
    var mockExpectedPageIndex: Int?
    
    func addItems(uiItems: [BooksUIModel], pageIndex: Int) {
        XCTAssertGreaterThan(uiItems.count, 0)
        if let expectedResult = self.mockExpectedResult {
            XCTAssertEqual(uiItems.count, expectedResult.count)
            XCTAssertEqual(uiItems, expectedResult)
        }
        if let expectedIndex = mockExpectedPageIndex {
            XCTAssertEqual(pageIndex, expectedIndex)
        }
        self.reloadData()
        self.expectationAddItems?.fulfill()
    }
    
    func reloadData() {
        self.expectationReloadData?.fulfill()
    }
    
    func failedToFetchData() {
        self.expectationFailedToFetchData?.fulfill()
    }
    
    
}
