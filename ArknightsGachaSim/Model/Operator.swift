//
//  Operator.swift
//  ArknightsGachaSim
//
//  Created by Huu Tri on 14/08/2022.
//

import Foundation

// MARK: - Operator
struct Operator: Codable, Identifiable {
    let id = UUID()
    let name: String
    let rarity: Int
    let image: SplashArt

}

// MARK: - Image
struct SplashArt: Codable {
    let profile, e1, e2, tooltip: String
}

