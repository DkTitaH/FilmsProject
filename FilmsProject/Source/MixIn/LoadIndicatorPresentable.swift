//
//  LoadIndicatorPresentable.swift
//  FilmsProject
//
//  Created by iphonovv on 21.10.2020.
//

import UIKit

protocol LoadIndicatorPresentable: class {
    var indicator: UIActivityIndicatorView? { get set }
}

extension LoadIndicatorPresentable where Self: UIViewController {
    
    func addIndicator() {
        let indicator = UIActivityIndicatorView(style: .white)
        indicator.startAnimating()
        
        let containerView = UIView()
        containerView.isHidden = true
        containerView.backgroundColor = .init(hue: 0, saturation: 0, brightness: 0, alpha: 0.7)
        containerView.addSubview(indicator)
        
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        self.view.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.indicator = indicator
    }
    
    func startAnimating() {
        self.indicator?.superview?.isHidden = false
        self.indicator?.startAnimating()
    }
    
    func stopAnimating() {
        self.indicator?.stopAnimating()
        self.indicator?.superview?.isHidden = true
    }
}
