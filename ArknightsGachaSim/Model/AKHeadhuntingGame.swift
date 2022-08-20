//
//  AKHeadhuntingGame.swift
//  ArknightsGachaSim
//
//  Created by Huu Tri on 16/08/2022.
//

import SwiftUI

class AKHeadhuntingGame: ObservableObject{
    
    static func createHeadhuntingGame() -> HeadhuntingGame{
        HeadhuntingGame()
    }
    
    @Published private var model: HeadhuntingGame = createHeadhuntingGame()
    
    var rosters: Array<HeadhuntingGame.CharacterCard> {
        model.roster
    }
    
    var results: Array<HeadhuntingGame.CharacterCard> {
        model.results
    }
    
    var offerCounter: Int {model.offerCounter}
    var score: Int {model.score}
    var headhuntTicket: Int {model.headhuntTicket}
    var greenTicket: Int {model.greenTicket}
    var goldTicket: Int {model.goldTicket}
    var gameMode: String {model.gameMode}
    var bannerType: String {model.bannerType}
    
    var sixStarRateup: Array<Operator> {model.sixStarRateUp}
    var fiveStarRateup: Array<Operator> {model.fiveStarRateUp}
    var offChanceRateup: Array<Operator> {model.offChanceRateUp}
    
    var shop: Array<HeadhuntingGame.ShopItem> {model.shop}
    var sparkShop: Array<HeadhuntingGame.SparkShopItem> {model.sparkShop}
    
    var SixStarCounter: Int {model.sixStarCounter}
    var SixStarRate: Double {model.sixStarRate}
    var rollCounter: Int {model.rollCounter}
    
    // MARK: - Intent(s)
    
    func tenTimesRoll() {
        model.tenTimesRoll()
    }
    
    func oneTimeRoll() {
        model.oneTimeRoll()
    }
    
    func reset() {
        model.cancelResults()
    }
    
    func gameSetup(mode: String, type: String, sixStarRateup: Array<Operator>, fiveStarRateup: Array<Operator>, offChanceRateup: Array<Operator>) {
        model.gameSetup(mode: mode, type: type, sixStarRateup: sixStarRateup, fiveStarRateup: fiveStarRateup, offChanceRateup: offChanceRateup)
    }
    
    func buyItem(shopItem: HeadhuntingGame.ShopItem) {
        model.buyItem(item: shopItem)
    }
 }
