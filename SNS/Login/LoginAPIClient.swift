//
//  LoginAPIClient.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/26.
//

import Foundation
import ComposableArchitecture

struct LoginAPIClient {
    var login: (String, String) -> Effect<String, LoginApiError>
}

extension LoginAPIClient {
    
    static let live = LoginAPIClient { email, password in
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let user = User(email: email, password: password)
        let url = URL(string: "http://localhost:8080/user")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(user)
        return URLSession.shared.dataTaskPublisher(for: request).tryMap { element in
            guard let httpResponse = (element.response as? HTTPURLResponse) else { throw LoginApiError.badRequest(20) }
            if httpResponse.statusCode != 200 { throw LoginApiError.badRequest(httpResponse.statusCode) }
            return element.data
        }.decode(type: String.self, decoder: decoder).mapError({ error in
            LoginApiError.changeError(error)
        }).eraseToEffect()
    }.login
}

enum LoginApiError: Error {
    case badRequest(Int)
    case changeError(Error)
}
