
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Ngo Huu Tri
  ID: 3818520
  Created  date: 14/08/2022
  Last modified: 20/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct GachaResultView: View {
    
    var character: HeadhuntingGame.CharacterCard

    @State var widthScale: CGFloat = 80
    
    @State var borderColor = Color(.brown)
    
    func getColor(rarity: Int) -> Color {
        if (rarity == 6) {
            return Color(.red)
        } else if (rarity == 5) {
            return Color(.yellow)
        } else if (rarity == 4) {
            return Color(.purple)
        } else {
            return Color(.gray)
        }
    }
    
    var body: some View {
        ZStack{
            if (character.operatorData.rarity == 6) {
                Image("Card-6")
                    .resizable()
                    .frame(width: widthScale, height: widthScale*1.5)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else if (character.operatorData.rarity == 5) {
                Image("Card-5")
                    .resizable()
                    .frame(width: widthScale, height: widthScale*1.5)
                    .clipShape(RoundedRectangle(cornerRadius: 8))


            } else if (character.operatorData.rarity == 4) {
                Image("Card-4")
                    .resizable()
                    .frame(width: widthScale, height: widthScale*1.5)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

            } else {
                Image("Card-3")
                    .resizable()
                    .frame(width: widthScale, height: widthScale*1.5)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

            }
            Image(character.operatorData.image.profile)
                .resizable()
                .scaledToFit()
                .frame(width: widthScale, height: widthScale)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
                ZStack {
                    VStack {
                        if (character.operatorData.rarity == 6) {
                            Text("******")
                                .foregroundColor(.yellow)
                                .font(.system(size: widthScale/4, weight: .heavy))
                                .shadow(color: getColor(rarity: character.operatorData.rarity), radius: 4)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                
                            
                        } else if (character.operatorData.rarity == 5) {
                            Text("*****")
                                .foregroundColor(.yellow)
                                .font(.system(size: widthScale/4, weight: .heavy))
                                .shadow(color: getColor(rarity: character.operatorData.rarity), radius: 4)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                
                        } else if (character.operatorData.rarity == 4) {
                            Text("****")
                                .foregroundColor(.yellow)
                                .font(.system(size: widthScale/4, weight: .heavy))
                                .shadow(color: getColor(rarity: character.operatorData.rarity), radius: 4)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                
                        } else {
                            Text("***")
                                .foregroundColor(.yellow)
                                .font(.system(size: widthScale/4, weight: .heavy))
                                .shadow(color: getColor(rarity: character.operatorData.rarity), radius: 4)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                
                        }
                        
                        Spacer()
                        
                        HStack{
                            Spacer()
                            
                            if (character.duplicate == 6) {
                                if (character.operatorData.rarity == 6) {
                                    HStack {
                                        Image("gold-ticket-icon")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        Text("x15")
                                            .foregroundColor(.yellow)
                                            .font(.system(size: 10, weight: .heavy))
                                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                            .shadow(color: .yellow, radius: 4)
                                            
                                    }.padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                    .background{
                                        RoundedRectangle(cornerRadius: 4)
                                            .foregroundColor(.black)
                                            .opacity(0.5)
                                    }

                                } else if (character.operatorData.rarity == 5) {
                                    HStack {
                                        Image("gold-ticket-icon")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        Text("x8")
                                            .foregroundColor(.yellow)
                                            .font(.system(size: 10, weight: .heavy))
                                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                            .shadow(color: .yellow, radius: 4)
                                            
                                    }.padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                    .background{
                                        RoundedRectangle(cornerRadius: 4)
                                            .foregroundColor(.black)
                                            .opacity(0.5)
                                    }

                                } else if (character.operatorData.rarity == 4) {
                                    VStack {
                                        HStack {
                                            Image("gold-ticket-icon")
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                            Text("x1")
                                                .foregroundColor(.yellow)
                                                .font(.system(size: 15, weight: .heavy))
                                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                                .shadow(color: .yellow, radius: 4)
                                        }
                                        
                                        HStack {
                                            Image("green-ticket-icon")
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                            Text("x30")
                                                .foregroundColor(.yellow)
                                                .font(.system(size: 15, weight: .heavy))
                                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                                .shadow(color: .yellow, radius: 4)

                                        }
                                        
                                    }.padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                    .background{
                                        RoundedRectangle(cornerRadius: 4)
                                            .foregroundColor(.black)
                                            .opacity(0.5)
                                    }

                                } else {
                                    HStack {
                                        Image("green-ticket-icon")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        Text("x10")
                                            .foregroundColor(.yellow)
                                            .font(.system(size: 10, weight: .heavy))
                                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                            .shadow(color: .yellow, radius: 4)
                                            
                                    }.padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                    .background{
                                        RoundedRectangle(cornerRadius: 4)
                                            .foregroundColor(.black)
                                            .opacity(0.5)
                                    }


                                }
                            } else if (character.duplicate > 1 && character.duplicate < 6) {
                                if (character.operatorData.rarity == 6) {
                                    HStack {
                                        Image("gold-ticket-icon")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        Text("x10")
                                            .foregroundColor(.yellow)
                                            .font(.system(size: 10, weight: .heavy))
                                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                            .shadow(color: .yellow, radius: 4)
                                            
                                    }.padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                    .background{
                                        RoundedRectangle(cornerRadius: 4)
                                            .foregroundColor(.black)
                                            .opacity(0.5)
                                    }


                                } else if (character.operatorData.rarity == 5) {
                                    HStack {
                                        Image("gold-ticket-icon")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        Text("x5")
                                            .foregroundColor(.yellow)
                                            .font(.system(size: 10, weight: .heavy))
                                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                            .shadow(color: .yellow, radius: 4)
                                            
                                    }.padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                    .background{
                                        RoundedRectangle(cornerRadius: 4)
                                            .foregroundColor(.black)
                                            .opacity(0.5)
                                    }

                                } else if (character.operatorData.rarity == 4) {
                                    HStack {
                                        Image("green-ticket-icon")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        Text("x30")
                                            .foregroundColor(.yellow)
                                            .font(.system(size: 10, weight: .heavy))
                                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                            .shadow(color: .yellow, radius: 4)
                                            
                                    }.padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                    .background{
                                        RoundedRectangle(cornerRadius: 4)
                                            .foregroundColor(.black)
                                            .opacity(0.5)
                                    }

                                } else {
                                    HStack {
                                        Image("green-ticket-icon")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        Text("x5")
                                            .foregroundColor(.yellow)
                                            .font(.system(size: 10, weight: .heavy))
                                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                            .shadow(color: .yellow, radius: 4)
                                            
                                    }.padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                    .background{
                                        RoundedRectangle(cornerRadius: 4)
                                            .foregroundColor(.black)
                                            .opacity(0.5)
                                    }

                                }

                            } else {
                                Text("NEW")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 10, weight: .heavy))
                                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                    .shadow(color: .yellow, radius: 4)
                                    .background{
                                        RoundedRectangle(cornerRadius: 4)
                                            .foregroundColor(.black)
                                            .opacity(0.5)
                                    }


                            }
                            
                        }.frame(width: widthScale)
                        
                                                    
                        
                    }.frame(height: widthScale*1.5)

                }.frame(height: widthScale)
            
                
        }.frame(height: widthScale*1.5)
        .overlay{
            if (character.operatorData.rarity == 6) {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(AngularGradient(gradient: Gradient(colors: [.red,.orange,.yellow,.green,.blue,.pink,.purple,.red]), center: .center), lineWidth: 4)

            } else {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(getColor(rarity: character.operatorData.rarity), lineWidth: 3)

            }

        }
        .shadow(color: getColor(rarity: character.operatorData.rarity), radius: character.operatorData.rarity == 6 ? 9 : 5)
        .onAppear{
            if ((soundPlayer?.isPlaying) == nil) {
                playSoundEffect(sound: "card-flip", type: "mp3")
            }
            
        }
    }
    
}

struct GachaResultView_Previews: PreviewProvider {
    static var previews: some View {
        
        let chara6 = HeadhuntingGame.CharacterCard(duplicate: 6, operatorData: Operator(name: "Nearl the Radiant Knight", rarity: 6, image: SplashArt(profile: "nearl2-profile", e1: "none", e2:"none", tooltip: "Nearl_the_Radiant_Knight_tooltip")))
        
        GachaResultView(character: chara6)
    }
}
