//
//  FavoritesViewController.swift
//  FilmsProject
//
//  Created by iphonovv on 20.10.2020.
//

import UIKit

class FavoritesViewController: BaseViewController<FavoritesPresenter> {
    
    @IBOutlet var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.inputEventHandler = { [weak self] in
            switch $0 {            
            case .reloadData:
                self?.tableView?.reloadData()
            }
        }
                
        self.navigationItem.title = "Favorites"

        self.configureTableView()
        self.addClearButton()
    }
    
    private func configureTableView() {
        self.tableView?.register(PopularFilmsTableViewCell.self)
        let dataSource = self.presenter.dataSource
        self.tableView?.delegate = dataSource
        self.tableView?.dataSource = dataSource
    }
    
    @objc private func clearAction() {
        if self.presenter.deleteAll() {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    private func addClearButton() {
        if !(self.presenter.model?.models.count ?? 0 > 0) {
            return
        }
        
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Clear", for: .normal)
        button.addTarget(self, action: #selector(self.clearAction), for: .touchUpInside)
        
        let favorite = UIBarButtonItem(customView: button)

        self.navigationItem.rightBarButtonItem = favorite
    }
}
