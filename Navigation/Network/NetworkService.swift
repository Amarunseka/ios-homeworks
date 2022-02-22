//
//  NetworkService.swift
//  Navigation
//
//  Created by Миша on 10.02.2022.
//

import Foundation

// MARK: - Задача №1
struct SerializationNetworkService {

    static func receivePost() -> String {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/")
        let session = URLSession.shared
        var answer = "Can't receive data"

        guard let url = url else {return "incorrect URL"}
        
            session.dataTask(with: url) { (data, response, error) in
                guard let data = data else {return}

                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        if let result = json[2]["title"] as? String {
                            answer = result
                        }
                    }
                } catch {
                    answer = "Failed to load: \(error.localizedDescription)"
                }

            }.resume()
        sleep(1)
        return answer
    }
}



// MARK: - Задача №2

enum ObtainDataResult {
    
    case success(objectInfo: Codable?)
    case failure(error: Error)
}

// MARK: - Planets
class PlanetNetworkService {
    
    class func receivePlanetInfo(url: URL?, completion: @escaping (ObtainDataResult) -> Void){
        let sessionConfiguration = URLSessionConfiguration.default
        lazy var session = URLSession(configuration: sessionConfiguration)
        let decoder = JSONDecoder()

        guard let url = url else {return}
        session.dataTask(with: url) { (data, response, error) in
            
            let result: ObtainDataResult
            
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }

            if error == nil, let parsData = data {
                guard
                    let planetInfo = try?
                        decoder.decode(Planet.self, from: parsData)
                else {
                    result = .success(objectInfo: nil)
                    return}
                
                result = .success(objectInfo: planetInfo)
                
            } else {
                if let error = error {
                    result = .failure(error: error)
                } else {
                    result = .failure(error: NSError())
                }
            }
        }.resume()
    }
}



// MARK: - Residens
class ResidentNetworkService {
    
    class func receiveResidentInfo(url: URL?, completion: @escaping (ObtainDataResult) -> Void){
        let sessionConfiguration = URLSessionConfiguration.default
        lazy var session = URLSession(configuration: sessionConfiguration)
        let decoder = JSONDecoder()

        guard let url = url else {return}
        session.dataTask(with: url) { (data, response, error) in
            
            let result: ObtainDataResult
            
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }

            if error == nil, let parsData = data {
                guard
                    let residentInfo = try?
                        decoder.decode(Resident.self, from: parsData)
                else {
                    result = .success(objectInfo: nil)
                    return}
                
                result = .success(objectInfo: residentInfo)
                
            } else {
                if let error = error {
                    result = .failure(error: error)
                } else {
                    result = .failure(error: NSError())
                }
            }
        }.resume()
    }
}



// MARK: - StarShips
class StarshipNetworkService {
    
    class func receiveShipInfo(url: URL?, completion: @escaping (ObtainDataResult) -> Void){
        let sessionConfiguration = URLSessionConfiguration.default
        lazy var session = URLSession(configuration: sessionConfiguration)
        let decoder = JSONDecoder()

        guard let url = url else {return}
        
        session.dataTask(with: url) { (data, response, error) in
            
            let result: ObtainDataResult
            
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }

            if error == nil, let parsData = data {
                guard
                    let shipInfo = try?
                        decoder.decode(ShipInfo.self, from: parsData)
                else {
                    result = .success(objectInfo: nil)
                    return}
                
                result = .success(objectInfo: shipInfo)
                
            } else {
                if let error = error {
                    result = .failure(error: error)
                } else {
                    result = .failure(error: NSError())
                }
            }
        }.resume()
    }
}



