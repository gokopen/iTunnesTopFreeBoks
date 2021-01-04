//
//  DetailViewController.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import UIKit

class DetailViewController: ViewController, DetailPresenterToViewControllerProtocol   {
    
    typealias presenterType = DetailViewControllerToPresenterProtocol
    
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var contentDetailLabel: UILabel!
    
    var favoirteBar: UIBarButtonItem?
    var uiModel: BooksUIModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Localizations.Detail.title
        
        self.favoirteBar = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteTapped) )
        self.navigationItem.rightBarButtonItem = self.favoirteBar
        
        self.updateUIFromModel()
        
        
        NotificationCenter.default.addObserver(self,selector: #selector(self.favoriteUpdated), name: NSNotification.Name(rawValue: Constants.NotificationCenter.favoriteUpdated), object: nil)
    }
    
    func updateUIFromModel() {
        if let model = self.uiModel {
            self.contentTitleLabel.text = model.title
            self.contentDetailLabel.text = "\(Localizations.Detail.author): \(model.artistName)\n\(Localizations.Detail.releaseDate): \(Utils.dateToStringTRFormat(date: model.releaseDate))"
            self.favoirteBar?.image = FavoritesManager.getFavoirted(id: model.id) ? UIImage(systemName: "heart.fill"): UIImage(systemName: "heart")
            CachedImageManager.shared.setImage(url: model.imageUrl) { (image) in
                self.contentImageView.image = image
            }
        }
    }
    
    @objc func favoriteTapped() {
        if let model = self.uiModel {
            let currentStatus = FavoritesManager.getFavoirted(id: model.id)
            FavoritesManager.setFavorited(id: model.id, isFavorited: !currentStatus)
        }
    }
    
    @objc func favoriteUpdated(notification: NSNotification) {
        self.updateUIFromModel()
    }
    

}
