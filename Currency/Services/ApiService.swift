//
//  ApiService.swift
//  Currency
//
//  Created by Dhanasekarapandian Srinivasan on 11/29/22.
//

import Foundation


enum APIError: Error {
    case rateLimitExceeded(msg: String)
    case requestFailed
    case unauthAccess
    case unknowError(msg: String)
}

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
    
    func getData<T: Codable>() async throws -> Result<T?, APIError> {
        let (data, response) = try await session.data(for: urlRequest)
        if (response as? HTTPURLResponse)?.statusCode == 200 {
            let result = try? JSONDecoder().decode(T.self, from: data)
            return .success(result)
        }
        let code = (response as? HTTPURLResponse)?.statusCode ?? -1
        if code >= 200 && code <= 299 {
            let result = try? JSONDecoder().decode(T.self, from: data)
            return .success(result)
        } else if code == 429 {
            return .failure(.rateLimitExceeded(msg: "You have exceeded API limit, please subscribe!"))
        } else if code == 401 {
            return .failure(.unauthAccess)
        } else if code >= 400 && code <= 499 {
            return .failure(.requestFailed)
        } else if code == -1 {
            return .failure(.unknowError(msg: "Something unexpected happened, please try again!"))
        } else {
            
        }
        return .failure(.unknowError(msg: "Something unexpected happened, please try again!"))
    }
}
