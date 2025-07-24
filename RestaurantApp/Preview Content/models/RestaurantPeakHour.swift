//
//  RestaurantPeakHour.swift
//  RestaurantApp
//
//  Created by KRISHNA on 24/07/25.
//


import Foundation

struct RestaurantPeakHour: Codable, Identifiable {
    var id: String { time }
    let time: String
    let orders: Int
}
