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
        guard let url = URL(string: "http://localhost:8080/peekhours") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode([RestaurantPeakHour].self, from: data)
                    DispatchQueue.main.async {
                        self.restaurantPeakHour = decoded
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
        guard let url = URL(string: "http://localhost:8080/mostorderdish") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode([MostOrderedDishes].self, from: data)
                    DispatchQueue.main.async {
                        self.mostOrderedDishes = decoded
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
        guard let url = URL(string: "http://localhost:8080/ratingdashboard") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(RatingDashboard.self, from: data)
                    DispatchQueue.main.async {
                        self.ratingDashboard = decoded
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
