//
//  GameSetupView.swift
//  ArknightsGachaSim
//
//  Created by Huu Tri on 18/08/2022.
//

import SwiftUI

struct GameSetupView: View {
    
    @ObservedObject var viewModel: AKHeadhuntingGame
    
    @State var searchInput = ""
    
    @State var isGameViewShowing = false
    
    @State var setupPhase = 1.0
    @State var setupPhaseLimited = 1.0
    
    @State var gameMode = ""
    @State var bannerType = ""
    
    @State var sixStarSelections = Array<Operator>()
    @State var fiveStarSelections = Array<Operator>()
    @State var offChanceSelections = Array<Operator>()
    
    var filteredList: [Operator] {
        if searchInput == "" {
            if (setupPhase == 3.0) {
                return sixStarPool

            } else if (setupPhase == 3.0 && bannerType == "Limited") {
                return limitedPool
            } else if (setupPhase == 3.0 && setupPhaseLimited == 2.0 ) {
                return sixStarPool

            } else {
                return fiveStarPool
            }
        }
        
        if (setupPhase == 3.0) {
            return sixStarPool.filter{
                $0.name.lowercased().contains(searchInput.lowercased())
            }
        } else if (setupPhase == 3.0 && bannerType == "Limited") {
            return limitedPool.filter{
                $0.name.lowercased().contains(searchInput.lowercased())
            }
            
        } else if (setupPhase == 3.0 && setupPhaseLimited == 2.0 ) {
            return sixStarPool.filter{
                $0.name.lowercased().contains(searchInput.lowercased())
            }

        } else {
            return fiveStarPool.filter{
                $0.name.lowercased().contains(searchInput.lowercased())
            }
            
        }
    }
    
    
    //MARK: - GET INDEX
    func index(of character: Operator, array: Array<Operator>) -> Int {
        for index in 0..<array.count {
            if array[index].id == character.id {
                return index
            }
        }
        
        return 0
    }
    
    //MARK: - SETUP NEW GAME
    func gameSetup() {
        viewModel.gameSetup(mode: gameMode, type: bannerType, sixStarRateup: sixStarSelections, fiveStarRateup: fiveStarSelections, offChanceRateup: offChanceSelections)
    }
    
    //MARK: - RESET
    func reset() {
        setupPhase = 1.0
        setupPhaseLimited = 1.0
        
        gameMode = ""
        bannerType = ""
        
        sixStarSelections.removeAll()
        fiveStarSelections.removeAll()
        offChanceSelections.removeAll()
    }
    
    //MARK: - SET UP PHASE LOGIC
    func managePhase(phase: Double) -> String {
        if (phase == 1.0) {
            return "Select Game Mode"
        } else if (phase == 2.0) {
            return "Select Banner Type"
        } else if (phase == 3.0) {
            return "Select 6* Rate Up Units (Can select up to 3)"
        } else if (phase == 4.0){
            return "Select 5* Rate Up Units (Can select up to 3)"
        } else {
            return "Finalize"
        }
    }
    
    func managePhaseLimited(phase: Double) -> String {
        if (phase == 1.0) {
            return "Select Limited 6* Unit (Can select up to 3)"
        } else if (phase == 2.0) {
            return "Select Standard 6* Unit (Can select up to 3)"
        } else {
            return "Select Off Chance Limited Units (Can select up to 5 or leave empty)"
        }
    }
    
    func nextPhase() {
        searchInput = ""
        if (setupPhase < 5.0) {
            setupPhase += 1.0
        }
    }
    
    func nextPhaseLimited() {
        searchInput = ""
        if (setupPhaseLimited < 3.0) {
            setupPhaseLimited += 1.0
        }
    }
    
