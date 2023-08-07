
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Ngo Huu Tri
  ID: 3818520
  Created  date: 20/08/2022
  Last modified: 22/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct SparkItemView: View {
    
    @ObservedObject var viewModel: AKHeadhuntingGame

    var sparkItem: HeadhuntingGame.SparkShopItem
    
    @Binding var isShowingConfirmed: Bool
    
    @Binding var returnedId: Int
    
    @State var idGiven: Int

    
    var body: some View {
        ZStack {
            Color("ColorBlack")
                .frame(width: 225, height: 275)
                .opacity(0.3)
            
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
                                .foregroundColor(.black)
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
                                .foregroundColor(.black)
                                .padding(.all, 5)
                                .background
                            { Capsule().fill(.white).opacity(0.8) }
                                .offset(x: 30, y: 40)
                            
                        }
                        
                        
                        Button {
                            playSoundEffect(sound: "ClickAudio", type: "mp3")
                            self.isShowingConfirmed = true
                            self.returnedId = idGiven
                        } label: {
                            
                            HStack {
                                Image("spark-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25)

                                Text(" x\(sparkItem.priceAmount)")
                                .foregroundColor(.white)

                            }
                            
                        }
                        .frame(width: 150)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(
                            Capsule().fill(Color.red)
                                .opacity(0.2)
                        )
                        
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

//struct SparkItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = AKHeadhuntingGame()
//        
//        let op = Operator(name: "Nearl the Radiant Knight", rarity: 6, image: SplashArt(profile: "nearl2-profile", e1: "none", e2:"none", tooltip: "Nearl_the_Radiant_Knight_tooltip"))
//        
//        SparkItemView(viewModel: game, sparkItem: HeadhuntingGame.SparkShopItem(name: op.name + " Contract", amount: 1, stock: 999, priceType: "Spark", priceAmount: 300, item: op))
//    }
//}
