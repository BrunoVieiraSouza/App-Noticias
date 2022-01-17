//
//  REST.swift
//  App-News
//
//  Created by Bruno Vieira Souza on 13/12/21.
//
//https://newsapi.org/v2/top-headlines?country=br&apiKey=df7be245ac7f4be6a846b57a02a64c52&page=2

import Foundation

let basePath = "https://newsapi.org/v2/"
let apiKey = "df7be245ac7f4be6a846b57a02a64c52"
let paisUrl = "top-headlines?country=br"

class REST {
    
    private static let configuracao: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 50.0
        config.httpMaximumConnectionsPerHost = 20
        return config
    }()
    private static let session = URLSession(configuration: configuracao)
    
    class func loadNews(page: Int, completion: @escaping (Welcome) -> Void) {
        let urlString = "\(basePath)\(paisUrl)&apiKey=\(apiKey)&page=\(page)"
        guard let url = URL(string: urlString) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    print("erro no response")
                    return
                }
                if response.statusCode == 200 {
                    guard let data = data else {
                        print("erro no data")
                        return
                    }
                    do {
                        let results = try JSONDecoder().decode(Welcome.self, from: data)
                        completion(results)
                    } catch {
                        print("Json invalido")
                    }
                } else {
                    print("algum status invalido pelo servidor")
                }
            } else {
                print("error no app")
                
            }
        }
        dataTask.resume()
    }
    
    class func pesquisaNews(pesquisa: String, page: Int, completion: @escaping (Welcome) -> Void) {
        let urlString = "https://newsapi.org/v2/everything?q=\(pesquisa)&apiKey=df7be245ac7f4be6a846b57a02a64c52&page=\(page)"
        guard let url = URL(string: urlString) else { return }
        let dataTask = session.dataTask(with: url) { data, response, error in
            if error == nil {
                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    guard let data = data else {return}
                    do {
                        let results = try JSONDecoder().decode(Welcome.self, from: data)
                        completion(results)
                    } catch {
                        print("erro json")
                    }
                } else {
                    print("no response")
                }
            } else {
                print("error no app")
            }
        }
        dataTask.resume()
    }
    
    class func loadCtegoriaNews (category: String, page: Int, completion: @escaping (Welcome) -> Void) {
        let urlStringCategorias = "https://newsapi.org/v2/top-headlines?country=br&category=\(category)&apiKey=df7be245ac7f4be6a846b57a02a64c52&page=\(page)"
        guard let url = URL(string: urlStringCategorias) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil {
                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    guard let data = data else {return}
                    do {
                        let results = try JSONDecoder().decode(Welcome.self, from: data)
                        completion(results)
                    } catch {
                        print("erro json")
                    }
                } else {
                    print("no response")
                }
            } else {
                print("error no app")
            }
        }
        dataTask.resume()
    }
}
    

