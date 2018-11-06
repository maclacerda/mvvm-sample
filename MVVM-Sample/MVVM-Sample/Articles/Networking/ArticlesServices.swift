//
//  ArticlesServices.swift
//  MVVM-Sample
//
//  Created by Marcos Lacerda on 06/11/18.
//  Copyright © 2018 Marcos Lacerda. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

class ArticlesServices: NSObject {

    public static let shared = ArticlesServices()
    
    fileprivate override init() {}
    
    func fecthArticles(_ handler: @escaping ((Result<[Articles]>) -> Void)) {
        let articlesURL = String(format: "http://newsapi.org/v2/top-headlines?apiKey=%@&country=%@", newsAPI, country)
        
        let decoder = JSONDecoder()
        
        guard let url = URL(string: articlesURL) else {
            handler(.error("URL error, check the API KEY and try again"))
            return
        }
        
        Alamofire.request(url).responseDecodableObject(keyPath: "articles", decoder: decoder) { (response: DataResponse<[Articles]>) in
            switch response.result {
            case .success(let articles):
                handler(.success(articles))
                break
                
            case .failure(let error):
                handler(.error(error.localizedDescription))
                break
            }
        }
    }
}
