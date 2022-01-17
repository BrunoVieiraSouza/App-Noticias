//
//  ModelCollectionView.swift
//  App-News
//
//  Created by Bruno Vieira Souza on 13/12/21.
//

import UIKit
import Kingfisher

class ModelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterNews: UIImageView!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var dateNewa: UILabel!
    
    var new: Article? {
        didSet {
            if let new = new {
                let newURL = new.urlToImage
                posterNews.kf.indicatorType = .activity
                posterNews.kf.setImage(with: URL(string: newURL ?? ""), placeholder: nil, options: [.transition(.fade(0.7))])
                self.titleNews.text = new.title
            }
        }
    }
}



