//
//  AuthViewModel.swift
//  practic
//
//  Created by Alik on 1/30/26.
//

import Foundation
import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var successMessage: String?
    
    private let authService = AuthService.shared
    
    init() {
        checkAuthentication()
    }
    
    // Проверка существующей авторизации
    private func checkAuthentication() {
        isAuthenticated = authService.isAuthenticated
        
        if isAuthenticated {
            Task {
                await loadCurrentUser()
            }
        }
    }
    
    // Загрузка текущего пользователя
    @MainActor
    func loadCurrentUser() async {
        guard authService.isAuthenticated else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            currentUser = try await authService.getCurrentUser()
            isAuthenticated = true
        } catch {
            errorMessage = "Не удалось загрузить пользователя: \(error.localizedDescription)"
            logout()
        }
        
        isLoading = false
    }
    
    // Регистрация
    @MainActor
    func register(email: String, password: String) async -> Bool {
        isLoading = true
        errorMessage = nil
        successMessage = nil
        
        do {
            let user = try await authService.register(email: email, password: password)
            successMessage = "Регистрация успешна! Теперь войдите в систему."
            clearMessagesAfterDelay()
            isLoading = false
            return true
        } catch {
            errorMessage = "Ошибка регистрации: \(error.localizedDescription)"
            isLoading = false
            return false
        }
    }
    
    // Авторизация
    @MainActor
    func login(email: String, password: String) async -> Bool {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await authService.login(email: email, password: password)
            currentUser = response.record
            isAuthenticated = true
            successMessage = "Добро пожаловать, \(response.record.email)!"
            clearMessagesAfterDelay()
            isLoading = false
            return true
        } catch {
            errorMessage = "Ошибка входа: \(error.localizedDescription)"
            isLoading = false
            return false
        }
    }
    
    // Обновление профиля
    @MainActor
    func updateProfile(email: String? = nil, password: String? = nil) async -> Bool {
        guard let userId = currentUser?.id else { return false }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let updatedUser = try await authService.updateUser(
                userId: userId,
                email: email,
                password: password
            )
            currentUser = updatedUser
            successMessage = "Профиль обновлен!"
            clearMessagesAfterDelay()
            isLoading = false
            return true
        } catch {
            errorMessage = "Ошибка обновления: \(error.localizedDescription)"
            isLoading = false
            return false
        }
    }
    
    // Удаление аккаунта
    @MainActor
    func deleteAccount() async -> Bool {
        guard let userId = currentUser?.id else { return false }
        
        isLoading = true
        errorMessage = nil
        
        do {
            try await authService.deleteUser(userId: userId)
            logout()
            successMessage = "Аккаунт удален"
            clearMessagesAfterDelay()
            isLoading = false
            return true
        } catch {
            errorMessage = "Ошибка удаления: \(error.localizedDescription)"
            isLoading = false
            return false
        }
    }
    
    // Выход
    @MainActor
    func logout() {
        authService.logout()
        currentUser = nil
        isAuthenticated = false
        errorMessage = nil
        successMessage = "Вы вышли из системы"
        clearMessagesAfterDelay()
    }
    
    // Очистка сообщений через 3 секунды
    private func clearMessagesAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                self.errorMessage = nil
                self.successMessage = nil
            }
        }
    }
}
