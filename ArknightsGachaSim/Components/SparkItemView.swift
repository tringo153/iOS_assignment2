//
//  SparkItemView.swift
//  ArknightsGachaSim
//
//  Created by Huu Tri on 20/08/2022.
//

import SwiftUI

struct SparkItemView: View {
    
    @ObservedObject var viewModel: AKHeadhuntingGame

    var sparkItem: HeadhuntingGame.SparkShopItem

    
    var body: some View {
        ZStack {
            VStack {
                
                
                Text(sparkItem.name)
                    .font(.system(size: 20, design: .rounded))
                    .fontWeight(.bold)
                    .padding()
                    .frame(minWidth: 0, idealWidth: 280, maxWidth: 320, minHeight: 50, maxHeight: 50)
                    .background(.red)
                    .foregroundColor(.white)

            
                
                                
                Spacer()
                
                VStack {
                    
                    HStack {
                        HStack {
                            Spacer()
                            Text("\(sparkItem.stock) remaining")
                                .padding(.all, 05)
                                .background
                                { Capsule().fill(.white).opacity(0.8) }
                        }.padding(.trailing)
                    }
                    
                    VStack {
                        ZStack {
                            Image(sparkItem.item.image.profile)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150)
                            
                            Text("x \(sparkItem.amount)")
                                .padding(.all, 5)
                                .background
                            { Capsule().fill(.white).opacity(0.8) }
                                .offset(x: 30, y: 40)
                            
                        }
                        
                        
                        Button {
                            
                        } label: {
                            Text("\(sparkItem.priceType) x\(sparkItem.priceAmount)")
                                .foregroundColor(.white)
                            
                            
                        }
                        .frame(width: 150)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(
                            Capsule().fill(Color.red)
                        )
                        
                    }
                }
                
                Spacer()
                
            }.clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(width: 225, height: 275)
                .shadow(radius: 10)

        }
    }
}

struct SparkItemView_Previews: PreviewProvider {
    static var previews: some View {
        let game = AKHeadhuntingGame()
        
        let op = Operator(name: "Nearl the Radiant Knight", rarity: 6, image: SplashArt(profile: "nearl2-profile", e1: "none", e2:"none", tooltip: "Nearl_the_Radiant_Knight_tooltip"))
        
        SparkItemView(viewModel: game, sparkItem: HeadhuntingGame.SparkShopItem(name: op.name + " Contract", amount: 1, stock: 999, priceType: "Spark", priceAmount: 300, item: op))
    }
}
