
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Ngo Huu Tri
  ID: 3818520
  Created  date: 13/08/2022
  Last modified: 26/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct RosterView: View {
    
    @Binding var isShowing: Bool
    
    @State var showInfoRosterView = false
    
    @State var filterMode = "Acq"
    
    @State var filterOrder = "Asc"
    
    @ObservedObject var game: AKHeadhuntingGame
    
        
    let rows: [GridItem] = [
        GridItem(.flexible(), spacing: 10, alignment: nil),
        GridItem(.flexible(), spacing: 10, alignment: nil),
    ]

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button{ playSoundEffect(sound: "ClickAudio", type: "mp3"); self.showInfoRosterView.toggle() } label: {
                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)

                    }
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    .foregroundColor(Color("ColorButton"))
                    .sheet(isPresented: $showInfoRosterView) {
                        InfoRosterView(isShowing: $showInfoRosterView)
                    }

                    
                    Text("Filter: ")
                    
                    HStack {
                        if (filterMode == "Rarity") {
                            Text("Rarity ")
                                .font(.system(size: 15, weight: .heavy , design: .monospaced))
                                .foregroundColor(Color("ColorButton"))

                            if (filterOrder == "Asc") {
                                Image(systemName: "chevron.up")
                                    .foregroundColor(Color("ColorButton"))


                            } else if (filterOrder == "Des") {
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color("ColorButton"))

                            }
                            
                        } else {
                            Text("Rarity ")
                                .font(.system(size: 15, weight: .medium , design: .monospaced))
                                .foregroundColor(.white)
                                .opacity(0.6)
                            Image(systemName: "chevron.up")
                                .foregroundColor(.white)
                                .opacity(0.6)
                            
                        }
                    }.padding(.all, 5)
                    .background(
                        Rectangle().fill(.black)
                    )
                    .onTapGesture {
                        playSoundEffect(sound: "ClickAudio2", type: "mp3")
                        if (filterMode == "Rarity") {

                            if (filterOrder == "Asc") {
                                filterOrder = "Des"
                                
                                game.resetRosterOrder()

                                game.sortRoster(by: filterMode, order: filterOrder)


                            } else {
                                filterOrder = "Asc"
                                
                                game.resetRosterOrder()

                                game.sortRoster(by: filterMode, order: filterOrder)


                            }
                        } else {

                            filterMode = "Rarity"
                            filterOrder = "Des"
                            
                            game.resetRosterOrder()

                            game.sortRoster(by: filterMode, order: filterOrder)

                        }

                    }
                    
                    HStack {
                        if (filterMode == "Name") {
                            Text("Name ")
                                .font(.system(size: 15, weight: .heavy , design: .monospaced))
                                .foregroundColor(Color("ColorButton"))

                            if (filterOrder == "Asc") {
                                Image(systemName: "chevron.up")
                                    .foregroundColor(Color("ColorButton"))


                            } else if (filterOrder == "Des") {
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color("ColorButton"))

                            }
                            
                        } else {
                            Text("Name ")
                                .font(.system(size: 15, weight: .medium , design: .monospaced))
                                .foregroundColor(.white)
                                .opacity(0.6)
                            Image(systemName: "chevron.up")
                                .foregroundColor(.white)
                                .opacity(0.6)
                            
                        }
                    }.padding(.all, 5)
                    .background(
                        Rectangle().fill(.black)
                    )
                    .onTapGesture {
                        playSoundEffect(sound: "ClickAudio2", type: "mp3")
                        if (filterMode == "Name") {

                            if (filterOrder == "Asc") {
                                filterOrder = "Des"
                                game.resetRosterOrder()
                                game.sortRoster(by: filterMode, order: filterOrder)


                            } else {
                                filterOrder = "Asc"
                                game.resetRosterOrder()

                                game.sortRoster(by: filterMode, order: filterOrder)

                            }
                        } else {
                            
                            filterMode = "Name"
                            filterOrder = "Des"
                            
                            game.resetRosterOrder()
                            game.sortRoster(by: filterMode, order: filterOrder)
                        }

                    }


                    Spacer()
                    
                    Button {
                        isShowing = false
                    } label: {
                        Image(systemName: "x.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .foregroundColor(Color("ColorButton"))
                        
                    }

                }.padding(.top, 10)
                ScrollView(.horizontal){
                    
                    HStack {
                        LazyHGrid(rows: rows, alignment: .center, spacing: 10, pinnedViews: [], content: {
                            ForEach(game.rosters) {
                                chara in
                                RosterCardView(character: chara)
                                    .frame(width: 50)
                                    .padding()
                                
                            }
                        })

                    }.frame(height: UIScreen.main.bounds.height-70)
                }

                
            }
                                    
        }
    }
}

//struct RosterView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = AKHeadhuntingGame()
//            RosterView(isShowing: showing ,game: game)
//    }
//}
