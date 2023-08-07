
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Ngo Huu Tri
  ID: 3818520
  Created  date: 14/08/2022
  Last modified: 14/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/

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

