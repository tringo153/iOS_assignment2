//
//  RosterView.swift
//  ArknightsGachaSim
//
//  Created by Huu Tri on 13/08/2022.
//

import SwiftUI

struct RosterView: View {
    
    @Binding var isShowing: Bool
    
    var game: AKHeadhuntingGame
    
        
    let rows: [GridItem] = [
        GridItem(.flexible(), spacing: 10, alignment: nil),
        GridItem(.flexible(), spacing: 10, alignment: nil),
    ]

    
    var body: some View {
        ZStack {
            
            ScrollView(.horizontal){
                
                LazyHGrid(rows: rows, alignment: .center, spacing: 10, pinnedViews: [], content: {
                    ForEach(game.rosters) {
                        chara in
                        RosterCardView(character: chara)
                            .frame(width: 50)
                            .padding()
                        
                    }
                }).padding(EdgeInsets(top: 30, leading: 20, bottom: 10, trailing: 20))
                
            }
            
            Button("Dismiss Me") {
                isShowing = false
            }.offset(x: 0, y: -170)
            
            
        }
    }
}

//struct RosterView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = AKHeadhuntingGame()
//            RosterView(isShowing: showing ,game: game)
//    }
//}
