//
//  PresenterType.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import Foundation

protocol PresenterType {
    
    var apiService: APIService { get set }
    var networkService: NetworkServiceType { get set }
}
