//
//  BaseViewController.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import UIKit

class BaseViewController<Presenter: PresenterType>: UIViewController {
    
    let presenter: Presenter
    
    init(presenter: Presenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
