//
//  GameView.swift
//  ArknightsGachaSim
//
//  Created by Huu Tri on 13/08/2022.
//

import SwiftUI

struct GameView: View {
    
    @ObservedObject var viewModel: AKHeadhuntingGame
    
    @State var showRosterView = false
    @State var showShopView = false
    
    @State var hiddenCounter = 0
    
    @State private var showResult = false

    
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
    
    @SwiftUI.Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    HStack{
                        
                        NumberDisplayView(viewModel: viewModel, itemType: "Headhunt Ticket")
                        
                        NumberDisplayView(viewModel: viewModel, itemType: "Green Ticket")

                        NumberDisplayView(viewModel: viewModel, itemType: "Gold Ticket")

//                        HStack {
//                            Image("green-ticket")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 25)
//                            Text(": \(viewModel.greenTicket)")
//                                .font(.system(size: 10, weight: .heavy))
//
//                        }.padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
//                        .overlay(RoundedRectangle(cornerRadius: 15)
//                            .stroke(.gray, lineWidth: 2)
//                            .frame(width: 70))
//
//                        HStack {
//                            Image("gold-ticket")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 25)
//                            Text(": \(viewModel.goldTicket)")
//                                .font(.system(size: 10, weight: .heavy))
//
//                        }.padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
//                            .overlay(RoundedRectangle(cornerRadius: 15)
//                                .stroke(.gray, lineWidth: 2)
//                                .frame(width: 70))
                        
//                        Text("Spark shop: \(viewModel.sparkShop.count)")
                        
//                        if (viewModel.offerCounter > 0) {
//                            Text("(Once Only Offer) Guarantee a 5* or higher in: \(viewModel.offerCounter) pull(s)")
//                                .font(.system(size: 10, weight: .heavy))
//                        }
                        
//                        Text("Hidden Count: \(hiddenCounter)")
                                                            
                    }.padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                    
                    HStack{
                        Button{
                            hiddenCounter = 1;
                            viewModel.oneTimeRoll()
                            self.showResult = true
                        } label: {
                            Text("Use ")
                                .font(.system(size: 15, weight: .heavy))
                            Image("x1-headhunt")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25)

                        }
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                        .background(.blue)
                        .foregroundColor(.white)
                        .disabled(viewModel.headhuntTicket == 0)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .sheet(isPresented: self.$showResult) {
                                ResultView(viewModel: viewModel, hiddenCounter: $hiddenCounter)
                            }

                        
                        Button{
                            hiddenCounter = 10;
                            viewModel.tenTimesRoll()
                            self.showResult = true
                            
                        } label: {
                            Text("Use ")
                                .font(.system(size: 15, weight: .heavy))
                            Image("x10-headhunt")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25)

                        }
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                        .background(.blue)
                        .foregroundColor(.white)
                        .disabled(viewModel.headhuntTicket < 10)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .sheet(isPresented: self.$showResult) {
                                ResultView(viewModel: viewModel, hiddenCounter: $hiddenCounter)
                            }

                        
                        Button( action: {
                            self.showRosterView.toggle()
                        }, label: {
                            Text("Roster")
                                .font(.system(size: 15, weight: .heavy))

                        })
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .sheet(isPresented: $showRosterView) {
                            RosterView(isShowing: $showRosterView, game: viewModel)
                        }
                        
                        Button( action: {
                            self.showShopView.toggle()
                        }, label: {
                            Text("Shop")
                                .frame(width: 125, height: 25)

                        })
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .sheet(isPresented: $showShopView) {
                            ShopView(isShowing: $showShopView, game: viewModel)
                        }
                        
                        if (viewModel.results.count > 0) {
                            Button{ viewModel.reset() } label: {
                                Text("Reset")
                            }
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                            .background(.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        }


                    }
                    
                    HStack {
                                                


                    }
                                        
                    VStack {
                        Text("Banner Details")
                            .padding()
                        
                        Text("Appearance Rate Up:")
                            .frame(alignment: .leading)
                        
                        if (viewModel.bannerType == "Standard") {
                            
                        Text("6* - Accounts for 50% of the odds when pulling a 6*")
                        } else {
                            Text("6* - Accounts for 70% of the odds when pulling a 6*")

                        }
                        HStack {
                            ForEach(0..<viewModel.sixStarRateup.count, id: \.self) {
                                i in
                                Image(viewModel.sixStarRateup[i].image.profile)
                            }
                        }
                        
                        if (viewModel.offChanceRateup.count > 0) {
                            
                            Text("Off Chance 6* - 5 times the weight of the rest of 6*")
                            
                            HStack {
                                ForEach(0..<viewModel.offChanceRateup.count, id: \.self) {
                                    i in
                                    Image(viewModel.offChanceRateup[i].image.profile)
                                }
                            }
                        }
                        Text("5* - Accounts for 50% of the odds when pulling a 5*")
                        HStack {
                            ForEach(0..<viewModel.fiveStarRateup.count, id: \.self) {
                                i in
                                Image(viewModel.fiveStarRateup[i].image.profile)
                            }
                        }

                    }
                }.frame(width: UIScreen.main.bounds.width)
                
            }
            
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear {
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation") // Forcing the rotation to portrait
            AppDelegate.orientationLock = .landscape // And making sure it stays that way
        }.onDisappear {
            AppDelegate.orientationLock = .all // Unlocking the rotation when leaving the view
        }
    }
            

}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = AKHeadhuntingGame()
        GameView(viewModel: game)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}


