//
//  FavoritesViewController.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import UIKit

class FavoritesViewController: ViewController, FavoritesPresenterToViewControllerProtocol   {
    
    var presenter: FavoritesViewControllerToPresenterProtocol! { get { return getPresenter(type: FavoritesPresenter.self)} }
    
    @IBOutlet weak var booksView: BooksView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Localizations.Favorites.title
        self.booksView.setDelegate(self)
        FavoritesRouter.createModule(viewController: self)
        self.presenter.viewLoaded()
    }
    
    func setItems(uiItems: [BooksUIModel]) {
        self.booksView.setItems(items: uiItems)
    }
 
}

extension FavoritesViewController: BooksViewDelegate {
    func itemTapped(tappedItemModel: BooksUIModel, index: Int) {
        self.presenter.itemTapped(tappedItemModel: tappedItemModel, fromVC: self)
    }
    
    func pagingAwaiting(awaitingPageIndex: Int) {
        
    }
    
}
