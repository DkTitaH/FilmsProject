//
//  UINib+Extensions.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import UIKit

extension UINib {
    
    public convenience init(_ viewClass: AnyClass, bundle: Bundle? = nil) {
        self.init(nibName: toString(viewClass), bundle: bundle)
    }
}
