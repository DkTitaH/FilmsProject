//
//  VideoModel.swift
//  FilmsProject
//
//  Created by iphonovv on 21.10.2020.
//

import Foundation

struct VideoModel: Codable, ModelType {
    
    let id: Int
    let results: [VideoModelResult]

    enum CodingKeys: String, CodingKey {
        case id
        case results
    }
}

struct VideoModelResult: Codable {
    let id: String?
    let iso_639_1: String?
    let iso_3166_1: String?
    let key: String?
    let name: String?
    let site: String?
    let siz: Int?
    let type: String?
}
