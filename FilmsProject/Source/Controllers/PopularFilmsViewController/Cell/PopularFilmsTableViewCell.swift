//
//  PopularFilmsTableViewCell.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import UIKit


struct PopularFilmsTableViewCellModel {
    var title: String
    var imagePath: String
}

class PopularFilmsTableViewCell: BaseCell<FilmModel> {

    @IBOutlet var title: UILabel?
    @IBOutlet var filmImageView: UIImageView?
 
    override func fill(model: FilmModel) {
        self.title?.text = model.title
        
        self.filmImageView?.setImage(path: model.posterPath ?? "")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.filmImageView?.image = nil
    }
}
