//
//  MenuView.swift
//  ArknightsGachaSim
//
//  Created by Huu Tri on 13/08/2022.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        ZStack {
            VStack{
                Button{  } label: {
                    Text("START GAME")
                        .frame(width: 200, height: 50)
                    
                }
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                Button{  } label: {
                    Text("SETTINGS")
                        .frame(width: 200, height: 50)
                    
                }
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                Button{  } label: {
                    Text("LEADERBOARD")
                        .frame(width: 200, height: 50)
                    
                }
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
