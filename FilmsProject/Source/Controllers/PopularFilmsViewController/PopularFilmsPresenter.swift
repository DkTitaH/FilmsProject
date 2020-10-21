//
//  PopularFilmsPresenter.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import Foundation

enum PopularFilmsPresenterInputEvent: EventType {
    
    case loadData
    case showIndicator
    case hideIndicator
}

enum PopularFilmsPresenterOutputEvent: EventType {
    
    case showFavoritesViewController
}

class PopularFilmsPresenter: BasePresenter<PopularFilmsModel, PopularFilmsPresenterInputEvent, PopularFilmsPresenterOutputEvent> {

    override var model: PopularFilmsModel? {
        didSet {
            self.dataSource.models.append(contentsOf: self.model?.results ?? [])
        }
    }
    
    private var currentLoadingTask: URLSessionDataTask? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    private var loadingTimer: Timer?
    
    let dataSource: FilmsDataSource
    
    var isLoading = false
    
    init(
        dataSource: FilmsDataSource,
        model: PopularFilmsModel?,
        apiService: APIService,
        networkService: NetworkServiceType,
        eventHandler: @escaping (PopularFilmsPresenterOutputEvent) -> ()
    ) {
        self.dataSource = dataSource
        
        super.init(model: model, apiService: apiService, networkService: networkService, eventHandler: eventHandler)
        
        dataSource.loadMore = { [weak self] page, tableView in
            self?.inputEventHandler?(.showIndicator)
            self?.loadData(page: page, successCompletion: {
                self?.dataSource.page += 1
                tableView.reloadData()
                
                self?.inputEventHandler?(.hideIndicator)
            })
        }
    }
    
    func loadData(page: Int, successCompletion: @escaping () -> ()) {
        self.isLoading = true
        
        if !self.networkService.isReachable {
            return
        }
        
        self.currentLoadingTask?.cancel()
        self.loadingTimer?.invalidate()
        
        self.loadingTimer = Timer.scheduledTimer(
            withTimeInterval: 0.1,
            repeats: false,
            block: { [weak self] (timer) in
                self?.currentLoadingTask = self?.apiService.getPopularFilms(
                    page: page,
                    completion: { [weak self] result in
                        switch result {
                        case let .success(model):
                            self?.model = model
                            
                            successCompletion()
                        case let .failure(error):
                            self?.inputEventHandler?(.hideIndicator)
                            debugPrint(error)
                        }
                        
                        self?.currentLoadingTask = nil
                        self?.isLoading = false
                    }
                )
            }
        )
    }
}
