//
//  AuthService.swift
//  practic
//
//  Created by Alik on 1/29/26.
//

import Foundation
import Alamofire

class AuthService {
    static let shared = AuthService()
    private let networkService = NetworkService.shared
    
    // Регистрация нового пользователя
    func register(email: String, password: String) async throws -> User {
        let endpoint = "/collections/users1/records"
        let parameters: [String: Any] = [
            "email": email,
            "password": password,
            "passwordConfirm": password
        ]
        
        let user: User = try await networkService.request(
            endpoint,
            method: .post,
            parameters: parameters
        )
        
        return user
    }
    
    // Авторизация
    func login(email: String, password: String) async throws -> AuthResponse {
        let endpoint = "/collections/users1/auth-with-password"
        let parameters: [String: Any] = [
            "identity": email,
            "password": password
        ]
        
        let response: AuthResponse = try await networkService.request(
            endpoint,
            method: .post,
            parameters: parameters
        )
        
        // Сохраняем токен
        networkService.saveToken(response.token)
        return response
    }
    
    // Получение текущего пользователя
    func getCurrentUser() async throws -> User {
        let endpoint = "/users/me"
        let user: User = try await networkService.request(
            endpoint,
            requiresAuth: true
        )
        return user
    }
    
    // Обновление пользователя
    func updateUser(userId: String, email: String? = nil, password: String? = nil) async throws -> User {
        let endpoint = "/collections/users1/records/\(userId)"
        
        var parameters: [String: Any] = [:]
        if let email = email {
            parameters["email"] = email
        }
        if let password = password {
            parameters["password"] = password
            parameters["passwordConfirm"] = password
        }
        
        let user: User = try await networkService.request(
            endpoint,
            method: .patch,
            parameters: parameters,
            requiresAuth: true
        )
        return user
    }
    
    // Удаление пользователя
    func deleteUser(userId: String) async throws {
        let endpoint = "/collections/users1/records/\(userId)"
        
        let _: String = try await networkService.request(
            endpoint,
            method: .delete,
            requiresAuth: true
        )
        
        // Очищаем токен после удаления
        networkService.clearToken()
    }
    
    // Выход
    func logout() {
        networkService.clearToken()
    }
    
    // Проверка авторизации
    var isAuthenticated: Bool {
        return networkService.isAuthenticated
    }
}
