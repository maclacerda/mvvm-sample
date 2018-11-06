//
//  ArticlesDataSource.swift
//  MVVM-Sample
//
//  Created by Marcos Lacerda on 06/11/18.
//  Copyright © 2018 Marcos Lacerda. All rights reserved.
//

import UIKit

class ArticlesDataSource: NSObject, UITableViewDataSource {
    
    var articles: [Articles]?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let articles = self.articles else { return 0 }
        
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticlesCell") as? ArticlesTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.setup(with: articles![indexPath.row])
        
        return cell
    }
    
}
