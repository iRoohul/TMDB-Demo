//
//  URLSession+Extension.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import Foundation

extension URLRequest {
    init?(service: Service) {
        guard let url = URLComponents(service: service)?.url else {return nil}
        print("URL: " + url.absoluteString)
        self.init(url: url)
        service.headers?.forEach { key, value in
            addValue(value, forHTTPHeaderField: key)
        }
    }
}


extension URLComponents {
    init?(service: Service) {
        guard let url = service.fullURL else {return nil}
        
        self.init(url: url, resolvingAgainstBaseURL: false)
        
        //Add query items to URL only if the request contains parameters otherwise return
        guard case let RequestType.parameters(parameters) = service.task else { return }
        queryItems = []
        for (key, value) in parameters {
            queryItems?.append(URLQueryItem(name: key, value: String(describing: value)))
        }
    }
}
