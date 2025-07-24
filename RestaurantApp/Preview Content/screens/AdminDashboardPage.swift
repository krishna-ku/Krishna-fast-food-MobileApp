//
//  AdminDashboardPage.swift
//  RestaurantApp
//
//  Created by KRISHNA on 24/07/25.
//

import SwiftUI

struct AdminDashboardPage: View {
    @ObservedObject var dashboardViewModel: DashboardViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Admin Dashboard")
                    .font(.title)
                    .bold()
                
                // 1. Restaurant Peak Hours Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Restaurant Peak Hours")
                        .font(.headline)
                    
                    ForEach(dashboardViewModel.restaurantPeakHour) { hour in
                        Text("Hours: \(hour.time): \(hour.orders) orders")
                            .padding(.vertical, 5)
                            .padding(.horizontal)
                            .background(Color.orange.opacity(0.1))
                            .cornerRadius(8)
                    }
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Most Ordered Dishes in Last 15 Days")
                        .font(.headline)
                    
                    ForEach(dashboardViewModel.mostOrderedDishes) { dish in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("ID: \(dish.itemId)")
                            Text("Item: \(dish.item)")
                            Text("Count: \(dish.count)")
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(8)
                    }
                }

                if let ratings = dashboardViewModel.ratingDashboard {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Rating Dashboard").font(.headline)

                        Text("Total Registered Users in Restaurant: \(ratings.totalUsers)")
                        Text("Rated Orders: \(ratings.ratedOrdersCount)")
                        Text("Total Users Who Gave Rating: \(ratings.totalUsersWhoGaveRating)")
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                }
            }
            .padding()
        }
        .onAppear {
            dashboardViewModel.fetchAllData()
        }
    }
}

#Preview {
    AdminDashboardPage(dashboardViewModel: DashboardViewModel())
}
