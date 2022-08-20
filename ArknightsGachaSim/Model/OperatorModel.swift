//
//  OperatorModel.swift
//  ArknightsGachaSim
//
//  Created by Huu Tri on 14/08/2022.
//

import Foundation

var sixStarPool = decodeFromJsonFile(jsonFileName: "SixStarPool.json")

var limitedPool = decodeFromJsonFile(jsonFileName: "LimitedSixStarPool.json")

var fiveStarPool = decodeFromJsonFile(jsonFileName: "FiveStarPool.json")

var fourStarPool = decodeFromJsonFile(jsonFileName: "FourStarPool.json")

var threeStarPool = decodeFromJsonFile(jsonFileName: "ThreeStarPool.json")

func decodeFromJsonFile(jsonFileName: String) -> [Operator] {
    if let file = Bundle.main.url(forResource: jsonFileName, withExtension: nil){
        if let data = try? Data(contentsOf: file) {
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([Operator].self, from: data)
                return decoded
            } catch let error {
                fatalError("Failed to decode JSON: \(error)")
            }
        }
    } else {
        fatalError("Couldn't load \(jsonFileName) file")
    }
    return [ ] as [Operator]
}
