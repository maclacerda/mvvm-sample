//
//  ArticlesTableViewCell.swift
//  MVVM-Sample
//
//  Created by Marcos Lacerda on 06/11/18.
//  Copyright © 2018 Marcos Lacerda. All rights reserved.
//

import UIKit
import Kingfisher

class ArticlesTableViewCell: UITableViewCell {
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    @IBOutlet weak var articleAuthorLabel: UILabel!
    @IBOutlet weak var photoHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareForReuse()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.articleImage.image = nil
        self.articleTitleLabel.text = ""
        self.articleDescriptionLabel.text = ""
        self.articleAuthorLabel.text = ""
        self.photoHeightConstraint.constant = 125
    }

    func setup(with article: Articles) {
        self.articleTitleLabel.text = article.title
        self.articleDescriptionLabel.text = article.description
        
        if let author = article.author {
            self.articleAuthorLabel.text = "Author: \(author)"
        }
        
        guard let image = article.image, let url = URL(string: image) else {
            self.photoHeightConstraint.constant = 0
            return
        }
        
        self.articleImage.kf.setImage(with: url)
    }
    
}
