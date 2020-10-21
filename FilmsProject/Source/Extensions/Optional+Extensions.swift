//
//  Optional+Extensions.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import Foundation

extension Optional {
    
    func `do`(_ execute: (Wrapped) -> ()) {
        self.map(execute)
    }
}
