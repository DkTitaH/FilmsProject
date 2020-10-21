//
//  FavoritesDataSource.swift
//  FilmsProject
//
//  Created by iphonovv on 20.10.2020.
//

import UIKit

class FavoritesDataSource: BaseDataSource<FilmModel, PopularFilmsTableViewCell> {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.reusableCell(PopularFilmsTableViewCell.self, for: indexPath, configure: { [weak self] cell in
            if let model = self?.models[indexPath.row] {
                cell.fill(model: model)
            }
        })
    }
}
