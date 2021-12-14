//
//  ViewController.swift
//  App-News
//
//  Created by Bruno Vieira Souza on 13/12/21.
//

import UIKit

class NewsViewController: UIViewController {
    
    var array: [Article] = []
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        REST.loadNews(page: 1) { news in
            self.array = news.articles
            print(self.array[1].title)
        }
    }
}

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
}

extension NewsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "news", for: indexPath) as! ModelCollectionViewCell
        return cell
    }
}

