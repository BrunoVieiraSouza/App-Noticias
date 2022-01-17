//
//  ViewController.swift
//  App-News
//
//  Created by Bruno Vieira Souza on 13/12/21.
//
import UIKit

class NewsViewController: UIViewController {
    
    var newSelecionada: Article?
    let controller = NewsController()
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        title = "Ultimas Noticias"
        navigationItem.title = "Ultimas Noticias"
        fetch()
    }
    
//MARK: - METODOS RELOAD NEWS
    func fetch() {
        controller.loadNews { success in
            DispatchQueue.main.async {
                self.newsCollectionView.reloadData()
            }
        }
    }
    
    func loadPagesNews() {
        controller.loadMoreNews { success in
            DispatchQueue.main.async {
                self.newsCollectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newsSegue" {
            let vc = segue.destination as! DetailViewController
            guard let new = newSelecionada else {return}
            vc.new = new
        }
    }
}

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == controller.numberSection() - 1 {
            self.loadPagesNews()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let tela = view.frame.size.width
        let width = tela
        let telaAltura = view.frame.size.height
        return CGSize(width: width, height: telaAltura * 0.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let new = controller.returnNews(index: indexPath.item)
        newSelecionada = new
        performSegue(withIdentifier: "newsSegue", sender: self)
    }
}

extension NewsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controller.numberSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "news", for: indexPath) as! ModelCollectionViewCell
        let new = controller.returnNews(index: indexPath.item)
        cell.new = new
        return cell
    }
}
