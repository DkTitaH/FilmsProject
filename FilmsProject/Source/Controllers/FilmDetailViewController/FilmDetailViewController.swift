//
//  FilmDetailViewController.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import UIKit
import AVFoundation
import AVKit

class FilmDetailViewController: BaseViewController<FilmDetailPresenter>, LoadIndicatorPresentable {
    
    @IBOutlet var tableView: UITableView?
    
    var indicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.getFromLocal()
        self.navigationItem.title = self.presenter.model?.title
        
        self.addIndicator()
        self.configureTableView()
        self.addSaveButton()
        
        self.presenter.inputEventHandler = { [weak self] in
            switch $0 {
            case .showIndicator:
                self?.startAnimating()
            case .hideIndicator:
                self?.stopAnimating()
            }
        }
    }
    
    @objc private func saveAction() {
        self.navigationItem.rightBarButtonItem = nil
        self.presenter.saveModelToLocalStorage()
    }
    
    @IBAction func showVideo(_ sender: Any) {
        if !self.presenter.networkService.isReachable {
            self.presenter.eventHandler(.showConnectionError)
            
            return
        }
                
        if let id = self.presenter.model?.id {
            self.presenter.showVideo(id: id)
        }
    }
    
    private func addSaveButton() {
        if self.presenter.isSavedToLocalStorage {
           return
        }
        
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(self.saveAction), for: .touchUpInside)
        
        let favorite = UIBarButtonItem(customView: button)

        self.navigationItem.rightBarButtonItem = favorite
    }
    
    private func configureTableView() {
        self.tableView?.register(PopularFilmDetailTableCell.self)
        let dataSource = self.presenter.dataSource
        self.tableView?.delegate = dataSource
        self.tableView?.dataSource = dataSource
    }
}
