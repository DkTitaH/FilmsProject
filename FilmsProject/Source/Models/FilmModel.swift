//
//  FilmModel.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import Foundation
import CoreData


protocol CoreDataStorable {
    
    associatedtype CoreDataModelType: NSManagedObject
}

struct FilmModel: Codable, ModelType, CoreDataStorable {
    
    typealias CoreDataModelType = FilmModelCoreData
    
    var popularity: Double?
    var voteCount: Int?
    var video: Bool?
    var posterPath: String?
    var id: Int?
    var adult: Bool?
    var backdropPath: String?
    var originalLanguage: String?
    var originalTitle: String?
    var genreIDS: [Int]?
    var title: String?
    var voteAverage: Double?
    var overview: String?
    var releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id
        case adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
    
    init(
        popularity: Double?,
        voteCount: Int?,
        video: Bool?,
        posterPath: String?,
        id: Int?,
        adult: Bool?,
        backdropPath: String?,
        originalLanguage: String?,
        originalTitle: String?,
        genreIDS: [Int]?,
        title: String?,
        voteAverage: Double?,
        overview: String?,
        releaseDate: String?
    ) {
        self.popularity = popularity
        self.voteCount = voteCount
        self.video = video
        self.posterPath = posterPath
        self.id = id
        self.adult = adult
        self.backdropPath = backdropPath
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.genreIDS = genreIDS
        self.title = title
        self.voteAverage = voteAverage
        self.overview = overview
        self.releaseDate = releaseDate
    }
    
    init(from decoder: Decoder) throws {
      let container = try? decoder.container(keyedBy: CodingKeys.self)
        popularity = try container?.decode(Double.self, forKey: .popularity)
        voteCount = try container?.decode(Int.self, forKey: .voteCount)
        posterPath = try container?.decode(String.self, forKey: .posterPath)
        id = try container?.decode(Int.self, forKey: .id)
        
        if let videoNum = try? container?.decode(Int.self, forKey: .video) {
            video = Bool(truncating: NSNumber(value: videoNum))
        } else {
            video = try? container?.decode(Bool.self, forKey: .video)
        }
        
        if let adultNum = try? container?.decode(Int.self, forKey: .adult) {
            adult = Bool(truncating: NSNumber(value: adultNum))
        } else {
            adult = try? container?.decode(Bool.self, forKey: .adult)
        }
        
        backdropPath = try container?.decode(String.self, forKey: .backdropPath)
        originalLanguage = try container?.decode(String.self, forKey: .originalLanguage)
        originalTitle = try container?.decode(String.self, forKey: .originalTitle)
        genreIDS = try container?.decode([Int].self, forKey: .genreIDS) ?? []
        title = try container?.decode(String.self, forKey: .title)
        voteAverage = try container?.decode(Double.self, forKey: .voteAverage)
        overview = try container?.decode(String.self, forKey: .overview)
        releaseDate = try container?.decode(String.self, forKey: .releaseDate)
    }
}