    //MARK: - VIEW
    var body: some View {
        NavigationView{
            ZStack {
                VStack {
                    
                    ProgressView(managePhase(phase: setupPhase), value: setupPhase, total: 5)
                    
                    Spacer()
                    
                                        
                    if (setupPhase == 1.0) {
                        VStack {
                            
                            Button{ gameMode = "Challange"; nextPhase() } label: {
                                Text("CHALLENGE")
                                    .frame(width: 200, height: 50)
                                
                            }
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                            .background(.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                            Button{ gameMode = "Freestyle"; nextPhase() } label: {
                                Text("FREESTYLE")
                                    .frame(width: 200, height: 50)
                                
                            }
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                            .background(.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                        }
                        //                    Button { nextPhase() } label: {
                        //                        Text("Phase 2")
                        //                    }
                    } else if (setupPhase == 2.0) {
                        
                        VStack {
                            Button{ bannerType = "Limited"; nextPhase() } label: {
                                Text("LIMITED")
                                    .frame(width: 200, height: 50)
                                
                            }
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                            .background(.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                            Button{ bannerType = "Standard"; nextPhase() } label: {
                                Text("STANDARD")
                                    .frame(width: 200, height: 50)
                                
                            }
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                            .background(.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                        }
                        
                        
                        //                    Button { nextPhase() } label: {
                        //                        Text("Phase 3")
                        //                    }
                    } else if (setupPhase == 3.0) {
                        
                        HStack {
                            
                            if (bannerType == "Standard") {
                                VStack {
                                    HStack {
                                        Text("Chosen: ")
                                        ForEach(sixStarSelections) {
                                            op in
                                            Image(op.image.profile)
                                        }
                                    }.frame(width: 400)
                                    HStack {
                                        List(sixStarPool) {
                                            op in
                                            HStack {
                                                Image(systemName: sixStarSelections.contains(where: { $0.name == op.name }) ? "checkmark.square" : "square")
                                                Image(op.image.profile)
                                                Text(op.name)
                                            }.onTapGesture {
                                                if (sixStarSelections.count <= 3) {
                                                    if (sixStarSelections.contains(where: { $0.name == op.name })) {
                                                        
                                                        let index = index(of: op, array: sixStarSelections)
                                                        
                                                        sixStarSelections.remove(at: index)
                                                        
                                                        
                                                    } else {
                                                        if (sixStarSelections.count < 3) {
                                                            sixStarSelections.append(op)
                                                            
                                                        }
                                                    }
                                                    
                                                }
                                            }
                                            
                                        }.searchable(text: $searchInput)
                                        
                                        if (sixStarSelections.count == 0) {
                                            Button { nextPhase() } label: {
                                                Text("NEXT")
                                            }.disabled(true)
                                            
                                        } else {
                                            Button { nextPhase() } label: {
                                                Text("NEXT")
                                            }.disabled(false)
                                            
                                        }
                                        
                                    }
                                }
                                
                                
                                
                                //MARK: - VIEW: LIMITED SETP UP
                            } else {
                                
                                VStack {
                                    ProgressView(managePhaseLimited(phase: setupPhaseLimited), value: setupPhaseLimited, total: 4)
                                    
                                    if (setupPhaseLimited == 1.0) {
                                        VStack {
                                            HStack {
                                                Text("Chosen: ")
                                                ForEach(sixStarSelections) {
                                                    op in
                                                    Image(op.image.profile)
                                                }
                                            }.frame(width: 400)
                                            HStack {
                                                List(0..<limitedPool.count, id: \.self) {
                                                    i in
                                                    HStack {
                                                        Image(systemName: sixStarSelections.contains(where: { $0.name == limitedPool[i].name }) ? "checkmark.square" : "square")
                                                        Image(limitedPool[i].image.profile)
                                                        Text(limitedPool[i].name)
                                                    }.onTapGesture {
                                                        if (sixStarSelections.count <= 3) {
                                                            if (sixStarSelections.contains(where: { $0.name == limitedPool[i].name })) {
                                                                
                                                                let index = index(of: limitedPool[i], array: sixStarSelections)
                                                                
                                                                sixStarSelections.remove(at: index)
                                                                
                                                                
                                                            } else {
                                                                if (sixStarSelections.count < 3) {
                                                                    sixStarSelections.append(limitedPool[i])
                                                                    
                                                                }
                                                            }
                                                            
                                                        }
                                                    }
                                                    
                                                }.searchable(text: $searchInput)

                                                
                                                if (sixStarSelections.count == 0) {
                                                    Button { nextPhaseLimited() } label: {
                                                        Text("NEXT")
                                                    }.disabled(true)
                                                    
                                                } else {
                                                    Button { nextPhaseLimited() } label: {
                                                        Text("NEXT")
                                                    }.disabled(false)
                                                    
                                                }
                                                
                                            }
                                        }
                                        
                                    } else if (setupPhaseLimited == 2.0) {
                                        VStack {
                                            HStack {
                                                Text("Chosen: ")
                                                ForEach(sixStarSelections) {
                                                    op in
                                                    Image(op.image.profile)
                                                }
                                            }.frame(width: 400)
                                            HStack {
                                                List(0..<sixStarPool.count, id: \.self) {
                                                    i in
                                                    HStack {
                                                        Image(systemName: sixStarSelections.contains(where: { $0.name == sixStarPool[i].name }) ? "checkmark.square" : "square")
                                                        Image(sixStarPool[i].image.profile)
                                                        Text(sixStarPool[i].name)
                                                    }.onTapGesture {
                                                        if (sixStarSelections.count <= 3) {
                                                            if (sixStarSelections.contains(where: { $0.name == sixStarPool[i].name })) {
                                                                
                                                                let index = index(of: sixStarPool[i], array: sixStarSelections)
                                                                
                                                                sixStarSelections.remove(at: index)
                                                                
                                                                
                                                            } else {
                                                                if (sixStarSelections.count < 3) {
                                                                    sixStarSelections.append(sixStarPool[i])
                                                                    
                                                                }
                                                            }
                                                            
                                                        }
                                                    }
                                                    
                                                }.searchable(text: $searchInput)

                                                
                                                if (sixStarSelections.count == 0) {
                                                    Button { nextPhaseLimited() } label: {
                                                        Text("NEXT")
                                                    }.disabled(true)
                                                    
                                                } else {
                                                    Button { nextPhaseLimited() } label: {
                                                        Text("NEXT")
                                                    }.disabled(false)
                                                    
                                                }
                                                
                                            }
                                        }
                                        
                                    } else {
                                        VStack {
                                            HStack {
                                                Text("Chosen: ")
                                                ForEach(offChanceSelections) {
                                                    op in
                                                    Image(op.image.profile)
                                                }
                                            }.frame(width: 400)
                                            HStack {
                                                List(limitedPool.filter{ item in !sixStarSelections.contains(where: { $0.name == item.name }) } ) {
                                                    op in
                                                    HStack {
                                                        Image(systemName: offChanceSelections.contains(where: { $0.name == op.name }) ? "checkmark.square" : "square")
                                                        Image(op.image.profile)
                                                        Text(op.name)
                                                    }.onTapGesture {
                                                        if (offChanceSelections.count <= 5) {
                                                            if (offChanceSelections.contains(where: { $0.name == op.name })) {
                                                                
                                                                let index = index(of: op, array: offChanceSelections)
                                                                
                                                                offChanceSelections.remove(at: index)
                                                                
                                                                
                                                            } else {
                                                                if (offChanceSelections.count < 5) {
                                                                    offChanceSelections.append(op)
                                                                    
                                                                }
                                                            }
                                                            
                                                        }
                                                    }
                                                    
                                                }.searchable(text: $searchInput)

                                                
                                                Button { nextPhase() } label: {
                                                    Text("NEXT")
                                                }.disabled(false)
                                                
                                                
                                            }
                                        }
                                    }
                                    
                                }
                                
                            }
                            
                            
                            
                        }
                        
                        
                    } else if (setupPhase == 4) {
                        
                        VStack {
                            HStack {
                                Text("Chosen: ")
                                ForEach(fiveStarSelections) {
                                    op in
                                    Image(op.image.profile)
                                }
                            }.frame(width: 400)
                            HStack {
                                List(fiveStarPool) {
                                    op in
                                    HStack {
                                        Image(systemName: fiveStarSelections.contains(where: { $0.name == op.name }) ? "checkmark.square" : "square")
                                        Image(op.image.profile)
                                        Text(op.name)
                                    }.onTapGesture {
                                        if (fiveStarSelections.count <= 3) {
                                            if (fiveStarSelections.contains(where: { $0.name == op.name })) {
                                                
                                                let index = index(of: op, array: fiveStarSelections)
                                                
                                                fiveStarSelections.remove(at: index)
                                                
                                                
                                            } else {
                                                if (fiveStarSelections.count < 3) {
                                                    fiveStarSelections.append(op)
                                                    
                                                }
                                            }
                                            
                                        }
                                    }
                                    
                                }.searchable(text: $searchInput)

                                
                                if (fiveStarSelections.count == 0) {
                                    Button { nextPhase() } label: {
                                        Text("NEXT")
                                    }.disabled(true)
                                    
                                } else {
                                    Button { gameSetup(); nextPhase() } label: {
                                        Text("NEXT")
                                    }.disabled(false)
                                    
                                }
                                
                            }
                        }
                        
                    } else {
                        
                        ScrollView {
                            VStack {
                                Text("Are you sure you want to start new game with this setup?")
                                    .padding()
                                
                                Text("Game Mode")
                                Text(gameMode)
                                    .foregroundColor(.blue)
                                    .padding()
                                
                                Text("Banner Type")
                                Text(bannerType)
                                    .foregroundColor(.blue)
                                    .padding()
                                
                                if (bannerType == "Standard") {
                                    Text("6* Character Pool")
                                    
                                    HStack {
                                        ForEach(sixStarSelections) {
                                            op in
                                            Image(op.image.profile)
                                        }
                                    }.padding()
                                    Text("5* Character Pool")
                                    
                                    HStack {
                                        ForEach(fiveStarSelections) {
                                            op in
                                            Image(op.image.profile)
                                        }
                                    }.padding()
                                } else {
                                    Text("6* Character Pool")
                                    
                                    HStack {
                                        ForEach(sixStarSelections) {
                                            op in
                                            Image(op.image.profile)
                                        }
                                    }.padding()
                                    Text("6* Off Chance Character Pool")
                                    
                                    HStack {
                                        if (offChanceSelections.count == 0) {
                                            Text("None")
                                        } else {
                                            ForEach(offChanceSelections) {
                                                op in
                                                Image(op.image.profile)
                                            }
                                            
                                        }
                                        
                                    }.padding()
                                    
                                    Text("5* Character Pool")
                                    
                                    HStack {
                                        ForEach(fiveStarSelections) {
                                            op in
                                            Image(op.image.profile)
                                        }
                                    }.padding()
                                    
                                }
                                
                                HStack{
                                    Button{ reset() } label: {
                                        Text("RESET CURRENT SETUP")
                                            .frame(width: 200, height: 50)
                                        
                                    }
                                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                                    .background(.blue)
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    
                                    NavigationLink(destination: GameView(viewModel: viewModel)) {
                                        Text("START GAME")
                                            .frame(width: 200, height: 50)
                                        
                                        
                                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                                            .background(.blue)
                                            .foregroundColor(.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                        
                                    }
                                                                        
                                }
                                
                                
                                
                            }
                            
                        }
                        
                    }
                    
                    Spacer()
                    
                }.padding()
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct GameSetupView_Previews: PreviewProvider {
    static var previews: some View {
        let game = AKHeadhuntingGame()
        GameSetupView(viewModel: game)
            .previewInterfaceOrientation(.portrait)
    }
}
