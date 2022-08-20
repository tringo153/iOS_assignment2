//
//  HeadhuntingGame.swift
//  ArknightsGachaSim
//
//  Created by Huu Tri on 16/08/2022.
//

import Foundation

struct HeadhuntingGame {
    
    private(set) var roster: Array<CharacterCard>
    private(set) var results: Array<CharacterCard>
    
    private(set) var sixStarRateUp: Array<Operator>
    private(set) var fiveStarRateUp: Array<Operator>
    private(set) var offChanceRateUp: Array<Operator>

    private(set) var sparkCounter = 0
    
    private(set) var difficulty = 1
    private(set) var offerCounter = 10
    private(set) var score = 0
    private(set) var headhuntTicket = 200
    private(set) var greenTicket = 9999
    private(set) var goldTicket = 9999
    
    private(set) var gameMode: String
    private(set) var bannerType: String
    
    private(set) var sixStarCounter = 0
    private(set) var sixStarRate = 2.0
    private(set) var rollCounter = 0
    
    private(set) var shop: Array<ShopItem>
    private(set) var sparkShop: Array<SparkShopItem>
    
    //MARK: - RATE UP LOGIC
    func rateUp(chance: (value: String, weight: Double)...) -> String {
        let rnd = Double.random(in: 0.0...100.0)
        var accWeight = 0.0

        for (value, weight) in chance {
            accWeight += weight
            
            if rnd <= accWeight {
                return value
            }
        }
        
        return chance.last!.value
    }
    
    //MARK: - HEADHUNTING LOGIC
    
    mutating func headhunt(dropRates: (value: String, weight: Double)...) -> CharacterCard {
        let rnd = Double.random(in: 0.0...100.0)
        var accWeight = 0.0
        
        for (value, weight) in dropRates {
            accWeight += weight
            
            if rnd <= accWeight {
                if (value == "6*") {
                    self.sixStarCounter = 0
                    self.sixStarRate = 2
                    self.offerCounter = -1
                } else if (value == "5*") {
                    self.offerCounter = -1
                    self.sixStarCounter += 1
                } else {
                    self.sixStarCounter += 1
                }

                if (self.bannerType == "Standard") {
                    //Once only offer logic
                    if (self.offerCounter == 0) {
                        self.offerCounter -= 1
                        if (value == "4*" || value == "3*") {
                            let newValue = rateUp(chance: ("5*",90), ("6*",10))
                            
                            let result = getCharacters(value: newValue, mode: rateUp(chance: ("Rateup",50), ("Normal",50)))
                            
                            if let unwrap = roster.first(where: { $0.operatorData.name == result.name }) {
                                let chosenIndex = index(of: unwrap)
                                
                                return roster[chosenIndex]
                                
                            } else {
                                print("Failed")
                            }
                        }
                    }
                    
                    let result = getCharacters(value: value, mode: rateUp(chance: ("Rateup",50), ("Normal",50)))
                    
                    if let unwrap = roster.first(where: { $0.operatorData.name == result.name }) {
                        let chosenIndex = index(of: unwrap)
                        
                        return roster[chosenIndex]
                        
                    } else {
                        print("Failed")
                    }

                } else if (self.bannerType == "Limited") {
                    //Once only offer logic
                    if (self.offerCounter == 0) {
                        self.offerCounter -= 1
                        if (value == "4*" || value == "3*") {
                            let newValue = rateUp(chance: ("5*",90), ("6*",10))
                            
                            let result = getCharacters(value: newValue, mode: rateUp(chance: ("Rateup",70), ("Normal",30)))
                            
                            if let unwrap = roster.first(where: { $0.operatorData.name == result.name }) {
                                let chosenIndex = index(of: unwrap)
                                
                                return roster[chosenIndex]
                                
                            } else {
                                print("Failed")
                            }
                        }
                    }
                    
                    let result = getCharacters(value: value, mode: rateUp(chance: ("Rateup",70), ("Normal",30)))
                    
                    if let unwrap = roster.first(where: { $0.operatorData.name == result.name }) {
                        let chosenIndex = index(of: unwrap)

                        return roster[chosenIndex]

                    } else {
                        print("Failed")
                    }

                }
            }
        }
        
        let result = getCharacters(value: dropRates.last!.value,mode: gameMode )
        
        if let unwrap = roster.first(where: { $0.operatorData.name == result.name }) {
            let chosenIndex = index(of: unwrap)

            return roster[chosenIndex]
        } else {
            print("Failed")
            
            return roster[0]
        }
    }
    
