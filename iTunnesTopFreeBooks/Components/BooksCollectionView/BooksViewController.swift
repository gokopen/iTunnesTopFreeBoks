//
//  BooksViewController.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import UIKit

enum BooksViewSort {
    case noSort
    case toOld
    case toNew
    case onlyFavorites
}

protocol BooksViewDelegate {
    func itemTapped(tappedItemModel: BooksUIModel, index: Int)
    func pagingAwaiting(awaitingPageIndex: Int)
}

class BooksView: UIView {
    
    private var viewController: BooksViewController?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initXib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initXib()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.initXib()
    }
    
    func initXib() {
        self.viewController = Utils.getNibViewController(type: BooksViewController.self)
        if let v = self.viewController?.view {
            v.frame = self.bounds
            v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.addSubview(v)
        }
    }
    
    func setDelegate(_ delegate: BooksViewDelegate) {
        self.viewController?.delegate = delegate
    }
    
    func getItems() ->  [BooksUIModel] {
        return self.viewController?.items ?? []
    }

    // Without Paging
    func setItems(items: [BooksUIModel]) {
        self.viewController?.firstDataLoaded = true
        self.viewController?.items = items
        self.viewController?.isPagingDataEnded = true
    }
    
    // With Paging
    func addItems(items: [BooksUIModel], pageIndex: Int, isPagingDataEnded: Bool) {
        self.viewController?.firstDataLoaded = true
        self.viewController?.items.append(contentsOf: items)
        self.viewController?.currentPageIndex = pageIndex
        self.viewController?.isPagingDataEnded = isPagingDataEnded
        self.resetWaitingPageDataStatus()
    }
    
    func resetWaitingPageDataStatus() {
        self.viewController?.waitingNextDataToContinuePaging = false
    }
    
    func reloadData() {
        self.viewController?.reloadData()
    }
    
    func sortChange(_ sort: BooksViewSort) {
        self.viewController?.sortType = sort
        self.viewController?.reloadData()
    }
}

class BooksViewController: UIViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate: BooksViewDelegate?
    
    var firstDataLoaded = false
    var currentPageIndex = 0
    var isPagingDataEnded = false
    var waitingNextDataToContinuePaging = false
    var sortType: BooksViewSort = .noSort
    
    var items: [BooksUIModel] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    private var uiItems: [BooksUIModel] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.collectionView.reloadData()
                self.indicator.isHidden =  self.firstDataLoaded
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "BooksCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BooksCollectionViewCell")
        self.collectionView.register(UINib(nibName: "BooksPagingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BooksPagingCollectionViewCell")
    }
    
    func reloadData() {
        switch self.sortType {
        case .noSort:
            self.uiItems = self.items
            break
        case .toOld:
            self.uiItems = self.items.sorted{ $0.id > $1.id }
            break
        case .toNew:
            self.uiItems = self.items.sorted{ $0.id < $1.id }
            break
        case .onlyFavorites:
            self.uiItems = self.items.filter{ return FavoritesManager.getFavoirted(id: $0.id) }
            break
        }
    }
    
}

extension BooksViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? uiItems.count : (self.isPagingDataEnded == false && self.firstDataLoaded ? 1 : 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BooksPagingCollectionViewCell", for: indexPath)
            if let secureCell = cell as? BooksPagingCollectionViewCell {
                secureCell.indicator.stopAnimating()
                secureCell.indicator.startAnimating()
            }
            
            if self.waitingNextDataToContinuePaging == false, self.isPagingDataEnded == false, self.firstDataLoaded, self.uiItems.count > 10, let delegate = self.delegate {
                self.waitingNextDataToContinuePaging = true
                delegate.pagingAwaiting(awaitingPageIndex: self.currentPageIndex + 1)
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BooksCollectionViewCell", for: indexPath)
            if let castedCell = cell as? BooksCollectionViewCell {
                castedCell.setup(uiModel: uiItems[indexPath.row]) { [weak self] (model) in
                    self?.collectionView.reloadData()
                }
            }
        
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = self.delegate {
            let index = indexPath.row
            delegate.itemTapped(tappedItemModel: self.uiItems[index], index: index)
        }
    }
}

extension BooksViewController: UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: self.view.frame.size.width - 10.0 , height: 70.0)
        } else {
            let perWidth = self.view.frame.size.width / 2.0 - 5.0
            let perHeight = perWidth * 1.6
            return CGSize(width: perWidth, height: perHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    
}


