//
//  APIclient.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import Foundation

class APIClient {

//    private var session = URLSession(configuration: .default)

    /**
     Call this method to perfom a web service of type `Service`
     - Parameter type: is generic type should be a model that conform to `Codable` protocol
     - Parameter completion: result of type `APIResponse`.
     */
    private func request<T>(service: Service, completion: @escaping (APIResponse<T>) -> ()) where T: Decodable {
        guard let request = URLRequest(service: service) else {
            completion(.failure(.badRequest))
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request, completionHandler: {[weak self] data, response, error in
            let httpResponse = response as? HTTPURLResponse
            self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
        })
        task.resume()
    }

    private func handleDataResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completion: (APIResponse<T>) -> ()) {
        guard error == nil else { return completion(.failure(.unknown)) }
        guard let response = response, let data = data else { return completion(.failure(.noJSONData)) }
        switch response.statusCode {
        case 200...299:
            do {
                if let responseJSON = String(data: data, encoding: .utf8 ) {
                    print("response : " + responseJSON)
                }
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            } catch {
                print(error)
                completion(.failure(.JSONDecoder))
            }
        case 401:
            completion(.failure(.unauthorized))
        default:
            completion(.failure(.unknown))
        }
    }

    
}

extension APIClient: MoviesAPIclient {
    
    //MARK:- Services
    
    func getMovies(service: Service, completion: @escaping (APIResponse<Movies>) -> ()) {
        request(service: service, completion: completion)
    }
    
}
