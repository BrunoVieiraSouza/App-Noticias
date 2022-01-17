//
//  PesquisarViewController.swift
//  App-News
//
//  Created by Bruno Vieira Souza on 13/12/21.
//

import UIKit

class PesquisarViewController: UIViewController {
    
    var newSelecionada: Article?
    var pesquisa: String?
    let controller = PesquisaController()
    
    @IBOutlet weak var pesquisarCollectionView: UICollectionView!
    @IBOutlet weak var searchBarPesquisa: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pesquisarCollectionView.delegate = self
        pesquisarCollectionView.dataSource = self        
        searchBarPesquisa.delegate = self
        searchBarPesquisa.becomeFirstResponder()
        title = "Pesquisar"
    }
    
    func loadNews () {
        controller.loadNewsPesquisa(pesquisaString: pesquisa!) { sucesso in
            DispatchQueue.main.async {
                self.pesquisarCollectionView.reloadData()
            }
        }
    }
    
    func loadMoreNews(){
        controller.loadMoreNewsNoticias(pesquisaString: pesquisa!) { sucesso in
            DispatchQueue.main.async {
                self.pesquisarCollectionView.reloadData()
            }
        }
    }
}

extension PesquisarViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.isHidden = false
        searchBar.resignFirstResponder()
        pesquisa = searchBar.text?.replacingOccurrences(of: " ", with: "&")
        loadNews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pesquisaSegue" {
            let vc = segue.destination as! DetailViewController
            guard let new = newSelecionada else {return}
            vc.new = new
        }
    }
}

extension PesquisarViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == controller.numberSection() - 1 {
            self.loadMoreNews()
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
        performSegue(withIdentifier: "pesquisaSegue", sender: self)
    }
}

extension PesquisarViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controller.numberSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pesquisarCollectionView.dequeueReusableCell(withReuseIdentifier: "pesquisa", for: indexPath) as! ModelCollectionViewCell
        let new = controller.returnNews(index: indexPath.item)
        cell.new = new
        return cell
    }
}
