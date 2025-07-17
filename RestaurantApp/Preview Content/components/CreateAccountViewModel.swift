//
//  CreateAccountViewModel.swift
//  RestaurantApp
//
//  Created by KRISHNA on 17/07/25.
//

import Foundation

class CreateAccountViewModel: ObservableObject {
    @Published var message: String = ""
    @Published var isLoading: Bool = false

    func createUser(firstName: String, lastName: String, email: String, password: String, role: String?) {
        guard let url = URL(string: "http://localhost:8080/users") else {
            self.message = "Invalid URL"
            return
        }

        let user = User(firstName: firstName, lastName: lastName, email: email, password: password, role: role)

        guard let jsonData = try? JSONEncoder().encode(user) else {
            self.message = "Encoding failed"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        isLoading = true
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response Code: \(httpResponse.statusCode)")
                
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Response Body: \(responseString)")
                }
            }
            
            DispatchQueue.main.async {
                self.isLoading = false

                if let error = error {
                    self.message = "Error: \(error.localizedDescription)"
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    self.message = "No valid response"
                    return
                }

                if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                    self.message = "User created successfully!"
                } else {
                    self.message = "Failed with status: \(httpResponse.statusCode)"
                }
            }
        }.resume()
    }
}
