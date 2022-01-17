//
//  DetailViewController.swift
//  App-News
//
//  Created by Bruno Vieira Souza on 14/12/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var new: Article?
    
    @IBOutlet weak var conteudoLabel: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNew()
    }
    
    func loadNew() {
        guard let new = new else {
            return
        }
        let newURL = new.urlToImage
        poster.kf.indicatorType = .activity
        poster.kf.setImage(with: URL(string: newURL ?? ""), placeholder: nil, options: [.transition(.fade(0.7))])

        titleLabel.text = new.title
        conteudoLabel.text = new.content
    }
    
    @IBAction func voltarButton(_ sender: UIButton) {
        //dismiss(animated: true, completion: nil)
        print("apertou")
        navigationController?.popViewController(animated: true)
    }
    
    
}
