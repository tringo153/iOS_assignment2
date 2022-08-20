//
//  ShopItemView.swift
//  ArknightsGachaSim
//
//  Created by Huu Tri on 19/08/2022.
//

import SwiftUI

struct ShopItemView: View {
    
    @ObservedObject var viewModel: AKHeadhuntingGame
    
    var item: HeadhuntingGame.ShopItem
    
    @Binding var isShowingConfirmed: Bool
    
    @Binding var returnedId: Int
    
    @State var idGiven: Int
    
    @State var showObtainScreen = false
    @State var showConfirmScreen = false
        
    
    var body: some View {
        ZStack {
            VStack {
                
                    Text(item.name)
                        .font(.system(size: 20, design: .rounded))
                        .fontWeight(.bold)
                        .frame(minWidth: 0, idealWidth: 280, maxWidth: 320, minHeight: 50, maxHeight: 50)
                        .background(.blue)
                        .foregroundColor(.white)

                
                                
                Spacer()
                
                VStack {
                    HStack {
                        Spacer()
                        Text("\(item.stock) remaining")
                            .padding(.all, 05)
                            .background
                            { Capsule().fill(.white).opacity(0.8) }
                    }.padding(.trailing)
                    
                    
                    VStack {
                        ZStack {
                            Image(item.itemImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                            
                            Text("x \(item.amount)")
                                .padding(.all, 9)
                                .background
                                { Capsule().fill(.white).opacity(0.8) }
                                .offset(x: 30, y: 20)

                        }
                        
                        if (item.stock == 0) {
                            
                            Button {
                                viewModel.buyItem(shopItem: item)
                            } label: {
                                
                             
                                    Text("Out of stock")
                                    .foregroundColor(.white)

                                                    }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(
                                Capsule().fill(Color.gray)
                            )
                            .disabled(true)
                            
                        } else {
                            
                            Button {
                                self.returnedId = idGiven
                                self.isShowingConfirmed = true
                            } label: {
                                
                             
                                    Text("\(item.priceType) x\(item.priceAmount)")
                                    .foregroundColor(.white)

                                                    }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(
                                Capsule().fill(Color.blue)
                            )

                        }

                    }
                                                                                            
                }
                
                Spacer()
                
                
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .frame(width: 225, height: 225)
            .shadow(radius: 10)
            
                        
        }
    }
}

//struct ShopItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = AKHeadhuntingGame()
//
//        ShopItemView(viewModel: game, item: HeadhuntingGame.ShopItem(name: "Headhunt Ticket", amount: 1, stock: 10, priceType: "Green Ticket", priceAmount: 240, itemType: "1 Headhunt Ticket", itemImage: "x1-headhunt"), isShowingConfirmed: false)
//    }
//}
