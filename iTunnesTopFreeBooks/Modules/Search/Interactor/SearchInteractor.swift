//
//  SearchInteractor.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import Foundation

class SearchInteractor: Interactor, SearchPresenterToInteractorProtocol {
    
    var presenter: SearchInteractorToPresenterProtocol! { get { return getPresenter(type: SearchPresenter.self)} }
    let api = Api()
    
    func fetchData() {
        self.api.getTopFreeBooks() { [weak self] (success, response) in
            guard let self = self else { return }
            if success, let response = response {
                self.presenter.setFetchedData(data: response)
            }
        }
    }
    
}
