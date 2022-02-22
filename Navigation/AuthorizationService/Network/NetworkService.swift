//
//  NetworkService.swift
//  Navigation
//
//  Created by Миша on 10.02.2022.
//

import Foundation

// MARK: - Вариант 1 (простой)
//struct NetworkService {
//
//
//    static func receivePost(url: URL?){
//        let session = URLSession.shared
//
//        guard let url = url else {return}
//
//        session.dataTask(with: url) { (data, response, error) in
//            if let response = response as? HTTPURLResponse {
//                print("Headers: \n\(response.allHeaderFields), \n Codes: \n\(response.statusCode)\n")
//            }
//
//            guard let data = data else {return}
//
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                print(json)
//            } catch {
//                print(error.localizedDescription)
//                // error code: -1009
//            }
//
//        }.resume()
//    }
//}


// MARK: - Вариант 2 (поинтересней)

enum ObtainShipResult {
    
    case success(shipInfo: ShipInfo?)
    case failure(error: Error)
}

class NetworkService {
    
    
    class func receiveShipInfo(url: URL?, completion: @escaping (ObtainShipResult) -> Void){
        let sessionConfiguration = URLSessionConfiguration.default
        /// знаю в данном случае можно просто URLSession.shared, просто мне так больше нравиться
        lazy var session = URLSession(configuration: sessionConfiguration)
        let decoder = JSONDecoder()

        guard let url = url else {return}
        session.dataTask(with: url) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse {
                print("Headers: \n\(response.allHeaderFields), \n Codes: \n\(response.statusCode)\n\n")
            }

            let result: ObtainShipResult
            
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
                    result = .success(shipInfo: nil)
                    return}
                
                result = .success(shipInfo: shipInfo)
                
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
