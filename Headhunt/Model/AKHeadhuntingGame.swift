
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Ngo Huu Tri
  ID: 3818520
  Created  date: 16/08/2022
  Last modified: 25/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

class AKHeadhuntingGame: ObservableObject{
    
        
    static func createHeadhuntingGame() -> HeadhuntingGame{
        HeadhuntingGame()
    }
    
    @Published private var model: HeadhuntingGame = createHeadhuntingGame()
        
    var rosters: Array<HeadhuntingGame.CharacterCard> {
        model.roster
    }
    
    var rosterCopy: Array<HeadhuntingGame.CharacterCard> {
        model.rosterCopy
    }
    
    var results: Array<HeadhuntingGame.CharacterCard> {
        model.results
    }
    
    var offerCounter: Int {model.offerCounter}
    var score: Int {model.score}
    var headhuntTicket: Int {model.headhuntTicket}
    var greenTicket: Int {model.greenTicket}
    var goldTicket: Int {model.goldTicket}
    var sparkCounter: Int {model.sparkCounter}
    var gameMode: String {model.gameMode}
    var bannerType: String {model.bannerType}
    var difficulty: String {model.difficulty}
    var username: String {model.username}
    
    var sixStarRateup: Array<Operator> {model.sixStarRateUp}
    var fiveStarRateup: Array<Operator> {model.fiveStarRateUp}
    var offChanceRateup: Array<Operator> {model.offChanceRateUp}
    
    var shop: Array<HeadhuntingGame.ShopItem> {model.shop}
    var sparkShop: Array<HeadhuntingGame.SparkShopItem> {model.sparkShop}
    
    var SixStarCounter: Int {model.sixStarCounter}
    var SixStarRate: Double {model.sixStarRate}
    
    // MARK: - Intent(s)
    
    func resumeGame(username: String, mode: String, type: String, difficulty: String, sixStarRateup: Array<Operator>, fiveStarRateup: Array<Operator>, offChanceRateup: Array<Operator>, currentRoster: Array<HeadhuntingGame.CharacterCard>, rosterCopy: Array<HeadhuntingGame.CharacterCard>,shop: Array<HeadhuntingGame.ShopItem>, sparkShop: Array<HeadhuntingGame.SparkShopItem>, score: Int, headhuntTicket: Int, goldTicket: Int, greenTicket: Int, sparkCounter: Int, offerCounter: Int, sixStarCounter: Int) {
        
        model.resumeGame(username: username, mode: mode, type: type, difficulty: difficulty, sixStarRateup: sixStarRateup, fiveStarRateup: fiveStarRateup, offChanceRateup: offChanceRateup, currentRoster: currentRoster, rosterCopy: rosterCopy , shop: shop, sparkShop: sparkShop, score: score, headhuntTicket: headhuntTicket, goldTicket: goldTicket, greenTicket: greenTicket, sparkCounter: sparkCounter, offerCounter: offerCounter, sixStarCounter: sixStarCounter)
        
    }
    
    func tenTimesRoll() {
        model.tenTimesRoll()
    }
    
    func oneTimeRoll() {
        model.oneTimeRoll()
    }
    
    func detectWininning() -> Bool {
        model.detectWinning()
    }
    
    func detectLosing() -> Bool {
        model.detectLosing()
    }
    
    func countScore() -> Int {
        model.countScore()
    }
    
    func countFinalScore() {
        model.countFinalScore()
    }
    
    func resetGame() {
        model.cancelResults()
    }
    
    func gameSetup(username: String, mode: String, type: String, difficulty: String, sixStarRateup: Array<Operator>, fiveStarRateup: Array<Operator>, offChanceRateup: Array<Operator>) {
        model.gameSetup(username: username ,mode: mode, type: type, difficulty: difficulty, sixStarRateup: sixStarRateup, fiveStarRateup: fiveStarRateup, offChanceRateup: offChanceRateup)
    }
    
    func buyItem(shopItem: HeadhuntingGame.ShopItem) {
        model.buyItem(item: shopItem)
    }
    
    func buySparkItem(shopItem: HeadhuntingGame.SparkShopItem) {
        model.buySparkItem(item: shopItem)
    }
    
    func updateItem(type: String, itemIndex: Int) {
        model.updateItem(type: type, itemIndex: itemIndex)
    }
    
    func sortRoster(by: String, order: String) {
        model.sortRoster(by: by, order: order)
    }
    
    func resetRosterOrder() {
        model.resetOrder()
    }
 }
