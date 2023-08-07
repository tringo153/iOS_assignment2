
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

struct InfoRosterView: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack{
            
            VStack {
                List {
                    Section(header: Text("CHARACTERS").font(.system(size: 17, weight: .bold , design: .monospaced))
                    ) {
                        
                        Text("Each character has different rarity (ranging from 3 star to 6 star). The higher the rarity, the lower the chance for you to obtain")
                        Text("When you obtain a duplicate of an already owned character, their potential will increased by 1")
                        
                        Text("A newly obtained character will have their potential start from 1 , and it has a maximum of 6")
                        
                        HStack{
                            Text("Character potentials are indicated by these icons: ")
                            ForEach(1..<7) {
                                i in
                                Image("potential-\(i)")
                                    .resizable()
                                    .modifier(IconForHowToPlay())
                            }
                        }
                        
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
//
//struct InfoRosterView_Previews: PreviewProvider {
//    static var previews: some View {
//        InfoRosterView()
//    }
//}
