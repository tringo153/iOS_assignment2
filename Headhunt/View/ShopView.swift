
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Ngo Huu Tri
  ID: 3818520
  Created  date: 14/08/2022
  Last modified: 26/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct ShopView: View {
    
    @Binding var isShowing: Bool
    
    @ObservedObject var game: AKHeadhuntingGame
    
    @Binding var winningState: Bool
    
    @State var showInfoShopView = false
    
    @State var showObtainScreen = false
    
    @State var showConfirmScreen = false
    
    @State var normalItemIndex = -1
    @State var sparkItemIndex = -1
    
    func saveGame() {
        do {
            let sixStarRateUp = try JSONEncoder().encode(game.sixStarRateup)
            let fiveStarRateUp = try JSONEncoder().encode(game.fiveStarRateup)
            let offChanceRateUp = try JSONEncoder().encode(game.offChanceRateup)
            
            let roster = try JSONEncoder().encode(game.rosters)
            let rosterCopy = try JSONEncoder().encode(game.rosterCopy)
            let shop = try JSONEncoder().encode(game.shop)
            let sparkShop = try JSONEncoder().encode(game.sparkShop)
            
            UserDefaults.standard.set(sixStarRateUp, forKey: "SixStarRateUp")
            UserDefaults.standard.set(fiveStarRateUp, forKey: "FiveStarRateUp")
            UserDefaults.standard.set(offChanceRateUp, forKey: "OffChanceRateUp")

            UserDefaults.standard.set(roster, forKey: "Roster")
            UserDefaults.standard.set(rosterCopy, forKey: "RosterCopy")
            UserDefaults.standard.set(shop, forKey: "Shop")
            UserDefaults.standard.set(sparkShop, forKey: "SparkShop")

            
        } catch {
            print(error.localizedDescription)
        }
        
        UserDefaults.standard.set(game.headhuntTicket, forKey: "HeadhuntTicket")
        UserDefaults.standard.set(game.sparkCounter, forKey: "SparkCounter")
        UserDefaults.standard.set(game.goldTicket, forKey: "GoldTicket")
        UserDefaults.standard.set(game.greenTicket, forKey: "GreenTicket")
        UserDefaults.standard.set(game.offerCounter, forKey: "OfferCounter")
        UserDefaults.standard.set(game.bannerType, forKey: "BannerType")
        UserDefaults.standard.set(game.gameMode, forKey: "GameMode")
        UserDefaults.standard.set(game.SixStarCounter, forKey: "SixStarCounter")
        
    }

    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 3, alignment: nil),
        GridItem(.flexible(), spacing: 3, alignment: nil),
        GridItem(.flexible(), spacing: 3, alignment: nil),

    ]
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    HStack{
                        
                        Button{ playSoundEffect(sound: "ClickAudio", type: "mp3"); self.showInfoShopView.toggle() } label: {
                            Image(systemName: "questionmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)

                        }
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                        .foregroundColor(Color("ColorButton"))
                        .sheet(isPresented: $showInfoShopView) {
                            InfoShowView(isShowing: $showInfoShopView)
                        }

                        
                        NumberDisplayView(viewModel: game, itemType: "Headhunt Ticket")
                        
                        NumberDisplayView(viewModel: game, itemType: "Green Ticket")

                        NumberDisplayView(viewModel: game, itemType: "Gold Ticket")
                        
                        if (game.bannerType == "Limited") {
                            NumberDisplayView(viewModel: game, itemType: "Spark")
                        }

                        Spacer()
                                                
                        Button {
                            playSoundEffect(sound: "ClickAudio", type: "mp3")
                            
                            if (game.detectWininning()) {
                                game.countFinalScore()
                            }
                            
                            winningState = game.detectWininning()
                            
                            isShowing = false
                            showObtainScreen = false
                        } label: {
                            Image(systemName: "x.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .foregroundColor(Color("ColorButton"))
                        }

                    }.padding()
                    
                    Text("SHOP")
                    
                    LazyVGrid(columns: columns, alignment: .center, spacing: 20, pinnedViews: [], content: {
                        ForEach(0...game.shop.count-1, id: \.self) {
                            i in
                            
                            ShopItemView(viewModel: game, item: game.shop[i], isShowingConfirmed: $showConfirmScreen, returnedId: $normalItemIndex, idGiven: i )
                            
                        }
                    }
                    )
                    
                    if (game.bannerType == "Limited") {
                        Text("SPARK")

                        LazyVGrid(columns: columns, alignment: .center, spacing: 20, pinnedViews: [], content: {
                            ForEach(0...game.sparkShop.count-1, id: \.self) {
                                i in
                                
                                SparkItemView(viewModel: game, sparkItem: game.sparkShop[i], isShowingConfirmed: $showConfirmScreen, returnedId: $sparkItemIndex, idGiven: i)
                                
                            }
                        }
                        )
                    }
                                        
                    
                }
            }
            .onAppear{
                playSound(sound: "shop-music", type: "mp3")
            }.onDisappear{
                playSound(sound: UserDefaults.standard.string(forKey: "Theme Song") ?? "Void", type: "mp3")
            }
            
            if showConfirmScreen {
                    Color("ColorBackground")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea(.all)
                    
                    VStack {
                        Spacer()
                        
                        if (normalItemIndex != -1) {
                            if (game.shop[normalItemIndex].priceType == "Green Ticket") {
                                if (game.greenTicket < game.shop[normalItemIndex].priceAmount) {
                                    Text("Purchase failed")
                                        .modifier(ShopConfirmText())
                                    
                                    Text("Insufficient Green Ticket")
                                        .modifier(ShopConfirmText())
                                } else {
                                    Text("Are you sure you want to buy it?")
                                        .modifier(ShopConfirmText())

                                }
                            } else if (game.shop[normalItemIndex].priceType == "Gold Ticket") {
                                if (game.goldTicket < game.shop[normalItemIndex].priceAmount) {
                                    Text("Purchase failed")
                                        .modifier(ShopConfirmText())
                                    Text("Insufficient Gold Ticket")
                                        .modifier(ShopConfirmText())
                                } else {
                                    Text("Are you sure you want to buy it?")
                                        .modifier(ShopConfirmText())
                                }

                            }
                        } else if (sparkItemIndex != -1) {
                            if (game.sparkCounter < game.sparkShop[sparkItemIndex].priceAmount) {
                                Text("Purchase failed")
                                    .modifier(ShopConfirmText())
                                Text("Insufficient Spark")
                                    .modifier(ShopConfirmText())
                            } else {
                                Text("Are you sure you want to buy it?")
                                    .modifier(ShopConfirmText())
                            }

                        }
                        
                        Spacer()
                        
                        HStack{
                            Button {
                                playSoundEffect(sound: "ClickAudio3", type: "mp3")
                                self.showConfirmScreen = false
                                self.normalItemIndex = -1
                                self.sparkItemIndex = -1
                                
                            } label: {
                                Text("Cancel")
                                    .foregroundColor(Color("ColorWhite"))
                            }.padding(.all, 10)
                                .background(
                                    Capsule().fill(Color("ColorButton"))
                                )
                            
                            if (normalItemIndex != -1) {
                                if (game.shop[normalItemIndex].priceType == "Green Ticket") {
                                    if (game.greenTicket >= game.shop[normalItemIndex].priceAmount) {
                                        Button {
                                            playSoundEffect(sound: "ClickAudio", type: "mp3")
                                            game.buyItem(shopItem: game.shop[normalItemIndex])
                                            self.showConfirmScreen = false
                                            self.showObtainScreen = true
                                            saveGame()
                                            
                                        } label: {
                                        Text("Confirm")
                                            .foregroundColor(Color("ColorWhite"))
                                    }.padding(.all, 10)
                                        .background(
                                            Capsule().fill(Color("ColorButton"))
                                        )
                                    }

                                } else if (game.shop[normalItemIndex].priceType == "Gold Ticket") {
                                    if (game.goldTicket >= game.shop[normalItemIndex].priceAmount) {
                                        Button {
                                            game.buyItem(shopItem: game.shop[normalItemIndex])
                                            self.showConfirmScreen = false
                                            self.showObtainScreen = true
                                            saveGame()
                                    } label: {
                                        Text("Confirm")
                                            .foregroundColor(Color("ColorWhite"))
                                    }.padding(.all, 10)
                                        .background(
                                            Capsule().fill(Color("ColorButton"))
                                        )
                                    }
                                }
                                                            
                            } else if (sparkItemIndex != -1) {
                                if (game.sparkCounter >= game.sparkShop[sparkItemIndex].priceAmount) {

                                    Button {
                                        game.buySparkItem(shopItem: game.sparkShop[sparkItemIndex])
                                        self.showConfirmScreen = false
                                        self.showObtainScreen = true
                                        saveGame()
                                    } label: {
                                        Text("Buy")
                                            .foregroundColor(Color("ColorWhite"))
                                    }.padding(.all, 10)
                                        .background(
                                            Capsule().fill(Color("ColorButton"))
                                        )
                                }
                            }
                            

                        }
                        
                        Spacer()
                    }.frame(width: 250 , height: 150, alignment: .center)
                    .background(.white)
                    .cornerRadius(20)

            }
            
            if showObtainScreen {
                Color("ColorBackground")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea(.all)
                
                VStack {
                    
                    Text("OBTAINED")
                        .font(.system(size: 20, design: .rounded))
                        .fontWeight(.bold)
                        .frame(minWidth: 0, idealWidth: 280, maxWidth: 320, minHeight: 50, maxHeight: 50)
                        .background(.blue)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    if (sparkItemIndex != -1) {
                        
                        if let unwrap = game.rosters.first(where: { $0.operatorData.name == game.sparkShop[sparkItemIndex].item.name }) {
                            
                            GachaResultView(character: unwrap)
                            
                        }
                        
                    } else if (normalItemIndex != -1) {
                        
                        ZStack {
                            Image(game.shop[normalItemIndex].itemImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                            
                            Text("x \(game.shop[normalItemIndex].amount)")
                                .padding(.all, 9)
                                .foregroundColor(.black)
                                .background
                                { Capsule().fill(.white).opacity(0.8) }
                                .offset(x: 30, y: 20)

                        }

                    }
                    
                    
                    Spacer()
                    
                    HStack{
                        Button {
                            playSoundEffect(sound: "ClickAudio3", type: "mp3")
                            if (normalItemIndex != -1) {
                                game.updateItem(type: game.shop[normalItemIndex].priceType, itemIndex: normalItemIndex)
                            }
                            self.showObtainScreen = false
                            self.normalItemIndex = -1
                            self.sparkItemIndex = -1
                            
                        } label: {
                            Text("Cancel")
                                .foregroundColor(Color("ColorWhite"))
                        }.padding(.all, 10)
                            .background(
                                Capsule().fill(Color("ColorButton"))
                            )

                    }
                    
                    Spacer()
                    
                }.frame(width: 250 , height: 250, alignment: .center)
                .background(.white)
                .cornerRadius(20)

            }
            
            
            
            
        }
    }
}

//struct ShopView_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        let game = AKHeadhuntingGame()
//
//        ShopView(game: game)
//    }
//}
