//
//  ArticlesViewModel.swift
//  MVVM-Sample
//
//  Created by Marcos Lacerda on 06/11/18.
//  Copyright © 2018 Marcos Lacerda. All rights reserved.
//

import Foundation

struct ArticlesViewModel {
    
    var delegate: ArticlesDelegate!
    var datasource: ArticlesDataSource!
    
    init(with delegate: ArticlesDelegate, datasource: ArticlesDataSource) {
        self.delegate = delegate
        self.datasource = datasource
    }
    
    func fetchArticles() {
        ArticlesServices.shared.fecthArticles { result in
            switch result {
            case .success(let articles):
                self.success(articles)
                break
                
            case .error(let error):
                self.error(error)
                break
            }
        }
    }
    
    fileprivate func success(_ articles: [Articles]) {
        datasource.articles = articles
        
        guard let delegate = self.delegate else { return }
        delegate.loadSuccess()
    }
    
    fileprivate func error(_ error: String) {
        guard let delegate = self.delegate else { return }
        delegate.loadingError(error)
    }
    
}
