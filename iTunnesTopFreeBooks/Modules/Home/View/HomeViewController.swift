//
//  HomeViewController.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 2.01.2021.
//

import UIKit

class HomeViewController: ViewController, HomePresenterToViewControllerProtocol   {
    
    typealias presenterType = HomeViewControllerToPresenterProtocol
    
    @IBOutlet weak var booksView: BooksView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Localizations.Home.title
        HomeRouter.setupModuleWithExistingView(view: self, interactor: HomeInteractor(), presenter: HomePresenter(), router: HomeRouter())
        self.booksView.setDelegate(self)
        if let p = self.presenter as? presenterType {
            p.viewLoaded()
        }
        
        let sortBarButton = UIBarButtonItem(title: Localizations.Home.sort, style: .plain, target: self, action: #selector(sortTapped))
        self.navigationItem.rightBarButtonItem = sortBarButton
        
        let alert = UIAlertController(title: Localizations.Home.welcome, message: Localizations.Home.welcomeInfo, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localizations.Home.ok, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func sortTapped() {
        let actionSheet = UIAlertController(title:  Localizations.Home.sort, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction( UIAlertAction(title: Localizations.Home.sortAll, style: .default, handler: { [weak self] (action) in
            self?.booksView.sortChange(.noSort)
        }) )
        actionSheet.addAction( UIAlertAction(title: Localizations.Home.sortToOld, style: .default, handler: {  [weak self] (action) in
            self?.booksView.sortChange(.toOld)
        }) )
        actionSheet.addAction( UIAlertAction(title: Localizations.Home.sortToNew, style: .default, handler: {  [weak self] (action) in
            self?.booksView.sortChange(.toNew)
        }) )
        actionSheet.addAction( UIAlertAction(title: Localizations.Home.sortOnlyFavorites, style: .default, handler: {  [weak self] (action) in
            self?.booksView.sortChange(.onlyFavorites)
        }) )
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func addItems(uiItems: [BooksUIModel], pageIndex: Int) {
        self.booksView.addItems(items: uiItems, pageIndex: pageIndex, isPagingDataEnded: uiItems.count > 0 ? false : true)
    }
    
    func reloadData() {
        self.booksView.reloadData()
    }
    
    func failedToFetchData() {
        self.booksView.resetWaitingPageDataStatus()
    }
}

extension HomeViewController: BooksViewDelegate {
    func itemTapped(tappedItemModel: BooksUIModel, index: Int) {
        (self.presenter as? presenterType)?.itemTapped(tappedItemModel: tappedItemModel)
    }
    
    func pagingAwaiting(awaitingPageIndex: Int) {
        (self.presenter as? presenterType)?.fetchNext(awaitingPageIndex: awaitingPageIndex)
    }
}
