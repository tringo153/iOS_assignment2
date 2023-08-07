
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

struct SettingsView: View {
    
    @Binding var isShowing: Bool
    
    var difficulties = ["Free To Play", "Dolphin", "Whale"]
    
    @State var difficulty = UserDefaults.standard.string(forKey: "Difficulty") ?? "Free To Play"
    
    var body: some View {
        ZStack{

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

            VStack {
                Text("SETTINGS")
                    .font(.system(size: 20, weight: .bold , design: .monospaced))
                    .padding()
                
                              
                Text("Select difficulty (Can only be applied in a new game)")
                    .font(.system(size: 17, weight: .light , design: .monospaced))
                    .frame(alignment: .leading)
                
                Picker("Choose theme music", selection: $difficulty) {
                    ForEach(difficulties, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical, 10)
                .onChange(of: self.difficulty) {
                    name in
                    playSoundEffect(sound: "ClickAudio", type: "mp3")
                    UserDefaults.standard.set(difficulty, forKey: "Difficulty")
                }
                
                VStack{
                    Text("\(difficulty)")
                        .padding(.vertical,2)
                    
                    if (difficulty == "Free To Play") {
                        Text("- Starting headhunt tickets + 50")
                        Text("- Goal to win: Collect either one of the 6* character featured in the banner")

                    } else if (difficulty == "Dolphin") {
                        Text("- Starting headhunt tickets + 100")
                        Text("- Goal to win: Collect all of each 6* character featured in the banner. You only need to obtain each character 1 time")

                    } else {
                        Text("- Starting headhunt tickets + 250")
                        Text("- Goal to win: Collect all of the 6* characters featured in the banner. For each character, you must obtain all 6 duplicates")

                    }
                    
                    Spacer()
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width-100, height: 200, alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke())
                

                Spacer()
                
                
            }
        }
        
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
