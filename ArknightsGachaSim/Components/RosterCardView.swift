//
//  RosterCardView.swift
//  ArknightsGachaSim
//
//  Created by Huu Tri on 16/08/2022.
//

import SwiftUI

struct RosterCardView: View {
    
    var character: HeadhuntingGame.CharacterCard
    
    @State var widthScale: CGFloat = 75
    
    var body: some View {
        ZStack{
            if (character.operatorData.rarity == 6) {
                Image("Card-6")
                    .resizable()
                    .scaledToFit()
                    .frame(width: widthScale)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else if (character.operatorData.rarity == 5) {
                Image("Card-5")
                    .resizable()
                    .scaledToFit()
                    .frame(width: widthScale)
                    .clipShape(RoundedRectangle(cornerRadius: 8))


            } else if (character.operatorData.rarity == 4) {
                Image("Card-4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: widthScale)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

            } else {
                Image("Card-3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: widthScale)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

            }
                Image(character.operatorData.image.tooltip)
                    .resizable()
                    .scaledToFit()
                    .frame(width: widthScale)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                ZStack {
                    VStack {
                        if (character.operatorData.rarity == 6) {
                            Text("******")
                                .foregroundColor(.yellow)
                                .font(.system(size: widthScale-55, weight: .heavy))
                                .shadow(color: .black, radius: 4)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                
                            
                        } else if (character.operatorData.rarity == 5) {
                            Text("*****")
                                .foregroundColor(.yellow)
                                .font(.system(size: widthScale-55, weight: .heavy))
                                .shadow(color: .black, radius: 4)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                
                        } else if (character.operatorData.rarity == 4) {
                            Text("****")
                                .foregroundColor(.yellow)
                                .font(.system(size: widthScale-55, weight: .heavy))
                                .shadow(color: .black, radius: 4)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                
                        } else {
                            Text("***")
                                .foregroundColor(.yellow)
                                .font(.system(size: widthScale-55, weight: .heavy))
                                .shadow(color: .black, radius: 4)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                
                        }
                        
                        Spacer()
                        
                        HStack{
                            Spacer()
                            
                            if (character.duplicate == 6) {
                                Image("potential-6")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: widthScale-50)
                                    .shadow(color: .white, radius: 6)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
                            } else if (character.duplicate  == 5) {
                                Image("potential-5")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: widthScale-50)
                                    .shadow(color: .white, radius: 6)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
                            } else if (character.duplicate  == 4) {
                                Image("potential-4")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: widthScale-50)
                                    .shadow(color: .white, radius: 6)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))                            } else if (character.duplicate == 3) {
                                Image("potential-3")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: widthScale-50)
                                    .shadow(color: .white, radius: 6)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))                            } else if (character.duplicate == 2) {
                                Image("potential-2")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: widthScale-50)
                                    .shadow(color: .white, radius: 6)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))

                            } else {
                                Image("potential-1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: widthScale-50)
                                    .shadow(color: .white, radius: 6)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))


                            }
                            
                        }.frame(width: widthScale)
                                                    
                        Text(character.operatorData.name.uppercased())
                            .foregroundColor(.white)
                            .font(.system(size: 8, weight: .heavy))
                            .frame(width: widthScale)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                            .background{
                                RoundedRectangle(cornerRadius: 4)
                                    .foregroundColor(.black)
                                    .opacity(0.5)
                            }
                    }
                }.frame(height: widthScale*2)
            
            
            
            
            
                
        }
        .overlay(RoundedRectangle(cornerRadius: 8)
            .stroke(.brown, lineWidth: 3))
    }
}

struct RosterCardView_Previews: PreviewProvider {
    static var previews: some View {
        let chara6 = HeadhuntingGame.CharacterCard(duplicate: 1, operatorData: Operator(name: "Nearl the Radiant Knight", rarity: 6, image: SplashArt(profile: "nearl2-profile", e1: "none", e2:"none", tooltip: "Nearl_the_Radiant_Knight_tooltip")))

        
        RosterCardView(character: chara6)
    }
}
