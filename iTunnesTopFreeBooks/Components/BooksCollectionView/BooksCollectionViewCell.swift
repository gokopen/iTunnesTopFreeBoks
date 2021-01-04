//
//  BooksCollectionViewCell.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import UIKit

class BooksCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var favoriteBackView: UIView!
    
    var currentUIModel: BooksUIModel?
    var isFavorited = false
    var currentImageUrl: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.favoriteBackView.layer.cornerRadius = self.favoriteBackView.frame.size.width / 2.0
        self.favoriteBackView.clipsToBounds = true
    }
    
    func setup(uiModel: BooksUIModel, favoriteTapAction: @escaping (BooksUIModel) -> Void) {
        self.currentImageUrl = uiModel.imageUrl
        self.isFavorited = FavoritesManager.getFavoirted(id: uiModel.id)
        self.currentUIModel = uiModel
        self.bookTitleLabel.text = uiModel.title
        self.favoriteImageView.image = isFavorited ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        self.bookImageView.image = nil
   
        CachedImageManager.shared.setImage(url:uiModel.imageUrl) { [weak self, uiModel] (image) in
            guard let self = self else { return }
            if uiModel.imageUrl == self.currentImageUrl {
                self.bookImageView.image = image
            }
        }
    }

    @IBAction func favoriteTapped(_ sender: Any) {
        if let mdl = self.currentUIModel {
            self.isFavorited = !(self.isFavorited)
            FavoritesManager.setFavorited(id: mdl.id, isFavorited: self.isFavorited)
        }
    }
}
