//
//  Extensions.swift
//  MVVM-Sample
//
//  Created by Marcos Lacerda on 06/11/18.
//  Copyright © 2018 Marcos Lacerda. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var appdelegate: AppDelegate {
        get {
            let delegate = UIApplication.shared.delegate as! AppDelegate 
            return delegate
        }
    }
    
}
