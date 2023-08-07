
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Ngo Huu Tri
  ID: 3818520
  Created  date: 19/08/2022
  Last modified: 22/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct ShopItemView: View {
    
    @ObservedObject var viewModel: AKHeadhuntingGame
    
    var item: HeadhuntingGame.ShopItem
    
    @Binding var isShowingConfirmed: Bool
    
    @Binding var returnedId: Int
    
    @State var idGiven: Int
    
    var body: some View {
        ZStack {
            Color("ColorBlack")
                .frame(width: 225, height: 275)
                .opacity(0.3)
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
                            .foregroundColor(.black)
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
                                .foregroundColor(.black)
                                .padding(.all, 9)
                                .background
                                { Capsule().fill(.white).opacity(0.8) }
                                .offset(x: 30, y: 20)

                        }
                        
                        if (item.stock == 0) {
                            
                            Button {
                                playSoundEffect(sound: "ClickAudio", type: "mp3")
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
                                playSoundEffect(sound: "ClickAudio", type: "mp3")
                                self.returnedId = idGiven
                                self.isShowingConfirmed = true
                            } label: {
                             
                                if (item.priceType == "Green Ticket") {
                                    HStack {
                                        Image("green-ticket-icon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25)
                                        Text(" x\(item.priceAmount)")
                                        .foregroundColor(.white)

                                    }
                                } else {
                                    HStack {
                                        Image("gold-ticket-icon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25)

                                        Text(" x\(item.priceAmount)")
                                        .foregroundColor(.white)

                                    }

                                }
                                    
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(
                                Capsule().fill(Color.blue)
                                    .opacity(0.2)
                            )

                        }

                    }
                                                                                            
                }
                
                Spacer()
                
                
            }.overlay{
                RoundedRectangle(cornerRadius: 12)
                .stroke(Color("ColorBlack"), lineWidth: 1)
            }

        }.clipShape(RoundedRectangle(cornerRadius: 12))
            .frame(width: 225, height: 275)
            .shadow(radius: 10)
    }
}

//struct ShopItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = AKHeadhuntingGame()
//
//        ShopItemView(viewModel: game, item: HeadhuntingGame.ShopItem(name: "Headhunt Ticket", amount: 1, stock: 10, priceType: "Green Ticket", priceAmount: 240, itemType: "1 Headhunt Ticket", itemImage: "x1-headhunt"), isShowingConfirmed: false)
//    }
//}
