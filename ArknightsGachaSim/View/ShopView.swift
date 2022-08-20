//
//  ShopView.swift
//  ArknightsGachaSim
//
//  Created by Huu Tri on 14/08/2022.
//

import SwiftUI

struct ShopView: View {
    
    @Binding var isShowing: Bool
    
    var game: AKHeadhuntingGame
    
    @State var showObtainScreen = false
    @State var showConfirmScreen = false
    
    @State var normalItemIndex = -1
    @State var sparkItemIndex = -1
    
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
                        
                        NumberDisplayView(viewModel: game, itemType: "Headhunt Ticket")
                        
                        NumberDisplayView(viewModel: game, itemType: "Green Ticket")

                        NumberDisplayView(viewModel: game, itemType: "Gold Ticket")
                        
                        Spacer()
                        
                        Button("X") {
                            isShowing = false
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
                                
                                SparkItemView(viewModel: game, sparkItem: game.sparkShop[i])
                                
                            }
                        }
                        )
                    }
                                        
                    
                }
            }
            
            if showConfirmScreen {
                    Color("ColorBackground")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea(.all)
                    
                    VStack {
                        Spacer()
                        
                        Text("Are you sure you want to buy it?")
                            .font(.system(.body, design: .rounded))
                            .multilineTextAlignment(.center)
                        Spacer()
                        
                        HStack{
                            Button {
                                self.showConfirmScreen = false
                                self.normalItemIndex = -1
                                self.sparkItemIndex = -1
                                
                            } label: {
                                Text("Cancel")
                                    .foregroundColor(.white)
                            }.padding(.all, 10)
                                .background(
                                    Capsule().fill(.blue)
                                )
                            
                            Button {
                                game.buyItem(shopItem: game.shop[normalItemIndex])
                                self.showConfirmScreen = false
                            } label: {
                                Text("Buy")
                                    .foregroundColor(.white)
                            }.padding(.all, 10)
                                .background(
                                    Capsule().fill(.blue)
                                )

                        }
                        
                        Spacer()
                    }.frame(width: 250 , height: 150, alignment: .center)
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
