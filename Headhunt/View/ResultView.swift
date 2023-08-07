
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Ngo Huu Tri
  ID: 3818520
  Created  date: 16/08/2022
  Last modified: 14/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct ResultView: View {
    
    @ObservedObject var viewModel: AKHeadhuntingGame

    @Binding var hiddenCounter: Int
    @Binding var winningState: Bool
    @Binding var losingState: Bool
    
    @Binding var isShowing: Bool
    
    @State var flipState = [false, false, false, false, false, false, false ,false, false, false]
    @State var animateState = [false, false, false, false, false, false, false ,false, false, false]

    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 3, alignment: nil),
        GridItem(.flexible(), spacing: 3, alignment: nil),
        GridItem(.flexible(), spacing: 3, alignment: nil),
        GridItem(.flexible(), spacing: 3, alignment: nil),
        GridItem(.flexible(), spacing: 3, alignment: nil),
    ]
    
    let oneColumn: [GridItem] = [
        GridItem(.flexible(), spacing: 3, alignment: nil),
    ]
    
    func flipAll() {
        for i in 0..<flipState.count {
            if (flipState[i] == false) {
                animateState[i] = true
            } else {
                continue
            }
        }
    }
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("ColorWhite"), Color("ColorHeadhunt")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)

            VStack {
                if (viewModel.results.count > 0) {
                    if (viewModel.results.count == 10) {
                        
                        LazyVGrid(columns: columns, alignment: .center, spacing: 20, pinnedViews: [], content: {
                            ForEach(0...viewModel.results.count-1, id: \.self) {
                                i in
                                VStack {
                                    HiddenGachaResultView(character: viewModel.results[i], animating: $animateState[i], isImageFlipped: $flipState[i], hiddenCount: $hiddenCounter)
                                }
                                
                            }
                            
                        }
                        ).padding()
                        
                    } else {
                        LazyVGrid(columns: oneColumn, alignment: .center, spacing: 20, pinnedViews: [], content: {
                            ForEach(0...viewModel.results.count-1, id: \.self) {
                                i in
                                VStack {

                                    HiddenGachaResultView(character: viewModel.results[i], animating: $animateState[i], isImageFlipped: $flipState[i], hiddenCount: $hiddenCounter)

                                }
                                
                            }
                            
                        }
                        ).padding()
                    }
                    
                }
                HStack {
                    
                    if (hiddenCounter == 0) {
                        Button( action: {
                            isShowing = false
                            
                            if (viewModel.gameMode == "Challenge") {
                                _ = viewModel.countScore()
                                
                                if (viewModel.detectWininning() || viewModel.detectLosing()) {
                                    viewModel.countFinalScore()
                                }
                                winningState = viewModel.detectWininning()
                                losingState = viewModel.detectLosing()
                                

                            }
                        }, label: {
                            Text("Done")
                                .font(.system(size: 15, weight: .heavy))

                        })
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                        .background(Color("ColorButton"))
                        .foregroundColor(Color("ColorWhite"))
                        .clipShape(RoundedRectangle(cornerRadius: 15))

                    } else {
                        if (viewModel.results.count != 1) {
                            Button( action: {
                            
                                flipAll()
                                
                            }, label: {
                                Text("Skip")
                                    .font(.system(size: 15, weight: .heavy))

                            })
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                            .background(Color("ColorButton"))
                            .foregroundColor(Color("ColorWhite"))
                            .clipShape(RoundedRectangle(cornerRadius: 15))

                        }
                        
                    }

                }
                
            }
            
        }
        
    }
}

//struct ResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = AKHeadhuntingGame()
//        ResultView(viewModel: game, hiddenCounter: .constant(0))
//    }
//}
