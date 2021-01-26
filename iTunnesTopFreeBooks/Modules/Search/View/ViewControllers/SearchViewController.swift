//
//  SearchViewController.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import UIKit

class SearchViewController: ViewController, SearchPresenterToViewControllerProtocol   {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameFilterButton: UIButton!
    @IBOutlet weak var genreFilterButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var presenter: SearchViewControllerToPresenterProtocol! { get { return getPresenter(type: SearchPresenter.self)} }
    
    var isGenreSearch = false {
        didSet {
            self.genreFilterButton.backgroundColor = self.isGenreSearch ? #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1) : UIColor.darkGray
            self.search()
        }
    }
    
    var isNameSearch = false {
        didSet {
            self.nameFilterButton.backgroundColor = self.isNameSearch ? #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1) : UIColor.darkGray
            self.search()
        }
    }
    
   
    
    private var orginalItems = [BooksSearchUIModel]() {
        didSet {
            self.searchItems = self.orginalItems
        }
    }
    
    private var searchItems = [BooksSearchUIModel]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Localizations.Search.title
        SearchRouter.createModule(viewController: self)
        
        self.searchBar.delegate = self
        self.isNameSearch = true

        self.tableView.register(UINib(nibName: "SearchItemTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchItemTableViewCell")
        self.presenter?.viewLoaded()
    }
    
    func setItems(uiItems: [BooksSearchUIModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.indicator.isHidden = true
            self?.orginalItems = uiItems
        }
    }
    
    func search() {
        if self.isGenreSearch == false && self.isNameSearch == false {
            let alertController = UIAlertController(title: Localizations.Search.warning, message: Localizations.Search.unableToContinueWithoutSelectFilter, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: Localizations.Search.ok, style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            self.searchItems = self.orginalItems
        } else {
            if let searchText = self.searchBar.text?.lowercased(), searchText.count > 0 {
                self.searchItems = self.orginalItems.filter{ (self.isNameSearch && $0.title.lowercased().contains(searchText)) || (self.isGenreSearch && $0.genres.contains(where: { (str) -> Bool in
                    return str.lowercased().contains(searchText)
                }) ) }
             } else {
                self.searchItems = self.orginalItems
             }
        }
    }
    
    @IBAction func nameFilterTapped(_ sender: Any) {
        self.isNameSearch = !(self.isNameSearch)
    }
    
    @IBAction func genreFilterTapped(_ sender: Any) {
        self.isGenreSearch = !(self.isGenreSearch)
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchItemTableViewCell", for: indexPath)
        if let secureCell = cell as? SearchItemTableViewCell {
            let item = self.searchItems[indexPath.row]
            secureCell.cellTitleLabel.text = item.title
            secureCell.cellAuthorLabel.text = item.artistName
            secureCell.cellDateLabel.text = Utils.dateToStringTRFormat(date: item.releaseDate)
            secureCell.selectionStyle = .none
            CachedImageManager.shared.setImage(url: item.imageUrl) { [weak self, weak secureCell] (image) in
                if self != nil {
                    secureCell?.cellImageView.image = image
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.itemTapped(tappedItemModel: self.searchItems[indexPath.row], fromVC: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.search()
    }
}
