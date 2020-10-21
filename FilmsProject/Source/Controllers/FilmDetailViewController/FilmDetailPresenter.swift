//
//  FilmDetailPresenter.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import Foundation

enum FilmDetailPresenterInputEvent: EventType {
    
    case showIndicator
    case hideIndicator
}

enum FilmDetailPresenterOutputEvent: EventType {
    case showWebView(URL)
    case showConnectionError
}

class FilmDetailPresenter: BasePresenter<FilmModel, FilmDetailPresenterInputEvent, FilmDetailPresenterOutputEvent> {
    
    let dataSource: FilmDetailDataSource
    let storageService: CoreDataStorageService
    
    var isSavedToLocalStorage = false
    
    init(
        dataSource: FilmDetailDataSource,
        storageService: CoreDataStorageService,
        model: FilmModel?,
        apiService: APIService,
        networkService: NetworkServiceType,
        eventHandler: @escaping (FilmDetailPresenterOutputEvent) -> ()
    ) {
        self.dataSource = dataSource
        self.storageService = storageService
        
        super.init(model: model, apiService: apiService, networkService: networkService, eventHandler: eventHandler)
    }
    
    func showVideo(id: Int) {
        self.inputEventHandler?(.showIndicator)
        let _ = self.apiService.getVideo(
            id: id,
            completion: { [weak self] result in
                switch result {
                case let .success(model):
                    if let videoURL = URL(
                        string: "https://www.youtube.com/embed/\(model.results.first?.key ?? "")"
                    ) {
                        self?.inputEventHandler?(.hideIndicator)
                        self?.eventHandler(.showWebView(videoURL))
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        )
    }
    
    func getFromLocal() {
        if let _ = self.storageService
            .fetch(type: FilmModel.self)
            .first(where: { model in
                model.id == self.model?.id
            }
            )
        {
            self.isSavedToLocalStorage = true
        } else {
            self.isSavedToLocalStorage = false
        }
    }
    
    func saveModelToLocalStorage() {
        self.model.do {
            self.storageService.save(model: $0)
        }
    }
    
    func deleteModelFromLocalStorage() {
        self.model?.id.do {
            self.storageService.delete(type: FilmModel.self, by: $0)
        }
    }
}
