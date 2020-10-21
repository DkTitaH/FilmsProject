//
//  BaseCoordinator.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import UIKit

class BaseCoordanator<CoordinatorEnent: EventType>: UINavigationController, CoordinatorPresentebleType {

    var eventHandler: ((CoordinatorEnent) -> ())?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.start()
    }
    
    func start() {
        
    }
}
