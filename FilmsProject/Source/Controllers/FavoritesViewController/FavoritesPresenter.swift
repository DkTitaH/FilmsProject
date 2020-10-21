//
//  FavoritesPresenter.swift
//  FilmsProject
//
//  Created by iphonovv on 20.10.2020.
//

import Foundation

enum FavoritesPresenterInputEvent: EventType {
    case reloadData
}

enum FavoritesPresenterOutputEvent: EventType {

}

class FavoritesPresenter: BasePresenter<FavoritesModel, FavoritesPresenterInputEvent, FavoritesPresenterOutputEvent> {
 
    let dataSource: FavoritesDataSource
    let storageService: CoreDataStorageService
    
    init(
        dataSource: FavoritesDataSource,
        storageService: CoreDataStorageService,
        model: FavoritesModel,
        apiService: APIService,
        networkService: NetworkServiceType,
        eventHandler: @escaping (FavoritesPresenterOutputEvent) -> ()
    ) {
        self.dataSource = dataSource
        self.storageService = storageService
        
        super.init(model: model, apiService: apiService, networkService: networkService, eventHandler: eventHandler)
        
        self.dataSource.models = self.model?.models ?? []
    }
    
    func deleteAll() -> Bool {
        if self.storageService.delete(model: FilmModel.self) {
            self.model?.models = []
            self.dataSource.models = []
            self.inputEventHandler?(.reloadData)
            
            return true
        }
        
        return false
    }
}
