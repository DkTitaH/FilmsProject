//
//  APIService.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import Foundation

class APIService: RequestService {
    
    @discardableResult
    func getPopularFilms(
        page: Int,
        completion:
            @escaping (Result<PopularFilmsModel, Error>) -> ()
    )
        -> URLSessionDataTask?
    {
        self.urlBuilder.popular(page: page).map { popularArtistsUrl in
            return self.getData(url: popularArtistsUrl) { result in
                switch result {
                case let .success(data):
                    let parser = Parser<PopularFilmsModel>()
                    completion(parser.object(from: data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getVideo(
        id: Int,
        completion:
            @escaping (Result<VideoModel, Error>) -> ()
    )
        -> URLSessionDataTask?
    {
        self.urlBuilder.video(id: id).map { videoURL in
            return self.getData(url: videoURL) { result in
                switch result {
                case let .success(data):
                    let parser = Parser<VideoModel>()
                    completion(parser.object(from: data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
}
