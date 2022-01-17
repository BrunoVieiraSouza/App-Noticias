//
//  ControllerCategoria.swift
//  App-News
//
//  Created by Bruno Vieira Souza on 17/12/21.
//

import UIKit

class ControllerCategoria {
    
    var newsViewUm: [Article] = []
    var newsViewDois: [Article] = []
    var pageNewsUm = 1
    var pageNewsDois = 1
    
    
    func loadNewsPage1(success: @escaping (Bool) -> Void) {
        REST.loadCtegoriaNews(category: "sports", page: pageNewsUm) { sucesso in
            self.newsViewUm = sucesso.articles
            success(true)
        }
    }
    
    func loadNewsPage2(success: @escaping (Bool) -> Void) {
        REST.loadCtegoriaNews(category: "technology", page: pageNewsDois) { sucesso in
            self.newsViewDois = sucesso.articles
            success(true)
        }
    }
    
    func loadNewsUm (index: Int) -> Article {
        let new = newsViewUm[index]
        return new
    }
    
    func loadNewsDois (index: Int) -> Article {
        let new = newsViewDois[index]
        return new
    }
    
    
}
