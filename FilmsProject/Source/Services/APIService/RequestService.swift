//
//  RequestService.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import Foundation

class RequestService {
    
    let session: URLSession
    let urlBuilder: URLBuilder
    
    init(session: URLSession, urlBuilder: URLBuilder) {
        self.session = session
        self.urlBuilder = urlBuilder
    }
    
    func getData(url: URL, completion: @escaping (Result<Data, Error>) -> ()) -> URLSessionDataTask {
        let task = self.session.dataTask(with: url) { data, response, error in
            debugPrint(response)
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            if let data = data {
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            }
        }
        
        task.resume()
        
        return task
    }
}
