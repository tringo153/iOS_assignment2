
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Ngo Huu Tri
  ID: 3818520
  Created  date: 13/08/2022
  Last modified: 20/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct HowToPlayView: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        
        ZStack{
            
            
            VStack {
                List {
                    Section(header: Text("WELCOME TO ARKNIGHTS GACHA SIM").font(.system(size: 17, weight: .bold , design: .monospaced))
                        ) {
                        
                        Text("Arknights Gacha Sim is all about spending your currency to gamble for your favorite rare characters")
                        Text("Your goal is to manage your spending resources and save as much as you can while collecting rare units")
                        
                    }
                    
                    Section(header: Text("GACHA CONCEPT").font(.system(size: 17, weight: .bold , design: .monospaced))
                        ) {
                        
                        Text("A place where you gamble for rare characters is usually called \"Banner\"")
                        Text("Similar to the gacha system in Arknights, a banner will contain a variety of characters that you will randomly obtain")
                        Text("At the same time, a banner will also feature specific rate-up units that have a higher chance to obtain among all characters")

                    }
                    
                    Section(header: Text("USER GUIDE").font(.system(size: 17, weight: .bold , design: .monospaced))
                        ) {
                        
                        Text("Before starting a game, you will need to set up beforehand.")
                        
                        Text("In the set up stage, you will be required to enter your username, to choose your preferred game mode and type of banner you want to headhunt.")
                        
                        Text("Afterwards, you can select rate-up characters that you want and you will be ready to play the game")
                        
                        HStack {

                            Text("Spend headhunt ticket \(Image("headhunt-icon")) to perform a headhunt. You can perform a one-time or ten-times headhunt to get a character")
                        }
                        
                        Text("You can keep track of how many characters you have obtained through the roster page")
                        
                        HStack {
                            Text("To win in this game, you need to obtain those featured rate-up units before you use all your headhunt tickets \(Image("headhunt-icon"))")

                        }
                        
                        Text("Depending on the selected difficulty, the number of rate-up units required to obtain will vary")
                        
                        Text("After obtaining a character, you will be rewared with special currency such as green ticket \(Image("green-ticket-icon")) and gold ticket \(Image("gold-ticket-icon"))")
                        
                        Text("Use those tickets to buy more headhunt tickets in the shop for more chances of winning")
                                                
                    }
                                        
                }
                
                
            }.frame(width: UIScreen.main.bounds.width-50)

            VStack{
                HStack{
                    Spacer()
                    
                    Button {
                        playSoundEffect(sound: "ClickAudio", type: "mp3")
                        isShowing = false
                    } label: {
                        Image(systemName: "x.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                            .foregroundColor(Color("ColorButton"))
                    }
                }
                .padding()
                
                Spacer()
            }.frame(width: UIScreen.main.bounds.width-50)
            .padding(.all,5)
        }
    }
}

//struct HowToPlayView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        HowToPlayView()
//            .preferredColorScheme(.dark)
//            .previewInterfaceOrientation(.landscapeRight)
//    }
//}