    mutating func getCharacters(value: String, mode: String) -> Operator {
        //MARK: - NORMAL MODE
        if (mode == "Normal") {
            if (value == "6*") {
                
                let resultOperator: Operator
                //Logic of getting off chance character in limited
                if (bannerType == "Limited" && offChanceRateUp.count > 0) {
                    let offChance = rateUp(chance: ("Rateup",30), ("Normal",70))
                    
                    if (offChance == "Rateup") {
                        resultOperator = offChanceRateUp.randomElement()!
                    } else {
                        resultOperator = sixStarPool.randomElement()!
                    }
                } else {
                    resultOperator = sixStarPool.randomElement()!
                }
                
                
                if (roster.contains(where: { $0.operatorData.name == resultOperator.name })) {
                    
                    if let unwrap = roster.first(where: { $0.operatorData.name == resultOperator.name }) {
                        
//                        print(unwrap)
                        let chosenIndex = index(of: unwrap)
                        
                        if (roster[chosenIndex].duplicate < 6) {
                            roster[chosenIndex].duplicate += 1
                            
                            self.goldTicket += 10
                        } else {
                            self.goldTicket += 15
                        }

                    } else {
                        print("Failed")
                    }
                                    
                } else {
                    self.roster.append(CharacterCard(duplicate: 1, operatorData: resultOperator))
                    self.goldTicket += 1
                }
                return resultOperator
                
            } else if (value == "5*") {
                let resultOperator = fiveStarPool.randomElement()!
                if (roster.contains(where: { $0.operatorData.name == resultOperator.name })) {
                    
                    if let unwrap = roster.first(where: { $0.operatorData.name == resultOperator.name }) {
                        
//                        print(unwrap)
                        let chosenIndex = index(of: unwrap)
                        
                        if (roster[chosenIndex].duplicate < 6) {
                            roster[chosenIndex].duplicate += 1
                            
                            self.goldTicket += 5
                        } else {
                            self.goldTicket += 8
                        }

                    } else {
                        print("Failed")
                    }
                                    
                } else {
                    self.roster.append(CharacterCard(duplicate: 1, operatorData: resultOperator))
                    self.goldTicket += 1
                }
                return resultOperator
                
            }
            
            //MARK: - RATEUP MODE
        } else if (mode == "Rateup") {
            if (value == "6*") {
                let resultOperator = sixStarRateUp.randomElement()!
                if (roster.contains(where: { $0.operatorData.name == resultOperator.name })) {
                    
                    if let unwrap = roster.first(where: { $0.operatorData.name == resultOperator.name }) {
                        
//                        print(unwrap)
                        let chosenIndex = index(of: unwrap)
                        
                        if (roster[chosenIndex].duplicate < 6) {
                            roster[chosenIndex].duplicate += 1
                            
                            self.goldTicket += 10
                        } else {
                            self.goldTicket += 15
                        }

                    } else {
                        print("Failed")
                    }
                                    
                } else {
                    self.roster.append(CharacterCard(duplicate: 1, operatorData: resultOperator))
                    self.goldTicket += 1
                }
                return resultOperator

            } else if (value == "5*") {
                let resultOperator = fiveStarRateUp.randomElement()!
                if (roster.contains(where: { $0.operatorData.name == resultOperator.name })) {
                    
                    if let unwrap = roster.first(where: { $0.operatorData.name == resultOperator.name }) {
                        
//                        print(unwrap)
                        let chosenIndex = index(of: unwrap)
                        
                        if (roster[chosenIndex].duplicate < 6) {
                            roster[chosenIndex].duplicate += 1
                            
                            self.goldTicket += 5
                        } else {
                            self.goldTicket += 8
                        }

                    } else {
                        print("Failed")
                    }
                                    
                } else {
                    self.roster.append(CharacterCard(duplicate: 1, operatorData: resultOperator))
                    self.goldTicket += 1
                }
                return resultOperator

            }
        }
        
        if (value == "4*") {
            
            let resultOperator = fourStarPool.randomElement()!
            if (roster.contains(where: { $0.operatorData.name == resultOperator.name })) {
                
                if let unwrap = roster.first(where: { $0.operatorData.name == resultOperator.name }) {
                    
//                    print(unwrap)
                    let chosenIndex = index(of: unwrap)
                    
                    if (roster[chosenIndex].duplicate < 6) {
                        roster[chosenIndex].duplicate += 1
                        
                        self.greenTicket += 30
                    } else {
                        self.greenTicket += 30
                        self.goldTicket += 1
                    }

                } else {
                    print("Failed")
                }
                                
            } else {
                self.roster.append(CharacterCard(duplicate: 1, operatorData: resultOperator))
                self.goldTicket += 1
            }
            return resultOperator
            
        } else {
            
            let resultOperator = threeStarPool[Int.random(in: 0...threeStarPool.count - 1)]
            if (roster.contains(where: { $0.operatorData.name == resultOperator.name })) {
                
                if let unwrap = roster.first(where: { $0.operatorData.name == resultOperator.name }) {
                    
//                    print(unwrap)
                    let chosenIndex = index(of: unwrap)
                    
                    if (roster[chosenIndex].duplicate < 6) {
                        roster[chosenIndex].duplicate += 1
                        
                        self.greenTicket += 5
                    } else {
                        self.greenTicket += 10
                    }

                } else {
                    print("Failed")
                }
                                
            } else {
                self.roster.append(CharacterCard(duplicate: 1, operatorData: resultOperator))
                self.goldTicket += 1
            }
            
            return resultOperator

        }
    }
    
