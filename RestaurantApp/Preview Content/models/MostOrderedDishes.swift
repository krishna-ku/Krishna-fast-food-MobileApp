//
//  MostOrderedDishes.swift
//  RestaurantApp
//
//  Created by KRISHNA on 24/07/25.
//

import Foundation

struct MostOrderedDishes: Codable, Identifiable {
    var id: Int { itemId } // Using itemId as the unique identifier
    let itemId: Int
    let item: String
    let count: Int
}
