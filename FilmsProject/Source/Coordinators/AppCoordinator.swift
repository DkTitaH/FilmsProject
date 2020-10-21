//
//  AppCoordinator.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import UIKit

enum AppCoordinatorType: EventType {
    
}

class AppCoordinator: BaseCoordanator<AppCoordinatorType> {
    
    private let requestService: APIService
    private var networkService: NetworkServiceType
    private let storageService: CoreDataStorageService
    
    private var popularFilmsPresenter: PopularFilmsPresenter?
    
    init(
        requestService: APIService,
        networkService: NetworkServiceType,
        storageService: CoreDataStorageService
    ) {
        self.requestService = requestService
        self.networkService = networkService
        self.storageService = storageService
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        self.networkService.isReachableDidChanged = { [weak self] bool in
            if !bool {
                self?.showNoConnectionAllert()
            } else {
                let presenter = self?.popularFilmsPresenter
                
                if (presenter?.isLoading ?? false) {
                    presenter?.inputEventHandler?(.loadData)
                }
            }
        }
    }
    
    override func start() {
        super.start()
        self.createRootViewController()
    }
    
    private func createRootViewController() {
        let dataSource = FilmsDataSource(eventHandler: { [weak self] event in
            switch event {
            case let .didSelect(filmModel):
                self?.createFilmDetailViewController(model: filmModel)
            }
        })
        let presenter = PopularFilmsPresenter(dataSource: dataSource, model: nil, apiService: self.requestService, networkService: self.networkService, eventHandler: { [weak self] event in
            switch event {
            case .showFavoritesViewController:
                self?.createFavoritesViewController()
            }
        })
        let viewController = PopularFilmsViewController(presenter: presenter)

        self.popularFilmsPresenter = presenter
        self.push(controller: viewController)
    }
    
    private func createFilmDetailViewController(model: FilmModel) {
        let dataSource = FilmDetailDataSource(models: [model],eventHandler: { event in
            switch event {
            case let .didSelect(filmModel):
                debugPrint(filmModel)
            }
        })
        
        let presenter = FilmDetailPresenter(dataSource: dataSource, storageService: self.storageService, model: model, apiService: self.requestService, networkService: self.networkService, eventHandler: { [weak self] event in
            switch event {
            case let .showWebView(url):
                self?.showWebView(url: url)
            case .showConnectionError:
                self?.showNoConnectionAllert()
            }
        })
        
        let viewController = FilmDetailViewController(presenter: presenter)
        
        self.pushOnTop(controller: viewController)
    }
    
    private func createFavoritesViewController() {
        let models = self.storageService.fetch(type: FilmModel.self)
        
        let dataSource = FavoritesDataSource(models: models, eventHandler: { [weak self] event in
            switch event {
            case let .didSelect(model):
                self?.createFilmDetailViewController(model: model)
            }
        })
        
        let model = FavoritesModel(models: models)
        let favoritesPresenter = FavoritesPresenter(dataSource: dataSource, storageService: self.storageService, model: model, apiService: self.requestService, networkService: self.networkService, eventHandler: { event in
            
        })
        
        let viewController = FavoritesViewController(presenter: favoritesPresenter)
        
        self.pushOnTop(controller: viewController)
    }
    
    private func showWebView(url: URL) {
        let viewController = WebViewController(url: url)
        self.pushOnTop(controller: viewController)
    }
    
    private func showNoConnectionAllert() {
        let viewController = UIAlertController(title: "Error", message: "No internet connection", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .cancel)
        
        viewController.addAction(cancel)
        
        self.presentOnTop(controller: viewController)
    }
}