    //MARK: - BUY ITEM LOGIC
    mutating func buyItem(item: ShopItem) {
        let index = shopIndex(of: item)
        shop[index].stock -= 1
        
        if (shop[index].priceType == "Green Ticket") {
            greenTicket -= shop[index].priceAmount
        } else {
            goldTicket -= shop[index].priceAmount
        }
        
        if (shop[index].itemType == "1 Headhunt Ticket") {
            headhuntTicket += shop[index].amount
        } else {
            headhuntTicket += shop[index].amount*10
        }
        
        updateItem(type: shop[index].priceType, itemIndex: index)
    }
    
    mutating func buySparkItem(item: SparkShopItem) {
        let sparkIndex = sparkShopIndex(of: item)
        sparkShop[sparkIndex].stock -= 1
        
        sparkCounter -= sparkShop[sparkIndex].priceAmount
        
        if (roster.contains(where: { $0.operatorData.name == sparkShop[sparkIndex].item.name })) {
            
            if let unwrap = roster.first(where: { $0.operatorData.name == sparkShop[sparkIndex].item.name }) {
                
//                    print(unwrap)
                
                let chosenIndex = index(of: unwrap)
                
                if (roster[chosenIndex].duplicate < 6) {
                    roster[chosenIndex].duplicate += 1
                    
                    if (sparkShop[sparkIndex].item.rarity == 6) {
                        self.goldTicket += 10
                    } else if (sparkShop[sparkIndex].item.rarity == 5) {
                        self.goldTicket += 5
                    } else if (sparkShop[sparkIndex].item.rarity == 4) {
                        self.greenTicket += 30
                    } else {
                        self.greenTicket += 5
                    }
                } else {
                    if (sparkShop[sparkIndex].item.rarity == 6) {
                        self.goldTicket += 15
                    } else if (sparkShop[sparkIndex].item.rarity == 5) {
                        self.goldTicket += 8
                    } else if (sparkShop[sparkIndex].item.rarity == 4) {
                        self.greenTicket += 30
                        self.goldTicket += 1
                    } else {
                        self.greenTicket += 10
                    }
                    
                }

            } else {
                print("Failed")
            }
                            
        } else {
            self.roster.append(CharacterCard(duplicate: 1, operatorData: sparkShop[sparkIndex].item))
            self.goldTicket += 1
        }
        
    }
    
