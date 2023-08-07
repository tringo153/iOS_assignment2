
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Ngo Huu Tri
  ID: 3818520
  Created  date: 27/08/2022
  Last modified: 27/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct InfoGameView: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack{
                        
            VStack {
                List {
                    
                    Section(header: Text("GAME MODE").font(.system(size: 17, weight: .bold , design: .monospaced))
                    ) {
                        Text("There are 2 game modes: Challenge and Free Style")
                        Text("In Challenge mode, you will start with limited numbers of headhunt tickets")
                        Text("You will either win when you obtained sufficient rate-up characters or lose when you use all the headhunt tickets without obtaining any target rate-ups")
                        Text("In Free Style, you will start with unlimited number of headhunt tickets. You can roll as many time as you want. However, your progress will not be saved upon leaving")
                    }
                    
                    Section(header: Text("BANNER TYPE").font(.system(size: 17, weight: .bold , design: .monospaced))
                    ) {
                        Text("There are 2 types of banners: Standard and Limited")
                        Text("In Standard banner, the featured rate-up 6 star characters will have a 50% chance of appearing.")
                        Text("In Limited banner, it will feature a rare Limited 6* unit from the special collection as a rate up along with a normal 6* character. ")
                        Text("Exclusively in this type of banner, the featured rate-up 6 star characters are harder to obtain, with 70% chance of appearing. There will also be a collection of Off-Chance Limited 6* units with a much lower drop rate compared to the featured rate-ups")
                    }
                    
                    Section(header: Text("DROP RATES").font(.system(size: 17, weight: .bold , design: .monospaced))
                    ) {
                        Text("Characters with different rarity will have different chance of obtaining")
                        Text("6 star: 2%; 5 star: 8%; 4 star: 50%; 3 star: 40%")
                    }
                    
                    Section(header: Text("PITY SYSTEM").font(.system(size: 17, weight: .bold , design: .monospaced))
                    ) {
                        Text("If you have not obtained any 6 star character after 50 rolls, the chance of getting 6 star character will increase by 2%")
                        Text("Starting from roll 51, any unsuccessful attempt at getting 6 star character, the chance will keep increasing by 2% until it hits 100%, guaranteeing you a 6 star, after which the chance will return to 2% again.")
                        Text("In each game, you can guarantee to have a 5* or 6* within the first 10 rolls. This offer only happens once for every game. After that, you will have to rely on your luck to get the highest rarity character")
                    }
                    
                    Section(header: Text("SCORE SYSTEM").font(.system(size: 17, weight: .bold , design: .monospaced))
                    ) {
                        Text("When you win or lose a game, your total score will be calculated and saved to the Leaderboard")
                        Text("Every time you obtain a 6* character, you will get a score")
                        Text("Rate up 6* character: score +500. 6* character who is not featured in the banner: score +100. 6* Limited character from Off-Chance collection exclusive to Limited banner: score +600")
                        
                        Text("When you finish a game, every remaining headhunt tickets, green tickets and gold tickets will be counted towards your score. And your final score will be multiplied based on the game difficulty")
                    }

                    
                }
            }
            
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
            }.padding(.all,5)

        }
    }
}

//struct InfoGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        InfoGameView()
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
