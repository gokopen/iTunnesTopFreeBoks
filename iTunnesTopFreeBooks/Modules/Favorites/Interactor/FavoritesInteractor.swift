//
//  FavoritesInteractor.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import Foundation

class FavoritesInteractor: Interactor, FavoritesPresenterToInteractorProtocol {
  
    typealias presenterType = FavoritesInteractorToPresenterProtocol
    
    private let api = Api()
    
    func fetchData() {
        api.getTopFreeBooks() { [weak self] (success, response) in
            guard let self = self else { return }
            if success, let response = response {
                if let p = self.presenter as? presenterType {
                    p.setFetchedData(data: response)
                }
            }
        }
    }
    
}