    //MARK: - SHOP LOGIC
    mutating func updateItem(type: String, itemIndex: Int) {
        if (type == "Green Ticket") {
            if (10 - shop[itemIndex].stock >= 3) {
                shop[itemIndex].priceAmount = 450
            } else if (10 - shop[itemIndex].stock >= 5) {
                shop[itemIndex].priceAmount = 700
            }
            
        } else {
            if (shop[itemIndex].stock == 9) {
                shop[itemIndex].priceAmount = 18
                shop[itemIndex].amount = 2
            } else if (shop[itemIndex].stock == 8) {
                shop[itemIndex].priceAmount = 40
                shop[itemIndex].amount = 5
            } else if (shop[itemIndex].stock == 7) {
                shop[itemIndex].priceAmount = 70
                shop[itemIndex].amount = 1
                shop[itemIndex].itemType = "10 Headhunt Ticket"
                shop[itemIndex].itemImage = "x10-headhunt"
            } else if (shop[itemIndex].stock == 6) {
                shop[itemIndex].priceAmount = 120
                shop[itemIndex].amount = 2
                shop[itemIndex].itemType = "10 Headhunt Ticket"
                shop[itemIndex].itemImage = "x10-headhunt"
            } else {
                shop[itemIndex].priceAmount = 80
                shop[itemIndex].amount = 1
                shop[itemIndex].itemType = "10 Headhunt Ticket"
                shop[itemIndex].itemImage = "x10-headhunt"
            }
            
        }
    }
    
    
    //MARK: - GET INDEX
    func index(of character: CharacterCard) -> Int {
        
        for index in 0..<roster.count {
            if roster[index].id == character.id {
                return index
            }
        }
        
        return 0
    }
    
    func shopIndex(of item: ShopItem) -> Int {
        for index in 0..<shop.count {
            if shop[index].id == item.id {
                return index
            }
        }
        
        return 0
    }
    
    func sparkShopIndex(of item: SparkShopItem) -> Int {
        for index in 0..<sparkShop.count {
            if sparkShop[index].id == item.id {
                return index
            }
        }
        
        return 0
    }
    
    //MARK: - x10 HEADHUNT
    mutating func tenTimesRoll() {
        if (headhuntTicket >= 10) {
            if (results.count >= 1) {
                results.removeAll()
            }
            
            for _ in 0...9 {
                if (offerCounter > 0) {
                    offerCounter -= 1
                }
                
                if (sixStarCounter >= 50)
                {
                    sixStarRate += 2.0
                }
                
                self.results.append(headhunt(dropRates: ("6*", sixStarRate), ("5*", 8), ("4*", 50), ("3*", 40)))
                
            }
//            print(roster)
            self.headhuntTicket -= 10

        }

//        for i in 0...roster.count-1 {
//            print(roster[i].name)
//            print(roster[i]._pot)
//        }
    }
    
