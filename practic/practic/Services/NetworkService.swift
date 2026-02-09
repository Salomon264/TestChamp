//
//  NetworkService.swift
//  practic
//
//  Created by Alik on 1/29/26.
//

import Foundation
import Alamofire

class NetworkService {
    static let shared = NetworkService()
    
    private let baseURL: String = "http://127.0.0.1:8090/api"
    
    private var token: String? {
        didSet{
            if let token = token {
                UserDefaults.standard.set(token, forKey: "authToken")
            }
        }
    }
    
    public init() {
        token = UserDefaults.standard.string(forKey: "authToken")
    }
    
    func request<T: Decodable>(_ endpoint: String, method: HTTPMethod = .get, parameters: Parameters? = nil, requiresAuth: Bool = false) async throws -> T {
        var headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        if requiresAuth, let token = token {
            headers.add(name: "Authorization", value: "Bearer \(token)")
        }
        
        let url = "\(baseURL)\(endpoint)"
        
        return try await AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: JSONEncoding.default
            , headers: headers
        )
        .validate()
        .serializingDecodable(T.self)
        .value
    }
    
    func saveToken(_ token: String) {
        self.token = token
    }
    
    func clearToken() {
        token = nil
        UserDefaults.standard.removeObject(forKey: "authToken")
    }
    
    var isAuthenticated: Bool {
        return token != nil
    }
}
