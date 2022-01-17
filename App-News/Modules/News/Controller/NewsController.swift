//
//  NewsController.swift
//  App-News
//
//  Created by Bruno Vieira Souza on 14/12/21.
//

import Foundation

class NewsController {
    
    var arrayNews: [Article] = []
    var page = 1
    let totalPage = 5
    
    func loadNews (complete: @escaping (Bool) -> Void) {
        REST.loadNews(page: 1) { news in
            self.arrayNews = news.articles
            complete(true)
        }
    }
    
    func loadMoreNews(complete: @escaping (Bool) -> Void) {
        if page <= totalPage {
            page += 1
            REST.loadNews(page: self.page) { newsMore in
                self.arrayNews += newsMore.articles
                complete(true)
            }
        }
    }
    
    func numberSection() -> Int {
        return arrayNews.count
    }
    
    func returnNews(index: Int) -> Article {
        let new = arrayNews[index]
        return new
    }
}
