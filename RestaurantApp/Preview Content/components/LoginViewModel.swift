//
//  LoginViewModel.swift
//  RestaurantApp
//
//  Created by KRISHNA on 24/07/25.
//
import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let token: String
}

class LoginViewModel: ObservableObject {
    @Published var token: String? = nil
    @Published var errorMessage: String = ""
    @Published var isLoading = false
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:8080/login") else {
            self.errorMessage = "Invalid URL"
            completion(false)
            return
        }
        
        let loginRequest = LoginRequest(email: email, password: password)
        guard let jsonData = try? JSONEncoder().encode(loginRequest) else {
            self.errorMessage = "Failed to encode request"
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        isLoading = true
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    completion(false)
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "No data received"
                    completion(false)
                    return
                }
                
                do {
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                    self.token = loginResponse.token
                    UserDefaults.standard.set(loginResponse.token, forKey: "authToken")
                    
                    completion(true)
                } catch {
                    self.errorMessage = "Invalid credentials or decoding error"
                    completion(false)
                }
                
            }
        }.resume()
    }
}
