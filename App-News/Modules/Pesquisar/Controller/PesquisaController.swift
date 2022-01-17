//
//  PesquisaController.swift
//  App-News
//
//  Created by Bruno Vieira Souza on 15/12/21.
//

import Foundation

class PesquisaController {
    
    var page = 1
    var newsPesquisa: [Article] = []
    
    func loadNewsPesquisa (pesquisaString: String, complete: @escaping (Bool) -> Void) {
        REST.pesquisaNews(pesquisa: pesquisaString, page: page) { sucesso in
            self.newsPesquisa = sucesso.articles
            complete(true)
        }
    }
    
    func loadMoreNewsNoticias (pesquisaString: String, complete: @escaping (Bool) -> Void) {
        if page <= 5 {
            page += 1
            REST.pesquisaNews(pesquisa: pesquisaString, page: self.page) { newsMore in
                self.newsPesquisa += newsMore.articles
                complete(true)
            }
        }
    }
    
    func numberSection() -> Int {
        return newsPesquisa.count
    }
    
    func returnNews(index: Int) -> Article {
        let new = newsPesquisa[index]
        return new
    }
    
}
