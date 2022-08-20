//
//  ResultView.swift
//  ArknightsGachaSim
//
//  Created by Huu Tri on 19/08/2022.
//

import SwiftUI

struct ResultView: View {
    
    @ObservedObject var viewModel: AKHeadhuntingGame

    @Binding var hiddenCounter: Int
    
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
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Done")
                            .font(.system(size: 15, weight: .heavy))

                    })
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))

                } else {
                    Button( action: {
                        flipAll()
                        
                    }, label: {
                        Text("Skip")
                            .font(.system(size: 15, weight: .heavy))

                    })
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))

                }

            }
            
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        let game = AKHeadhuntingGame()
        ResultView(viewModel: game, hiddenCounter: .constant(0))
    }
}
