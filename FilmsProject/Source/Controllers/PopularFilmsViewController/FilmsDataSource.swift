//
//  FilmsDataSource.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import UIKit

class FilmsDataSource: BaseDataSource<FilmModel, PopularFilmsTableViewCell> {
        
    var page = 1
    var loadMore: ((Int, UITableView) -> ())?
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == self.models.count - 1 { // last cell            
            self.loadMore?(self.page, tableView)
        }
        
        return tableView.reusableCell(PopularFilmsTableViewCell.self, for: indexPath, configure: { [weak self] cell in
            if let model = self?.models[indexPath.row] {
                cell.fill(model: model)
            }
        })
    }
}
