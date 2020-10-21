//
//  PopularFilmsViewController.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import UIKit

class PopularFilmsViewController: BaseViewController<PopularFilmsPresenter>, LoadIndicatorPresentable {
    
    @IBOutlet var tableView: UITableView?
    
    var indicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.navigationItem.title = "Popular"
        
        self.presenter.inputEventHandler = { [weak self] in
            switch $0 {
            case .loadData:
                let page = self?.presenter.dataSource.page ?? 1
                self?.tableView.do { table in
                    self?.presenter.dataSource.loadMore?(page, table)
                }
            case .showIndicator:
                self?.startAnimating()
            case .hideIndicator:
                self?.stopAnimating()
            }
        }
        
        self.addIndicator()
        self.addFavoritesButton()
        self.configureTableView()
    }
    
    @objc private func favoritesAction() {
        self.presenter.eventHandler(.showFavoritesViewController)
    }
    
    private func addFavoritesButton() {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Favorites", for: .normal)
        button.addTarget(self, action: #selector(self.favoritesAction), for: .touchUpInside)
        
        let favorite = UIBarButtonItem(customView: button)

        self.navigationItem.rightBarButtonItem = favorite
    }
    
    private func configureTableView() {
        self.tableView?.register(PopularFilmsTableViewCell.self)
        let dataSource = self.presenter.dataSource
        
        self.tableView?.delegate = dataSource
        self.tableView?.dataSource = dataSource
        
        self.presenter.inputEventHandler?(.loadData)
    }
}
