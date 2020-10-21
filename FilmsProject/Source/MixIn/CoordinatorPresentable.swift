//
//  CoordinatorPresentable.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import UIKit

protocol CoordinatorPresentebleType {
    func push(controller: UIViewController)
}

extension CoordinatorPresentebleType where Self: UINavigationController {
    
    func push(controller: UIViewController) {
           self.pushViewController(controller, animated: true)
    }
    
    func pushOnTop(controller: UIViewController) {
        self.topViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func presentOnTop(controller: UIViewController, completion: (() -> ())? = nil) {
        self.topViewController?.present(controller, animated: true, completion: completion)
    }
}
