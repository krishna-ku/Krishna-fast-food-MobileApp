//
//  RatingDashboard.swift
//  RestaurantApp
//
//  Created by KRISHNA on 24/07/25.
//

import Foundation

struct RatingDashboard: Codable {
    let totalUsers: Int
    let ratedOrdersCount: Int
    let totalUsersWhoGaveRating: Int
}
