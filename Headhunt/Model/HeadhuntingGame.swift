//
//  HeadhuntingGame.swift
//  ArknightsGachaSim
//
//  Created by Huu Tri on 16/08/2022.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Ngo Huu Tri
  ID: 3818520
  Created  date: 16/08/2022
  Last modified: 25/08/2022
  Acknowledgement:
    - rateUp function (weightedRandom by OOPer. Source: https://developer.apple.com/forums/thread/668706)
*/

import Foundation

struct HeadhuntingGame: Codable {
    
    private(set) var roster = Array<CharacterCard>()
    private(set) var rosterCopy = Array<CharacterCard>() //A copy of the roster array to preserve its order
    private(set) var results = Array<CharacterCard>()
    
    private(set) var sixStarRateUp = Array<Operator>()
    private(set) var fiveStarRateUp = Array<Operator>()
    private(set) var offChanceRateUp = Array<Operator>()

    private(set) var sparkCounter = 0
    
    private(set) var username = ""
    private(set) var difficulty = ""
    private(set) var offerCounter = 10
    private(set) var score = 0
    private(set) var headhuntTicket = 0
    private(set) var greenTicket = 0
    private(set) var goldTicket = 0
    
    private(set) var gameMode = ""
    private(set) var bannerType = ""
    
    private(set) var sixStarCounter = 0 //A counter for the game's pity system.
    private(set) var sixStarRate = 2.0
    
    private(set) var shop = Array<ShopItem>()
    private(set) var sparkShop = Array<SparkShopItem>()
        
    //MARK: - RATE UP LOGIC
    func rateUp(chance: (value: String, weight: Double)...) -> String {
        let rnd = Double.random(in: 0.0...100.0)
        var accWeight = 0.0

        //for every weight, add that weight to the accumulated weight value, check if that accumulated weight is greater or equal than
        // rnd value. if so, then return the value corresponding to the lastest weight added to the accumulated weight
        for (value, weight) in chance {
            accWeight += weight
            
            if rnd <= accWeight {
                return value
            }
        }
        
        // if the accumulated weight does not surpass the rnd value, return the value corresponding to the last weight instead
        return chance.last!.value
    }
    
    //MARK: - HEADHUNTING LOGIC
    
    mutating func headhunt(dropRates: (value: String, weight: Double)...) -> CharacterCard {
        let rnd = Double.random(in: 0.0...100.0)
        var accWeight = 0.0
        
        for (value, weight) in dropRates {
            accWeight += weight
            
            if rnd <= accWeight {

                //if the returned weighted random value is a 6*
                if (value == "6*") {
                    self.sixStarCounter = 0 //reset the 6* counter
                    self.sixStarRate = 2 //reset the chance of getting 6* back to 2
                    self.offerCounter = -1 //setting the offer counter to -1 to turn off
                } else if (value == "5*") {
                    self.offerCounter = -1
                    self.sixStarCounter += 1 //if value is not a 6*, increase the counter by 1
                } else {
                    self.sixStarCounter += 1
                }

                if (self.bannerType == "Standard") {
                    //Once only offer logic
                    if (self.offerCounter == 0) {
                        self.offerCounter -= 1 //turn off the offer counter
                        if (value == "4*" || value == "3*") {
                            // when the offer reaches 0, instead of giving 3* or 4*, return a chance of getting a 5* or 6*
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
    
    //Return an Operator object based on rarity value and mode (rate up or normal)
    mutating func getCharacters(value: String, mode: String) -> Operator {
        //MARK: - NORMAL MODE
        if (mode == "Normal") {
            if (value == "6*") {
                
                let resultOperator: Operator
                
                //Logic of getting off chance character in limited
                if (bannerType == "Limited" && offChanceRateUp.count > 0) {
                    //off chance limited character has 5 times the drop rate compared to normal 6* (which is 2)
                    let offChance = rateUp(chance: ("Rateup",10), ("Normal",90))
                    
                    if (offChance == "Rateup") {
                        resultOperator = offChanceRateUp.randomElement()!
                    } else {
                        resultOperator = sixStarPool.randomElement()!
                    }
                } else {
                    resultOperator = sixStarPool.randomElement()!
                }
                
                //if the roster already contains an operator (character) with the same name as the retured operator,
                // increase the duplicate value of that operator in the roster and give user a number of gold ticket
                // else, add this new operator value to the roster and give user 1 gold ticket
                if (roster.contains(where: { $0.operatorData.name == resultOperator.name })) {
                    
                    if let unwrap = roster.first(where: { $0.operatorData.name == resultOperator.name }) {
                        
                        let chosenIndex = index(of: unwrap)
                        
                        //if the character in the roster already has the duplicate of 6,
                        // increase the amount of tickets given to the user
                        if (roster[chosenIndex].duplicate < 6) {
                            roster[chosenIndex].duplicate += 1
                            rosterCopy[chosenIndex].duplicate += 1
                            
                            self.goldTicket += 10
                        } else {
                            self.goldTicket += 15
                        }

                    } else {
                        print("Failed")
                    }
                                    
                } else {
                    self.roster.append(CharacterCard(duplicate: 1, operatorData: resultOperator))
                    self.rosterCopy.append(CharacterCard(duplicate: 1, operatorData: resultOperator))
                    self.goldTicket += 1
                }
                return resultOperator
                
            } else if (value == "5*") {
                let resultOperator = fiveStarPool.randomElement()!
                
                //if the roster already contains an operator (character) with the same name as the retured operator,
                // increase the duplicate value of that operator in the roster and give user a number of gold ticket
                // else, add this new operator value to the roster and give user 1 gold ticket
                if (roster.contains(where: { $0.operatorData.name == resultOperator.name })) {
                    
                    if let unwrap = roster.first(where: { $0.operatorData.name == resultOperator.name }) {
                        
                        let chosenIndex = index(of: unwrap)
                        
                        //if the character in the roster already has the duplicate of 6,
                        // increase the amount of tickets given to the user

                        if (roster[chosenIndex].duplicate < 6) {
                            roster[chosenIndex].duplicate += 1
                            rosterCopy[chosenIndex].duplicate += 1
                            
                            self.goldTicket += 5
                        } else {
                            self.goldTicket += 8
                        }

                    } else {
                        print("Failed")
                    }
                                    
                } else {
                    self.roster.append(CharacterCard(duplicate: 1, operatorData: resultOperator))
                    self.rosterCopy.append(CharacterCard(duplicate: 1, operatorData: resultOperator))

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
                        
                        let chosenIndex = index(of: unwrap)
                        
                        if (roster[chosenIndex].duplicate < 6) {
                            roster[chosenIndex].duplicate += 1
                            rosterCopy[chosenIndex].duplicate += 1
                            
                            self.goldTicket += 10
                        } else {
                            self.goldTicket += 15
                        }

                    } else {
                        print("Failed")
                    }
                                    
                } else {
                    self.roster.append(CharacterCard(duplicate: 1, operatorData: resultOperator))
                    self.rosterCopy.append(CharacterCard(duplicate: 1, operatorData: resultOperator))

                    self.goldTicket += 1
                }
                return resultOperator

            } else if (value == "5*") {
                let resultOperator = fiveStarRateUp.randomElement()!
                if (roster.contains(where: { $0.operatorData.name == resultOperator.name })) {
                    
                    if let unwrap = roster.first(where: { $0.operatorData.name == resultOperator.name }) {
                        
                        let chosenIndex = index(of: unwrap)
                        
                        if (roster[chosenIndex].duplicate < 6) {
                            roster[chosenIndex].duplicate += 1
                            rosterCopy[chosenIndex].duplicate += 1
                            
                            self.goldTicket += 5
                        } else {
                            self.goldTicket += 8
                        }

                    } else {
                        print("Failed")
                    }
                                    
                } else {
                    self.roster.append(CharacterCard(duplicate: 1, operatorData: resultOperator))
                    self.rosterCopy.append(CharacterCard(duplicate: 1, operatorData: resultOperator))

                    self.goldTicket += 1
                }
                return resultOperator

            }
        }
        
        
        if (value == "4*") {
            
            let resultOperator = fourStarPool.randomElement()!
            if (roster.contains(where: { $0.operatorData.name == resultOperator.name })) {
                
                if let unwrap = roster.first(where: { $0.operatorData.name == resultOperator.name }) {
                    
                    let chosenIndex = index(of: unwrap)
                    
                    if (roster[chosenIndex].duplicate < 6) {
                        roster[chosenIndex].duplicate += 1
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
                self.rosterCopy.append(CharacterCard(duplicate: 1, operatorData: resultOperator))

                self.goldTicket += 1
            }
            return resultOperator
            
        } else {
            
            let resultOperator = threeStarPool[Int.random(in: 0...threeStarPool.count - 1)]
            if (roster.contains(where: { $0.operatorData.name == resultOperator.name })) {
                
                if let unwrap = roster.first(where: { $0.operatorData.name == resultOperator.name }) {
                    
                    let chosenIndex = index(of: unwrap)
                    
                    if (roster[chosenIndex].duplicate < 6) {
                        roster[chosenIndex].duplicate += 1
                        rosterCopy[chosenIndex].duplicate += 1
                        
                        self.greenTicket += 5
                    } else {
                        self.greenTicket += 10
                    }

                } else {
                    print("Failed")
                }
                                
            } else {
                self.roster.append(CharacterCard(duplicate: 1, operatorData: resultOperator))
                self.rosterCopy.append(CharacterCard(duplicate: 1, operatorData: resultOperator))

                self.goldTicket += 1
            }
            
            return resultOperator

        }
    }
    
    //MARK: - BUY ITEM LOGIC
    mutating func buyItem(item: ShopItem) {
        let index = shopIndex(of: item)
        shop[index].stock -= 1 //Decrease the amount of items maining in the shop
        
        //Decrease the amount of green or gold tickets corresponding to the price of the item
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
        
    }
    
    mutating func buySparkItem(item: SparkShopItem) {
        let sparkIndex = sparkShopIndex(of: item)
        sparkShop[sparkIndex].stock -= 1
        
        sparkCounter -= sparkShop[sparkIndex].priceAmount //Decrease the number of spark corresponding to the price

        //if the roster already contains an operator (character) with the same name as the retured operator,
        // increase the duplicate value of that operator in the roster and give user a number of gold ticket
        // else, add this new operator value to the roster and give user 1 gold ticket
        if (roster.contains(where: { $0.operatorData.name == sparkShop[sparkIndex].item.name })) {
            
            if let unwrap = roster.first(where: { $0.operatorData.name == sparkShop[sparkIndex].item.name }) {
                                
                let chosenIndex = index(of: unwrap)
                
                //
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
            self.rosterCopy.append(CharacterCard(duplicate: 1, operatorData: sparkShop[sparkIndex].item))
            self.goldTicket += 1
        }
        
    }
    
    //MARK: - SHOP LOGIC
    //As the the number of remaining item in the shop decreases, change the content of the item such as
    // updating the price and changing the content of the item
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
        //Clear all results
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
    
        if (bannerType == "Limited") {
            self.sparkCounter += 10
        }
        
        if (gameMode == "Freestyle") {
            self.headhuntTicket += 10

        } else {
            self.headhuntTicket -= 10

        }



    }
    
    //MARK: x1 HEADHUNT
    mutating func oneTimeRoll() {
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
    
        if (bannerType == "Limited") {
            self.sparkCounter += 1
        }

        if (gameMode == "Freestyle") {
            self.headhuntTicket += 1

        } else {
            self.headhuntTicket -= 1

        }

    }
    
    //MARK: - ROSTER
    mutating func sortRoster(by: String, order: String) {
        if (by == "Rarity") {
            if (order == "Des") {
                let newResult = self.roster.sorted(by: { $0.operatorData.rarity > $1.operatorData.rarity })
                self.roster = newResult
            } else {
                let newResult = self.roster.sorted(by: { $0.operatorData.rarity < $1.operatorData.rarity })
                self.roster = newResult
            }
        } else if (by == "Name") {
            if (order == "Des") {
                let newResult = self.roster.sorted(by: { $0.operatorData.name > $1.operatorData.name })
                self.roster = newResult
            } else {
                let newResult = self.roster.sorted(by: { $0.operatorData.name < $1.operatorData.name })
                self.roster = newResult
            }
        } else if (by == "Acq") {
            let newResult: Array<CharacterCard> = self.rosterCopy.reversed()
            self.roster = newResult
        }
        
    }
    
    mutating func resetOrder() {
        self.roster = self.rosterCopy
    }
    
    //MARK: - GAME SETUP
    mutating func gameSetup(username: String, mode: String, type: String, difficulty: String, sixStarRateup: Array<Operator>, fiveStarRateup: Array<Operator>, offChanceRateup: Array<Operator>) {
        
        self.roster.removeAll()
        self.rosterCopy.removeAll()
        self.results.removeAll()
        self.shop.removeAll()
        self.sparkShop.removeAll()
        
        self.sixStarRateUp = sixStarRateup
        self.fiveStarRateUp = fiveStarRateup
        self.offChanceRateUp = offChanceRateup
        
        self.username = username
        self.gameMode = mode
        self.bannerType = type
        self.difficulty = difficulty
        
        //Set the starting number of headhunt tickets depending on the difficulty
        if (gameMode == "Freestyle") {
            self.headhuntTicket = 0
        } else {
            if (sixStarRateup.count == 1) {
                self.headhuntTicket = 50
            } else {
                self.headhuntTicket = 100
            }

            
            if (type == "Limited") {
                self.headhuntTicket += 50
            }
            
            if (difficulty == "Free To Play") {
                self.headhuntTicket += 50
            } else if (difficulty == "Dolphin") {
                self.headhuntTicket += 100
            } else if (difficulty == "Whale") {
                self.headhuntTicket += 250
            }
        }
        
        self.score = 0
        self.goldTicket = 0
        self.greenTicket = 0
        self.sparkCounter = 0
        self.offerCounter = 10
        self.sixStarCounter = 0
        
        self.shop.append(ShopItem(name: "Headhunt Ticket", amount: 1, stock: 10, priceType: "Green Ticket", priceAmount: 240, itemType: "1 Headhunt Ticket", itemImage: "x1-headhunt"))
        self.shop.append(ShopItem(name: "Headhunt Ticket", amount: 1, stock: 10, priceType: "Gold Ticket", priceAmount: 10, itemType: "1 Headhunt Ticket", itemImage: "x1-headhunt"))
        
        //Add to the spark shop with items from the rate up collections if banner type is "Limited"
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
        
    
    //MARK: - GAME RESUME
    //Replace all the game data with the data from the parameters
    mutating func resumeGame(username: String, mode: String, type: String, difficulty: String, sixStarRateup: Array<Operator>, fiveStarRateup: Array<Operator>, offChanceRateup: Array<Operator>, currentRoster: Array<CharacterCard>, rosterCopy: Array<CharacterCard>, shop: Array<ShopItem>, sparkShop: Array<SparkShopItem>, score: Int, headhuntTicket: Int, goldTicket: Int, greenTicket: Int, sparkCounter: Int, offerCounter: Int, sixStarCounter: Int) {
        
        self.sixStarRateUp = sixStarRateup
        self.fiveStarRateUp = fiveStarRateup
        self.offChanceRateUp = offChanceRateup
        
        self.username = username
        self.difficulty = difficulty
        self.gameMode = mode
        self.bannerType = type
        
        self.score = score
        self.headhuntTicket = headhuntTicket
        self.greenTicket = greenTicket
        self.goldTicket = goldTicket
        self.sparkCounter = sparkCounter
        
        self.offerCounter = offerCounter
        self.sixStarCounter = sixStarCounter
        
        self.roster = currentRoster
        self.rosterCopy = rosterCopy
        self.shop = shop
        self.sparkShop = sparkShop
        
    }

    
    //MARK: RESULTS RESET
    mutating func cancelResults(){
        results.removeAll()
        roster.removeAll()
        rosterCopy.removeAll()
        
        shop.removeAll()
        sparkShop.removeAll()
        score = 0
        offerCounter = 0
        sixStarCounter = 0
        greenTicket = 0
        goldTicket = 0
        headhuntTicket = 0
        sparkCounter = 0
        
    }
    
    //MARK: - DETECT WINNING/LOSING LOGIC
    mutating func detectWinning() -> Bool {
        
        if (difficulty == "Free To Play") {
            //Check if has one rate up 6* in roster
            for j in 0..<roster.count {
                if (sixStarRateUp.contains(where: { $0.name == roster[j].operatorData.name })) {
                    //WIN
                    return true
                }
            }
            
            //LOSE
            return false
            
        } else if (difficulty == "Dolphin") {
            var counter = 0
            
            //If the rate up collection has more than 1 character, check in the roster if
            // it has all the characters in the rate up collection
            if (sixStarRateUp.count > 1) {
                for i in 0..<sixStarRateUp.count {
                    for j in 0..<roster.count {
                        if (sixStarRateUp.contains(where: { _ in sixStarRateUp[i].name == roster[j].operatorData.name })) {
                            counter += 1
                        }
                    }
                }

            //If the rate up collection only has 1 character, check in the roster if
            // that character has duplicate of 3
            } else if (sixStarRateUp.count == 1) {
                for j in 0..<roster.count {
                    if (sixStarRateUp.contains(where: { $0.name == roster[j].operatorData.name }) && roster[j].duplicate == 3) {
                        counter += 1
                    }
                }
            }
            
            if (counter == sixStarRateUp.count) {
                //WIN
                return true
            } else {
                //LOSE
                return false
            }
                    
        } else {
            
            var counter = 0
            
            //Check if roster has all the characters in the collection with duplicate of 6 (full duplicates)
            for i in 0..<sixStarRateUp.count {
                for j in 0..<roster.count {
                    if (sixStarRateUp.contains(where: { _ in sixStarRateUp[i].name == roster[j].operatorData.name })) {
                        if (roster[j].duplicate == 6) {
                            counter += 1
                        }
                    }
                }
            }
            
            if (counter == sixStarRateUp.count) {
                //WIN
                return true
            } else {
                //LOSE
                return false
            }

        }
    }
    
    func detectLosing() -> Bool {
        return headhuntTicket == 0
    }
    
    
    //MARK: - SCORE COUNTING LOGIC
    
    mutating func countScore() -> Int {
        var totalScore = 0
        
        if (results.count > 0) {
            for i in 0..<results.count {
                if (results[i].operatorData.rarity == 6) {
                    if (sixStarRateUp.contains(where: { $0.name == results[i].operatorData.name })) {
                        totalScore += 500 //score + 500 for every rate up 6* obtained
                        
                    } else if (offChanceRateUp.contains(where: { $0.name == results[i].operatorData.name })){
                        totalScore += 600 //score + 600 for every off chance 6* obtained
                    } else {
                        totalScore += 100 //score + 100 for every rate off 6* obtained
                    }
                    
                }
            }

        }
        
        self.score += totalScore
        return totalScore

    }
    
    mutating func countFinalScore() {
        
        self.score += (10 * self.headhuntTicket) //For every headhunt ticket remaining, score + 10
        self.score += (5 * self.goldTicket) //For every gold ticket remaining, score + 5
        self.score += self.greenTicket //For every green ticket remaining, score + 1
        
        
        //Multiply score depending on difficulty
        if (difficulty == "Dolphin") {
            self.score = (self.score * 3)/2
        } else if (difficulty == "Whale" ){
            self.score = self.score * 2
        }
    }
        
    struct ShopItem: Identifiable, Codable {
        var id = UUID()
        var name: String
        var amount: Int
        var stock: Int
        var priceType: String
        var priceAmount: Int
        var itemType: String
        var itemImage: String
        
        enum CodingKeys: String, CodingKey {
            case name
            case amount
            case stock
            case priceType
            case priceAmount
            case itemType
            case itemImage
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            name = try container.decode(String.self, forKey: .name)
            amount = try container.decode(Int.self, forKey: .amount)
            stock = try container.decode(Int.self, forKey: .stock)
            priceType = try container.decode(String.self, forKey: .priceType)
            priceAmount = try container.decode(Int.self, forKey: .priceAmount)
            itemType = try container.decode(String.self, forKey: .itemType)
            itemImage = try container.decode(String.self, forKey: .itemImage)

        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(name, forKey: .name)
            try container.encode(amount, forKey: .amount)
            try container.encode(stock, forKey: .stock)
            try container.encode(priceType, forKey: .priceType)
            try container.encode(priceAmount, forKey: .priceAmount)
            try container.encode(itemType, forKey: .itemType)
            try container.encode(itemImage, forKey: .itemImage)

        }

        
        
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
    
    struct SparkShopItem: Identifiable, Codable {
        var id = UUID()
        var name: String
        var amount: Int
        var stock: Int
        var priceType: String
        var priceAmount: Int
        var item: Operator
        
        enum CodingKeys: String, CodingKey {
            case name
            case amount
            case stock
            case priceType
            case priceAmount
            case item
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            name = try container.decode(String.self, forKey: .name)
            amount = try container.decode(Int.self, forKey: .amount)
            stock = try container.decode(Int.self, forKey: .stock)
            priceType = try container.decode(String.self, forKey: .priceType)
            priceAmount = try container.decode(Int.self, forKey: .priceAmount)
            item = try container.decode(Operator.self, forKey: .item)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(name, forKey: .name)
            try container.encode(amount, forKey: .amount)
            try container.encode(stock, forKey: .stock)
            try container.encode(priceType, forKey: .priceType)
            try container.encode(priceAmount, forKey: .priceAmount)
            try container.encode(item, forKey: .item)

        }

        
        init(name: String, amount: Int, stock: Int, priceType: String, priceAmount: Int, item: Operator) {
            self.name = name
            self.amount = amount
            self.stock = stock
            self.priceType = priceType
            self.priceAmount = priceAmount
            self.item = item
        }

        
    }
    
    struct CharacterCard: Identifiable, Codable {
        var id = UUID()
        var duplicate: Int
        var operatorData: Operator
        
        enum CodingKeys: String, CodingKey {
            case duplicate
            case operatorData
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            duplicate = try container.decode(Int.self, forKey: .duplicate)
            operatorData = try container.decode(Operator.self, forKey: .operatorData)
            
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encode(duplicate, forKey: .duplicate)
            try container.encode(operatorData, forKey: .operatorData)
        }
        
        init(duplicate: Int, operatorData: Operator) {
            self.duplicate = duplicate
            self.operatorData = operatorData
        }
        
    }

    
}
