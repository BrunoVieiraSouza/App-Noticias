//
//  CategoriaNews.swift
//  App-News
//
//  Created by Bruno Vieira Souza on 17/12/21.
//

import UIKit

class CategoriaViewController: UIViewController {
    
    let controller = ControllerCategoria()
    var indexNewsUm = 1
    var indexNewsDois = 1
    
    @IBOutlet weak var viewUm: UIView!
    @IBOutlet weak var viewDois: UIView!
    @IBOutlet weak var poster1: UIImageView!
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var poster2: UIImageView!
    @IBOutlet weak var voltarNewsUmButton: UIButton!
    @IBOutlet weak var voltarNewsDoisButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNewsUm ()
        loadNewsDois()
        
        if indexNewsUm == 1 {
            voltarNewsUmButton.isHidden = true
        }
        
    }
    
    func loadNewsUm () {
        controller.loadNewsPage1 { sucesso in
            let new = self.controller.loadNewsUm(index: self.indexNewsUm)
            DispatchQueue.main.async {
                let newURL = new.urlToImage
                self.poster1.kf.indicatorType = .activity
                self.poster1.kf.setImage(with: URL(string: newURL ?? ""), placeholder: nil, options: [.transition(.fade(0.7))])
                self.title1.text = new.title
                self.viewUm.reloadInputViews()
            }
        }
    }
    
    func loadNewsDois () {
        controller.loadNewsPage2 { sucesso in
            let new = self.controller.loadNewsDois(index: 1)
            DispatchQueue.main.async {
                let newURL = new.urlToImage
                self.poster2.kf.indicatorType = .activity
                self.poster2.kf.setImage(with: URL(string: newURL ?? ""), placeholder: nil, options: [.transition(.fade(0.7))])
                self.title2.text = new.title
                self.viewDois.reloadInputViews()
            }
        }
    }
    
    @IBAction func nextNewsUmButton(_ sender: UIButton) {
        voltarNewsUmButton.isHidden = false
        indexNewsUm += 1
        loadNewsUm()
    }
    
    @IBAction func backNewsUmButton(_ sender: UIButton) {
        if indexNewsUm > 1 {
            indexNewsUm -= 1
            loadNewsUm()
        } else {
            voltarNewsUmButton.isHidden = true
        }
    }
}
