//
//  Request.swift
//  SNS
//
//  Created by Rio Nagasaki on 2023/01/18.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

public protocol EndpointProtocol {
    associatedtype Request: Codable
    associatedtype Response: Codable
    var url: String { get }
}



final class APIClient {
    
    func send<T: EndpointProtocol>(request: T, completion: @escaping (T.Response)->Void) {
        if let url = URL(string: request.url) {
            let urlRequest = URLRequest(url: url)
            URLSession.shared.dataTask(with: urlRequest){ (data, response, error) in
                guard let data = data else { return }
                do {
                    let response = try JSONDecoder().decode(T.Response.self, from: data)
                    completion(response)
                } catch let error {
                    fatalError(String(describing: error))
                }
            }
        } else {
            
        }
    }
}

//
//public struct GetLessonReview: EndpointProtocol {
//    public typealias URI = String
//
//    public typealias Request = Empty
//    public typealias Response = Reviews
//}
//
//public struct Empty: EndpointProtocol {
//    public var url: String = "aa"
//
//    public typealias Request = Reviews
//
//    public typealias Response = Reviews
//}
//public struct Reviews: Codable {}
