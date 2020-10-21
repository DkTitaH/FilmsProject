//
//  PopularFilmsModel.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import Foundation

struct PopularFilmsModel: Codable, ModelType {
    
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [FilmModel]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
