//
//  ApiService.swift
//  Currency
//
//  Created by Dhanasekarapandian Srinivasan on 11/29/22.
//

import Foundation

class ApiService : NSObject, URLSessionDelegate {
    let session: URLSession
    let urlRequest: URLRequest
    init?(networkSession: URLSession = URLSession.shared, service: Service) {
        self.session = networkSession
        guard let request = service.creatUrlRequest() else {
            return nil
        }
        self.urlRequest = request
    }
    
    func getData<T: Codable>() async throws -> T? {
        let (data, response) = try await session.data(for: urlRequest)
        if (response as? HTTPURLResponse)?.statusCode == 200 {
            let result = try? JSONDecoder().decode(T.self, from: data)
            return result
        }
        return nil
    }
}
