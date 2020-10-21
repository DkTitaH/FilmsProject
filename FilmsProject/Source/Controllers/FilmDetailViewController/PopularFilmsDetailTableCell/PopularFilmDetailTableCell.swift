//
//  PopularFilmsTableCell.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import UIKit
import SDWebImage

class PopularFilmDetailTableCell: BaseCell<FilmModel> {

    @IBOutlet var dateLabel: UILabel?
    @IBOutlet var descriptionLabel: UILabel?
    @IBOutlet var filmImageView: UIImageView?
    @IBOutlet var voteAverageLabel: UILabel?
    @IBOutlet var voteCountLabel: UILabel?
    @IBOutlet var titleLabel: UILabel?
    
    override func fill(model: FilmModel) {
        self.dateLabel?.text = model.releaseDate
        self.descriptionLabel?.text = model.overview
        self.voteCountLabel?.text = model.voteCount?.description
        self.voteAverageLabel?.text = model.voteAverage?.description
        self.titleLabel?.text = model.title

        self.filmImageView?.setImage(path: model.posterPath ?? "")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.filmImageView?.image = nil
    }
}
