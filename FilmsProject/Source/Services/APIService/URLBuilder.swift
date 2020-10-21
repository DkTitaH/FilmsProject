//
//  URLBuilder.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import Foundation

class URLBuilder {
    
    enum Endpoint: String {
        case movie = "/movie"
    }
    
    enum MoviePoint: String {
        case popular = "/popular?"
        case videos = "/videos?"
    }
    
    let apiKey = "api_key=c383d4fa4efd0be4e8b049d0fd62869b"
    let apiUrl = "https://api.themoviedb.org/3"
    
    private func url(string: String) -> URL? {
        return URL(string: string)
    }
    
    func popular(page: Int) -> URL? {
        let stringValue = self.apiUrl + Endpoint.movie.rawValue + MoviePoint.popular.rawValue + self.apiKey + "&language=en-US" + "&page=\(page.description)"
        
        return self.url(string: stringValue)
    }
    
    func video(id: Int) -> URL? {
        let stringValue = self.apiUrl + Endpoint.movie.rawValue + "/\(id.description)" + MoviePoint.videos.rawValue + self.apiKey
        
        return self.url(string: stringValue)
    }
}
