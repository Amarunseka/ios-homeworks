//
//  NetworkService.swift
//  Navigation
//
//  Created by Миша on 10.02.2022.
//

import Foundation


//enum ObtainDataResult {
//
//    case success(objectInfo: Codable?)
//    case failure(error: Error)
//}

class NetworkService {
    
    // MARK: - Задача №1
    static func receivePostSerialization(completion: @escaping (String) -> Void){
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/")
        let session = URLSession.shared

        guard let url = url else {return}
        
            session.dataTask(with: url) { (data, response, error) in
                guard let data = data else {return}

                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        if let result = json[2]["title"] as? String {
                            completion(result)
                        }
                    }
                } catch {
                    completion("Failed to load: \(error.localizedDescription)")
                }

            }.resume()
    }
    
// MARK: - Задача №2

    class func receiveObject<Model: Codable>(
        url: URL?,
        model: Model.Type,
        completion: @escaping (Result<Any?, Error>) -> Void){
            
        let sessionConfiguration = URLSessionConfiguration.default
        lazy var session = URLSession(configuration: sessionConfiguration)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(decoder.dateFormater)


        guard let url = url else {return}
        
        session.dataTask(with: url) { (data, response, error) in
            
            let result: Result<Any?, Error>
            
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            if error == nil, let parsData = data {
                guard
                    let objectInfo = try?
                        decoder.decode(model.self, from: parsData)
                else {
                    result = .success(nil)
                    return}
                
                result = .success(objectInfo)
                
            } else {
                if let error = error {
                    result = .failure(error)
                } else {
                    result = .failure(NSError())
                }
            }
        }.resume()
    }
}
