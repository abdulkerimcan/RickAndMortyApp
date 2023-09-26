//
//  UIView+Ext.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 26.09.2023.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
            views.forEach({
                addSubview($0)
            })
        }
}
