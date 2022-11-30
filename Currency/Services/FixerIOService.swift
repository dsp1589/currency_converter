//
//  FixerIOService.swift
//  Currency
//
//  Created by Dhanasekarapandian Srinivasan on 11/29/22.
//

import Foundation

enum ResourcePath: String {
    case currencyList = "/currency_data/list"
    case rateData = "/currency_data/live"
    case historical = "/currency_data/historical"
}

enum RequestType {
    case currencyList
    case currencyRate(source: String, currencies:[String]? = nil)
    case historical(date_YYYY_MM_DD: String, source: String, currencies: [String]?)
}


class FixerIOService : Service {
    
    let baseFixerURL = "api.apilayer.com"
    let apiKey = "OOo3pNFSfSHvUEECZ458DnJT8GFJI991" //Exceedd
    
    let path: String
    let method: String
    let header: [String: String]?
    let body: Data?
    let urlQuery: [String:String]?
    
    init(type: RequestType, header: [String : String]? = nil, body: Data? = nil) {
        switch type {
        case .currencyList:
            self.path = ResourcePath.currencyList.rawValue
            self.method = "GET"
            self.urlQuery = nil
            break
        case .currencyRate(let source, let currencies):
            self.path = ResourcePath.rateData.rawValue
            self.method = "GET"
            self.urlQuery = ["source": source, "currencies": currencies?.joined(separator: ",") ?? ""]
            break
        case .historical(let date, let source, let currencies):
            self.path = ResourcePath.historical.rawValue
            self.method = "GET"
            self.urlQuery = ["date": date, "source": source, "currencies": currencies?.joined(separator: ",") ?? ""]
            break
        }
        self.header = header
        self.body = body
    }
    
    func creatUrlRequest() -> URLRequest? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseFixerURL
        urlComponents.path = path
        
        if let queryItem = urlQuery {
            urlComponents.queryItems = queryItem.map({ (key, value) in
                return URLQueryItem(name: key, value: value)
            })
        }
        guard let url = urlComponents.url else {
            return nil
        }
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.httpMethod = method
        request.addValue(apiKey, forHTTPHeaderField: "apikey")
        return request
    }
}
