//
//  UIImageView+Extensions.swift
//  FilmsProject
//
//  Created by iphonovv on 21.10.2020.
//

import UIKit
import SnapKit

extension UIImageView {
    
    func setImage(path: String) {
        let value = "https://image.tmdb.org/t/p/original/\(path)"
        let url = URL(string: value)
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.startAnimating()
        
        self.addSubview(indicator)
        
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        self.sd_setImage(with: url, completed: { image, error,_,_ in
            indicator.removeFromSuperview()
        })
    }
}
