//
//  FavoritesInteractor.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import Foundation

class FavoritesInteractor: Interactor, FavoritesPresenterToInteractorProtocol {
  
    var presenter: FavoritesInteractorToPresenterProtocol { get { return getPresenter(type: FavoritesPresenter.self)} }
    
    private let api = Api()
    
    func fetchData() {
        api.getTopFreeBooks() { [weak self] (success, response) in
            guard let self = self else { return }
            if success, let response = response {
                self.presenter.setFetchedData(data: response)
            }
        }
    }
    
}
