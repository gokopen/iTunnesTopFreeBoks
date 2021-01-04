//
//  FavoritesViewController.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import UIKit

class FavoritesViewController: ViewController, FavoritesPresenterToViewControllerProtocol   {
    
    typealias presenterType = FavoritesViewControllerToPresenterProtocol
    
    @IBOutlet weak var booksView: BooksView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Localizations.Favorites.title
        self.booksView.setDelegate(self)
        FavoritesRouter.setupModuleWithExistingView(view: self, interactor: FavoritesInteractor(), presenter: FavoritesPresenter(), router: FavoritesRouter())
        (self.presenter as? presenterType)?.viewLoaded()
    }
    
    func setItems(uiItems: [BooksUIModel]) {
        self.booksView.setItems(items: uiItems)
    }
 
}

extension FavoritesViewController: BooksViewDelegate {
    func itemTapped(tappedItemModel: BooksUIModel, index: Int) {
        (self.presenter as? presenterType)?.itemTapped(tappedItemModel: tappedItemModel)
    }
    
    func pagingAwaiting(awaitingPageIndex: Int) {
        
    }
    
    
}
