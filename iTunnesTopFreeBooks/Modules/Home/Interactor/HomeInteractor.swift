//
//  HomeInteractor.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 2.01.2021.
//

import UIKit


class HomeInteractor: Interactor, HomePresenterToInteractorProtocol {
  
    typealias presenterType = HomeInteractorToPresenterProtocol
    
    private let api = Api()
    
    func fetchData(awaitingPageIndex: Int) {
        api.getTopFreeBooksWithPaging(index: awaitingPageIndex) { [weak self] (success, responseIndex, response) in
            guard let self = self else { return }
            if success, let response = response {
                if let p = self.presenter as? presenterType {
                    p.addFetchedData(data: response, pageIndex: responseIndex)
                }
            }
        }
    }

}
