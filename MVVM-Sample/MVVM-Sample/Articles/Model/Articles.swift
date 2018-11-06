//
//  Articles.swift
//  MVVM-Sample
//
//  Created by Marcos Lacerda on 06/11/18.
//  Copyright © 2018 Marcos Lacerda. All rights reserved.
//


struct Articles: Codable {
    
    let author: String?
    let image: String?
    let title: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case author
        case image = "urlToImage"
        case title
        case description
    }
    
}
