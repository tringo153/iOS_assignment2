//
//  ContentView.swift
//  ArknightsGachaSim
//
//  Created by Huu Tri on 13/08/2022.
//

import SwiftUI

struct ContentView: View {

    var viewModel = AKHeadhuntingGame()
    
    @State var isMenuActive = true
    
    var body: some View {
        
        GameSetupView(viewModel: viewModel)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
