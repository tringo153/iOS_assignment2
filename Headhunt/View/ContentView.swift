
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Ngo Huu Tri
  ID: 3818520
  Created  date: 13/08/2022
  Last modified: 15/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = AKHeadhuntingGame()
    
    var body: some View {
        
        MenuView(viewModel: viewModel)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}


