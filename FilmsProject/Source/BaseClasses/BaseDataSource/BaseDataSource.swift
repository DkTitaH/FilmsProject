//
//  BaseDataSource.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import UIKit

class BaseDataSource<Model: ModelType, Cell: BaseCell<Model>>: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    enum DataSourceEvent {
        case didSelect(Model)
    }
    
    var models: [Model] = []
    
    var eventHandler: ((DataSourceEvent) -> ())
    
    init(models: [Model]? = nil, eventHandler: @escaping ((DataSourceEvent) -> ())) {
        self.models = models ?? []
        self.eventHandler = eventHandler
        
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.reusableCell(Cell.self, for: indexPath, configure: { [weak self] cell in            
            if let model = self?.models[indexPath.row] {
                cell.fill(model: model)
            }
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.models[indexPath.row]
        self.eventHandler(.didSelect(model))
    }
}
