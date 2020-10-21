//
//  BasePresenter.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import Foundation

class BasePresenter<Model: ModelType, Input: EventType, Output: EventType>: PresenterType {
        
    var apiService: APIService
    var networkService: NetworkServiceType
    var model: Model?
    
    var inputEventHandler: ((Input) -> ())?
    var eventHandler: ((Output) -> ())
    
    init(model: Model?, apiService: APIService, networkService: NetworkServiceType, eventHandler: @escaping ((Output) -> ())) {
        self.model = model
        self.apiService = apiService
        self.networkService = networkService
        self.eventHandler = eventHandler
    }
}
