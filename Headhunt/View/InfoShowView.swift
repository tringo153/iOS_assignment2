
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

struct InfoShowView: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack{
                        
            VStack {
                List {
                    Section(header: Text("CURRENCY").font(.system(size: 17, weight: .bold , design: .monospaced))
                    ) {
                        
                        Text("There are two types of currency used in this shop: Green ticket and Gold ticket")
                        Text("You can obtain Green and Gold ticket by obtaining characters in headhunting. Every time you get a brand new character for the first time. You will obtain 1 Gold ticket.")
                        Text("More value of Green and Gold ticket will be rewarded when you obtain a duplicate of a character")
                        Text("You can use the currencies you accumulated to buy more headhunting tickets")
                        
                    }
                    
                    Section(header: Text("SPARK SHOP").font(.system(size: 17, weight: .bold , design: .monospaced))
                    ) {
                        
                        Text("In Limited banner type, there will be a special currency called Spark. You get 1 Spark for each headhunting you perform in game")
                        Text("You can use Spark to purchase in the Spark Shop exclusively for Limited banner game")
                        
                        Text("In the Spark Shop, you can buy for the 6 star and 5 star characters featured in the Limited banner. 6 star character costs 300 Spark and 5 star costs 75 Spark")
                        
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

//struct InfoShowView_Previews: PreviewProvider {
//    static var previews: some View {
//        InfoShowView()
//    }
//}
