//
//  DashboardViewModel.swift
//  RestaurantApp
//
//  Created by KRISHNA on 24/07/25.
//

import Foundation
import Combine

class DashboardViewModel: ObservableObject {
    @Published var restaurantPeakHour: [RestaurantPeakHour] = []
    @Published var mostOrderedDishes: [MostOrderedDishes] = []
    @Published var ratingDashboard: RatingDashboard?
    //    @Published var orderDashboard: OrderDashboard?
    //    @Published var orderStats: OrderStatistics?
    
    func fetchAllData() {
        fetchPeakHours()
        fetchMostOrderedDishes()
        fetchRatingDashboard()
        //        fetchOrderDashboard()
        //        fetchOrderStats()
    }
    
    private func fetchPeakHours() {
        guard let token = UserDefaults.standard.string(forKey: "authToken"),
              let url = URL(string: "http://localhost:8080/peekhours") else {
            print("Token or URL is missing.")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode([RestaurantPeakHour].self, from: data)
                    DispatchQueue.main.async {
                        self.restaurantPeakHour = decoded
                        print(self.restaurantPeakHour)
                    }
                } catch {
                    print("Decoding error:", error)
                }
            } else if let error = error {
                print("Network error:", error.localizedDescription)
            }
        }.resume()
    }
    
    private func fetchMostOrderedDishes() {
        guard let token = UserDefaults.standard.string(forKey: "authToken"),
              let url = URL(string: "http://localhost:8080/mostorderdish") else {
            print("Token or URL is missing.")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode([MostOrderedDishes].self, from: data)
                    DispatchQueue.main.async {
                        self.mostOrderedDishes = decoded
                        print(self.mostOrderedDishes)
                    }
                } catch {
                    print("Decoding error:", error)
                }
            } else if let error = error {
                print("Network error:", error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchRatingDashboard() {
        guard let token = UserDefaults.standard.string(forKey: "authToken"),
              let url = URL(string: "http://localhost:8080/ratingdashboard") else {
            print("Token or URL is missing.")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(RatingDashboard.self, from: data)
                    DispatchQueue.main.async {
                        print("data \(data)")
                        self.ratingDashboard = decoded
                        print(self.ratingDashboard)
                        
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            } else if let error = error {
                print("Network error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