    //MARK: x1 HEADHUNT
    mutating func oneTimeRoll() {
        if (headhuntTicket > 0) {
            if (results.count >= 1) {
                results.removeAll()
            }
            
            if (offerCounter > 0) {
                offerCounter -= 1
            }
            
            if (sixStarCounter >= 50)
            {
                sixStarRate += 2.0
            }
            self.results.append(headhunt(dropRates: ("6*", sixStarRate), ("5*", 8), ("4*", 50), ("3*", 40)))
//            print(roster)
            headhuntTicket -= 1

        }
    }
    
    
    //MARK: - GAME SETUP
    mutating func gameSetup(mode: String, type: String, sixStarRateup: Array<Operator>, fiveStarRateup: Array<Operator>, offChanceRateup: Array<Operator>) {
        self.sixStarRateUp = sixStarRateup
        self.fiveStarRateUp = fiveStarRateup
        self.offChanceRateUp = offChanceRateup
        
        self.gameMode = mode
        self.bannerType = type
        
        self.shop.append(ShopItem(name: "Headhunt Ticket", amount: 1, stock: 10, priceType: "Green Ticket", priceAmount: 240, itemType: "1 Headhunt Ticket", itemImage: "x1-headhunt"))
        self.shop.append(ShopItem(name: "Headhunt Ticket", amount: 1, stock: 10, priceType: "Gold Ticket", priceAmount: 10, itemType: "1 Headhunt Ticket", itemImage: "x1-headhunt"))
        
        if (type == "Limited") {
            for i in 0..<sixStarRateup.count {
                    self.sparkShop.append(SparkShopItem(name: sixStarRateup[i].name + " Contract", amount: 1, stock: 999, priceType: "Spark", priceAmount: 300, item: sixStarRateup[i] ))
                }
                
            if (offChanceRateup.count > 0) {
                for i in 0..<offChanceRateup.count {
                    self.sparkShop.append(SparkShopItem(name: offChanceRateup[i].name + " Contract", amount: 1, stock: 999, priceType: "Spark", priceAmount: 300, item: offChanceRateup[i] ))

                }
            }
                
                
                for i in 0..<fiveStarRateup.count {
                    self.sparkShop.append(SparkShopItem(name: fiveStarRateup[i].name + " Contract", amount: 1, stock: 999, priceType: "Spark", priceAmount: 75, item: fiveStarRateup[i] ))

                }

        }

    }

    
    //MARK: RESULTS RESET
    mutating func cancelResults(){
        results.removeAll()
        roster.removeAll()
        offerCounter = 10
        rollCounter = 0
        sixStarCounter = 0
        greenTicket = 0
        goldTicket = 0
        headhuntTicket = 200
    }
    
    init() {
        roster = Array<CharacterCard>()
        results = Array<CharacterCard>()
        shop = Array<ShopItem>()
        sparkShop = Array<SparkShopItem>()
        
        sixStarRateUp = Array<Operator>()
        fiveStarRateUp = Array<Operator>()
        offChanceRateUp = Array<Operator>()
        
        gameMode = ""
        bannerType = ""

    }
    
    struct ShopItem: Identifiable {
        var id = UUID()
        var name: String
        var amount: Int
        var stock: Int
        var priceType: String
        var priceAmount: Int
        var itemType: String
        var itemImage: String
        
        init(name: String, amount: Int, stock: Int, priceType: String, priceAmount: Int, itemType: String, itemImage: String) {
            self.name = name
            self.amount = amount
            self.stock = stock
            self.priceType = priceType
            self.priceAmount = priceAmount
            self.itemType = itemType
            self.itemImage = itemImage
        }
    }
    
    struct SparkShopItem: Identifiable {
        var id = UUID()
        var name: String
        var amount: Int
        var stock: Int
        var priceType: String
        var priceAmount: Int
        var item: Operator
        
        init(name: String, amount: Int, stock: Int, priceType: String, priceAmount: Int, item: Operator) {
            self.name = name
            self.amount = amount
            self.stock = stock
            self.priceType = priceType
            self.priceAmount = priceAmount
            self.item = item
        }

        
    }
    
    struct CharacterCard: Identifiable {
        var id = UUID()
        var duplicate: Int
        var operatorData: Operator
        
        init(duplicate: Int, operatorData: Operator) {
            self.duplicate = duplicate
            self.operatorData = operatorData
        }
        
    }

    
}
