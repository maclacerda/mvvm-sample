//
//  Commom.swift
//  MVVM-Sample
//
//  Created by Marcos Lacerda on 06/11/18.
//  Copyright © 2018 Marcos Lacerda. All rights reserved.
//

import Foundation

enum ViewState {
    case normal, loading, error
}

enum Result<Value> {
    case success(Value)
    case error(String)
}

let newsAPI = "{your-api-key}"
let country = "us"
