
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Ngo Huu Tri
  ID: 3818520
  Created  date: 19/08/2022
  Last modified: 23/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct HiddenGachaResultView: View {
    var character: HeadhuntingGame.CharacterCard
    
    @Binding var animating: Bool
    @Binding var isImageFlipped: Bool
    @State private var rotation: Double = 0

    
    @State var widthScale: CGFloat = 80
    
    
    @Binding var hiddenCount: Int
    
    var body: some View {
        
        ZStack {
            if (isImageFlipped == false) {
                Image("hidden-gacha")
                    .resizable()
                    .frame(width: widthScale, height: widthScale*1.5)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .scaleEffect(1)
            } else {
                GachaResultView(character: character)
                    .scaleEffect(1)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                
            }
            
            
        }
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
        .onTapGesture {
            withAnimation(Animation.linear(duration: 0.3)) {
                if (isImageFlipped == false) {
                    self.animating.toggle()
                }
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                if self.animating {
                    withAnimation(Animation.linear(duration: 0.01)) {
                        self.rotation += 3
                    }
                    if self.rotation == 90 || self.rotation == 270 {
                        self.isImageFlipped = true
                        self.hiddenCount -= 1
                    } else if self.rotation == 360 || self.rotation == 180 {
                        self.animating = false
                    }
                    
                    if self.rotation == 360 {
                        self.rotation = 0
                    }
                }
            }
        }
        .onDisappear {
            self.isImageFlipped = false
            self.animating = false
        }
                
    }
}

//struct HiddenGachaResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        let chara5 = HeadhuntingGame.CharacterCard(duplicate: 6, operatorData: Operator(name: "Hung", rarity: 5, image: SplashArt(profile: "hung-profile", e1: "none", e2:"none", tooltip: "Hung_tooltip")))
//
//        
//        HiddenGachaResultView(character: chara5, isImageFlipped: false, hiddenCount: .constant(0))
//    }
//}
