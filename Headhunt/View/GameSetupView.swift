
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Ngo Huu Tri
  ID: 3818520
  Created  date: 18/08/2022
  Last modified: 27/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct GameSetupView: View {
    
    @ObservedObject var viewModel: AKHeadhuntingGame
    
    @Environment(\.scenePhase) var scenePhase

    
    @Binding var shouldGoToRootSetUp: Bool
    
    @State private var username: String = ""
    
    @State var searchInput = ""
        
    @State var setupPhase = 1.0
    @State var setupPhaseLimited = 1.0
    
    @State var gameMode = ""
    @State var bannerType = ""
    
    @State var sixStarSelections = Array<Operator>()
    @State var fiveStarSelections = Array<Operator>()
    @State var offChanceSelections = Array<Operator>()
    
    @State var numberOfSixStar = 0
    
    var gameDifficulty = UserDefaults.standard.string(forKey: "Difficulty") ?? "Free To Play"
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 5, alignment: nil),
        GridItem(.flexible(), spacing: 5, alignment: nil),
        GridItem(.flexible(), spacing: 5, alignment: nil),
        GridItem(.flexible(), spacing: 5, alignment: nil),
        GridItem(.flexible(), spacing: 5, alignment: nil),
        GridItem(.flexible(), spacing: 5, alignment: nil),
    ]
    
    
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
        viewModel.gameSetup(username: username, mode: gameMode, type: bannerType, difficulty: gameDifficulty, sixStarRateup: sixStarSelections, fiveStarRateup: fiveStarSelections, offChanceRateup: offChanceSelections)
    }
    
    //MARK: - RESET CURRENT SET UP
    func resetSetup() {
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
            return "Initial Set Up"
        } else if (phase == 2.0) {
            
            return "Select for 6* Rate Up Pool (Maximum of 2)"
        } else if (phase == 3.0) {
            return "Select for 5* Rate Up Pool (Maximum of 3)"
        } else {
            return "Finalizing"
        }
    }
    
    func managePhaseLimited(phase: Double) -> String {
        if (phase == 1.0) {
            return "Select Limited 6* Unit (Can only select 1)"
        } else if (phase == 2.0) {
            return "Select Standard 6* Unit (Can only select 1)"
        } else {
            return "Select Off Chance Limited Units (Can select up to 5 or leave empty)"
        }
    }
    
    //Move to previous set up phase
    func previousPhase() {
        if (setupPhase > 1.0 ) {
            setupPhase -= 1.0
        }
    }
    
    func previousPhaseLimited() {
        if (setupPhaseLimited > 1.0 ) {
            setupPhaseLimited -= 1.0
        }
    }
    
    
    
    //Move to next set up phase
    func nextPhase() {
        if (setupPhase < 4.0) {
            setupPhase += 1.0
        }
    }
    
    func nextPhaseLimited() {
        if (setupPhaseLimited < 3.0) {
            setupPhaseLimited += 1.0
        }
    }
    
    //MARK: - VIEW
    var body: some View {
        //        NavigationView{
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("ColorWhite"), Color("ColorHeadhunt")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)

            VStack {
                
                ProgressView(managePhase(phase: setupPhase), value: setupPhase, total: 4)
                
                Spacer()
                
                
                if (setupPhase == 1.0) {
                    
                    VStack{
                        
                        ScrollView{
                            VStack(alignment: .leading){
                                Text("Enter your name")
                                    .frame(alignment: .leading)
                                    .padding(.all, 10)
                                TextField(
                                    username == "" ? "What do you want to call yourself?..." : username,
                                    text: $username
                                )
                                .padding(.all, 10)
                                .disableAutocorrection(true)
                                
                                Text("Choose your game mode")
                                    .frame(alignment: .leading)
                                    .padding(.all, 10)
                                HStack{
                                    Image(systemName: gameMode == "Challenge" ? "checkmark.circle" : "circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                        .padding()
                                    
                                    VStack(alignment: .leading){
                                        Text("CHALLENGE")
                                            .font(.system(size: 20, weight: .heavy))
                                            .font(.system(.title, design: .rounded))
                                        
                                        Text("Start with limited rolls, complete the challange based on difficulty to win")
                                            .font(.system(size: 12))
                                    }.frame(width: 400, height: 80)
                                }
                                .frame(width: UIScreen.main.bounds.width-90)
                                .overlay(RoundedRectangle(cornerRadius: 8)
                                    .stroke(.brown, lineWidth: 3))
                                .padding(.all, 10)
                                .onTapGesture{
                                    if (gameMode == "Freestyle" || gameMode == "") {
                                        playSoundEffect(sound: "ClickAudio", type: "mp3")
                                        gameMode = "Challenge"
                                    }
                                    
                                }
                                
                                HStack{
                                    Image(systemName: gameMode == "Freestyle" ? "checkmark.circle" : "circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                        .padding()
                                    
                                    VStack(alignment: .leading){
                                        Text("FREESTYLE")
                                            .font(.system(size: 20, weight: .heavy))
                                            .font(.system(.title, design: .rounded))
                                        
                                        Text("Start with unlimited rolls. Play to heart's content without worrying about losing or winning. However, your game will not be saved upon leaving.")
                                            .font(.system(size: 12))
                                        
                                    }
                                    .frame(width: 400, height: 80)
                                    
                                    
                                }
                                .frame(width: UIScreen.main.bounds.width-90)
                                .overlay(RoundedRectangle(cornerRadius: 8)
                                    .stroke(.brown, lineWidth: 3))
                                .padding(.all, 10)
                                .onTapGesture{
                                    if (gameMode == "Challenge" || gameMode == "") {
                                        playSoundEffect(sound: "ClickAudio", type: "mp3")
                                        gameMode = "Freestyle"
                                    }
                                }
                                
                                Text("Choose your banner type")
                                    .frame(alignment: .leading)
                                    .padding(.all, 10)
                                HStack{
                                    Image(systemName: bannerType == "Limited" ? "checkmark.circle" : "circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                        .padding()
                                    
                                    VStack(alignment: .leading){
                                        Text("LIMITED")
                                            .font(.system(size: 20, weight: .heavy))
                                            .font(.system(.title, design: .rounded))
                                        
                                        Text("Rate up units are more difficult to obtain. Start with +50 rolls")
                                            .font(.system(size: 12))
                                    }.frame(width: 400, height: 80)
                                }
                                .frame(width: UIScreen.main.bounds.width-90)
                                .overlay(RoundedRectangle(cornerRadius: 8)
                                    .stroke(.brown, lineWidth: 3))
                                .padding(.all, 10)
                                .onTapGesture{
                                    if (bannerType == "Standard" || bannerType == "") {
                                        playSoundEffect(sound: "ClickAudio", type: "mp3")
                                        bannerType = "Limited"
                                    }
                                    
                                }
                                
                                HStack{
                                    Image(systemName: bannerType == "Standard" ? "checkmark.circle" : "circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                        .padding()
                                    
                                    VStack(alignment: .leading){
                                        Text("STANDARD")
                                            .font(.system(size: 20, weight: .heavy))
                                            .font(.system(.title, design: .rounded))
                                        
                                        Text("Rate up units have 50% chance to obtain")
                                            .font(.system(size: 12))
                                        
                                    }
                                    .frame(width: 400, height: 80)
                                    
                                    
                                }
                                .frame(width: UIScreen.main.bounds.width-90)
                                .overlay(RoundedRectangle(cornerRadius: 8)
                                    .stroke(.brown, lineWidth: 3))
                                .padding(.all, 10)
                                .onTapGesture{
                                    if (bannerType == "Limited" || bannerType == "") {
                                        playSoundEffect(sound: "ClickAudio", type: "mp3")
                                        bannerType = "Standard"
                                    }
                                }
                                
                                
                                
                            }
                        }.frame(width: UIScreen.main.bounds.width-100)

                        
                        Spacer()
                        
                        HStack {
                            Button{ playSoundEffect(sound: "ClickAudio", type: "mp3"); nextPhase() } label: {
                                Text("NEXT")
                                    .font(.system(size: 20, weight: .heavy))
                                    .frame(width: 100, height: 25)
                                
                            }
                            .modifier(ButtonSetUpView())
                            .disabled(username == "")
                            .disabled(gameMode == "")
                            .disabled(bannerType == "")
                        }.frame(width: UIScreen.main.bounds.width-50)
                        
                        
                    }.textFieldStyle(.roundedBorder)
                    
                }  else if (setupPhase == 2.0) {
                    
                    HStack {
                        
                        if (bannerType == "Standard") {
                            VStack {
                                HStack {
                                    Text("Pool: ")
                                    ForEach(sixStarSelections) {
                                        op in
                                        Image(op.image.profile)
                                    }
                                }.padding(.horizontal, 5)
                                    .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center)
                                
                                VStack {
                                    
                                    ScrollView {
                                        VStack {
                                            LazyVGrid(columns: columns, alignment: .center, spacing: 5, pinnedViews: [], content: {
                                                
                                                ForEach(0..<sixStarPool.count, id: \.self) {
                                                    i in
                                                    
                                                    ZStack{
                                                        
                                                        Image(sixStarPool[i].image.tooltip)
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 70)
                                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                                        
                                                        ZStack {
                                                            VStack {
                                                                Spacer()
                                                                
                                                                Text(sixStarPool[i].name.uppercased())
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 8, weight: .heavy))
                                                                    .frame(width: 70)
                                                                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                                                    .background{
                                                                        RoundedRectangle(cornerRadius: 4)
                                                                            .foregroundColor(.black)
                                                                            .opacity(0.5)
                                                                    }
                                                                
                                                            }
                                                            
                                                        }.frame(height: 70*2)
                                                        
                                                        if (sixStarSelections.contains(where: { $0.name == sixStarPool[i].name })) {
                                                            
                                                            Color("ColorBackground")
                                                                .frame(width: 70, height: 140)
                                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                                            
                                                            
                                                            Image(systemName: "checkmark.circle")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .frame(width: 30)
                                                                .foregroundColor(.green)
                                                                .offset(x:15, y: 50)
                                                        }
                                                        
                                                        
                                                    }
                                                    .overlay(RoundedRectangle(cornerRadius: 8)
                                                        .stroke(sixStarSelections.contains(where: { $0.name == sixStarPool[i].name }) ? .green : .brown, lineWidth: 3))
                                                    .onTapGesture(perform: {
                                                        if (sixStarSelections.count <= 2) {
                                                            playSoundEffect(sound: "ClickAudio2", type: "mp3")
                                                            if (sixStarSelections.contains(where: { $0.name == sixStarPool[i].name })) {
                                                                
                                                                let index = index(of: sixStarPool[i], array: sixStarSelections)
                                                                
                                                                sixStarSelections.remove(at: index)
                                                                
                                                                
                                                            } else {
                                                                if (sixStarSelections.count < 2) {
                                                                    sixStarSelections.append(sixStarPool[i])
                                                                    
                                                                }
                                                            }
                                                            
                                                        }
                                                        
                                                    })
                                                    
                                                }
                                                
                                            })
                                        }
                                    }
                                    
                                    HStack {
                                        
                                        Button{ playSoundEffect(sound: "ClickAudio", type: "mp3"); sixStarSelections.removeAll(); offChanceSelections.removeAll(); fiveStarSelections.removeAll(); previousPhase() } label: {
                                            Text("PREVIOUS")
                                                .font(.system(size: 20, weight: .heavy))
                                                .frame(width: 150, height: 25)
                                            
                                        }
                                        .modifier(ButtonSetUpView())

                                        
                                        
                                        Button{ playSoundEffect(sound: "ClickAudio", type: "mp3"); nextPhase() } label: {
                                            Text("NEXT")
                                                .font(.system(size: 20, weight: .heavy))
                                                .frame(width: 100, height: 25)
                                            
                                        }
                                        .modifier(ButtonSetUpView())
                                        .disabled(sixStarSelections.count == 0)

                                    }
                                    
                                }
                            }
                            
                            
                            
                            //MARK: - VIEW: LIMITED SETP UP
                        } else {
                            
                            VStack {
                                ProgressView("Limited banner setup:  \(managePhaseLimited(phase: setupPhaseLimited))", value: setupPhaseLimited, total: 4)
                                
                                if (setupPhaseLimited == 1.0) {
                                    VStack {
                                        HStack {
                                            Text("Pool: ")
                                            ForEach(sixStarSelections) {
                                                op in
                                                Image(op.image.profile)
                                            }
                                        }.padding(.horizontal, 5)
                                            .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center)
                                        
                                        VStack {
                                            
                                            ScrollView {
                                                VStack {
                                                    LazyVGrid(columns: columns, alignment: .center, spacing: 5, pinnedViews: [], content: {
                                                        
                                                        ForEach(0..<limitedPool.count, id: \.self) {
                                                            i in
                                                            
                                                            ZStack{
                                                                
                                                                Image(limitedPool[i].image.tooltip)
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 70)
                                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                                                
                                                                ZStack {
                                                                    VStack {
                                                                        Spacer()
                                                                        
                                                                        Text(limitedPool[i].name.uppercased())
                                                                            .foregroundColor(.white)
                                                                            .font(.system(size: 8, weight: .heavy))
                                                                            .frame(width: 70)
                                                                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                                                            .background{
                                                                                RoundedRectangle(cornerRadius: 4)
                                                                                    .foregroundColor(.black)
                                                                                    .opacity(0.5)
                                                                            }
                                                                        
                                                                    }
                                                                    
                                                                }.frame(height: 70*2)
                                                                
                                                                if (sixStarSelections.contains(where: { $0.name == limitedPool[i].name })) {
                                                                    
                                                                    Color("ColorBackground")
                                                                        .frame(width: 70, height: 140)
                                                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                                                    
                                                                    
                                                                    Image(systemName: "checkmark.circle")
                                                                        .resizable()
                                                                        .scaledToFit()
                                                                        .frame(width: 30)
                                                                        .foregroundColor(.green)
                                                                        .offset(x:15, y: 50)
                                                                }
                                                                
                                                                
                                                            }
                                                            .overlay(RoundedRectangle(cornerRadius: 8)
                                                                .stroke(sixStarSelections.contains(where: { $0.name == sixStarPool[i].name }) ? .green : .brown, lineWidth: 3))
                                                            .onTapGesture(perform: {
                                                                if (sixStarSelections.count <= 1) {
                                                                    playSoundEffect(sound: "ClickAudio2", type: "mp3")
                                                                    if (sixStarSelections.contains(where: { $0.name == limitedPool[i].name })) {
                                                                        
                                                                        let index = index(of: limitedPool[i], array: sixStarSelections)
                                                                        
                                                                        sixStarSelections.remove(at: index)
                                                                        
                                                                        
                                                                    } else {
                                                                        if (sixStarSelections.count < 1) {
                                                                            sixStarSelections.append(limitedPool[i])
                                                                            
                                                                        }
                                                                    }
                                                                    
                                                                }
                                                                
                                                            })
                                                            
                                                        }
                                                        
                                                    })
                                                }
                                            }
                                            
                                            
                                            HStack {
                                                
                                                Button{ playSoundEffect(sound: "ClickAudio", type: "mp3"); sixStarSelections.removeAll(); offChanceSelections.removeAll(); fiveStarSelections.removeAll(); previousPhase(); previousPhase() } label: {
                                                    Text("PREVIOUS")
                                                        .font(.system(size: 20, weight: .heavy))
                                                        .frame(width: 150, height: 25)
                                                    
                                                }
                                                .modifier(ButtonSetUpView())

                                                
                                                
                                                Button{ playSoundEffect(sound: "ClickAudio", type: "mp3"); numberOfSixStar += 1 ;nextPhaseLimited() } label: {
                                                    Text("NEXT")
                                                        .font(.system(size: 20, weight: .heavy))
                                                        .frame(width: 100, height: 25)
                                                    
                                                }
                                                .modifier(ButtonSetUpView())
                                                .disabled(sixStarSelections.count == 0)
                                                
                                            }
                                            
                                        }
                                    }
                                    
                                } else if (setupPhaseLimited == 2.0) {
                                    VStack {
                                        HStack {
                                            Text("Pool: ")
                                            ForEach(sixStarSelections) {
                                                op in
                                                Image(op.image.profile)
                                            }
                                        }.padding(.horizontal, 5)
                                            .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center)
                                        
                                        VStack {
                                            
                                            ScrollView {
                                                VStack {
                                                    LazyVGrid(columns: columns, alignment: .center, spacing: 5, pinnedViews: [], content: {
                                                        
                                                        ForEach(0..<sixStarPool.count, id: \.self) {
                                                            i in
                                                            
                                                            ZStack{
                                                                
                                                                Image(sixStarPool[i].image.tooltip)
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 70)
                                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                                                
                                                                ZStack {
                                                                    VStack {
                                                                        Spacer()
                                                                        
                                                                        Text(sixStarPool[i].name.uppercased())
                                                                            .foregroundColor(.white)
                                                                            .font(.system(size: 8, weight: .heavy))
                                                                            .frame(width: 70)
                                                                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                                                            .background{
                                                                                RoundedRectangle(cornerRadius: 4)
                                                                                    .foregroundColor(.black)
                                                                                    .opacity(0.5)
                                                                            }
                                                                        
                                                                    }
                                                                    
                                                                }.frame(height: 70*2)
                                                                
                                                                if (sixStarSelections.contains(where: { $0.name == sixStarPool[i].name })) {
                                                                    
                                                                    Color("ColorBackground")
                                                                        .frame(width: 70, height: 140)
                                                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                                                    
                                                                    
                                                                    Image(systemName: "checkmark.circle")
                                                                        .resizable()
                                                                        .scaledToFit()
                                                                        .frame(width: 30)
                                                                        .foregroundColor(.green)
                                                                        .offset(x:15, y: 50)
                                                                }
                                                                
                                                                
                                                            }
                                                            .overlay(RoundedRectangle(cornerRadius: 8)
                                                                .stroke(sixStarSelections.contains(where: { $0.name == sixStarPool[i].name }) ? .green : .brown, lineWidth: 3))
                                                            .onTapGesture(perform: {
                                                                if (sixStarSelections.count <= 1+numberOfSixStar) {
                                                                    playSoundEffect(sound: "ClickAudio2", type: "mp3")
                                                                    if (sixStarSelections.contains(where: { $0.name == sixStarPool[i].name })) {
                                                                        
                                                                        let index = index(of: sixStarPool[i], array: sixStarSelections)
                                                                        
                                                                        sixStarSelections.remove(at: index)
                                                                        
                                                                        
                                                                    } else {
                                                                        if (sixStarSelections.count < 1+numberOfSixStar) {
                                                                            sixStarSelections.append(sixStarPool[i])
                                                                            
                                                                        }
                                                                    }
                                                                    
                                                                }
                                                                
                                                            })
                                                            
                                                        }
                                                        
                                                    })
                                                }
                                            }
                                            
                                            HStack{
                                                
                                                Button{ playSoundEffect(sound: "ClickAudio", type: "mp3"); previousPhaseLimited() } label: {
                                                    Text("PREVIOUS")
                                                        .font(.system(size: 20, weight: .heavy))
                                                        .frame(width: 150, height: 25)
                                                    
                                                }
                                                .modifier(ButtonSetUpView())

                                                
                                                
                                                Button{ playSoundEffect(sound: "ClickAudio", type: "mp3"); nextPhaseLimited() } label: {
                                                    Text("NEXT")
                                                        .font(.system(size: 20, weight: .heavy))
                                                        .frame(width: 100, height: 25)
                                                    
                                                }
                                                .modifier(ButtonSetUpView())
                                                .disabled(sixStarSelections.count == 0+numberOfSixStar)
                                            }
                                        }
                                    }
                                    
                                } else {
                                    VStack {
                                        HStack {
                                            Text("Pool: ")
                                            ForEach(offChanceSelections) {
                                                op in
                                                Image(op.image.profile)
                                            }
                                        }.padding(.horizontal, 5)
                                            .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center)
                                        
                                        VStack {
                                            
                                            ScrollView {
                                                VStack {
                                                    LazyVGrid(columns: columns, alignment: .center, spacing: 5, pinnedViews: [], content: {
                                                        
                                                        ForEach(limitedPool.filter{ item in !sixStarSelections.contains(where: { $0.name == item.name }) } ) {
                                                            op in
                                                            
                                                            ZStack{
                                                                
                                                                Image(op.image.tooltip)
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 70)
                                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                                                
                                                                ZStack {
                                                                    VStack {
                                                                        Spacer()
                                                                        
                                                                        Text(op.name.uppercased())
                                                                            .foregroundColor(.white)
                                                                            .font(.system(size: 8, weight: .heavy))
                                                                            .frame(width: 70)
                                                                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                                                            .background{
                                                                                RoundedRectangle(cornerRadius: 4)
                                                                                    .foregroundColor(.black)
                                                                                    .opacity(0.5)
                                                                            }
                                                                        
                                                                    }
                                                                    
                                                                }.frame(height: 70*2)
                                                                
                                                                if (offChanceSelections.contains(where: { $0.name == op.name })) {
                                                                    
                                                                    Color("ColorBackground")
                                                                        .frame(width: 70, height: 140)
                                                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                                                    
                                                                    
                                                                    Image(systemName: "checkmark.circle")
                                                                        .resizable()
                                                                        .scaledToFit()
                                                                        .frame(width: 30)
                                                                        .foregroundColor(.green)
                                                                        .offset(x:15, y: 50)
                                                                }
                                                                
                                                                
                                                            }
                                                            .overlay(RoundedRectangle(cornerRadius: 8)
                                                                .stroke(offChanceSelections.contains(where: { $0.name == op.name }) ? .green : .brown, lineWidth: 3))
                                                            .onTapGesture(perform: {
                                                                if (offChanceSelections.count <= 5) {
                                                                    playSoundEffect(sound: "ClickAudio2", type: "mp3")
                                                                    if (offChanceSelections.contains(where: { $0.name == op.name })) {
                                                                        
                                                                        let index = index(of: op, array: offChanceSelections)
                                                                        
                                                                        offChanceSelections.remove(at: index)
                                                                        
                                                                        
                                                                    } else {
                                                                        if (offChanceSelections.count < 5) {
                                                                            offChanceSelections.append(op)
                                                                            
                                                                        }
                                                                    }
                                                                    
                                                                }
                                                                
                                                            })
                                                            
                                                        }
                                                        
                                                    })
                                                }
                                            }
                                            
                                            HStack {
                                                
                                                Button{ playSoundEffect(sound: "ClickAudio", type: "mp3"); previousPhaseLimited() } label: {
                                                    Text("PREVIOUS")
                                                        .font(.system(size: 20, weight: .heavy))
                                                        .frame(width: 150, height: 25)
                                                    
                                                }
                                                .modifier(ButtonSetUpView())

                                                
                                                
                                                Button{ playSoundEffect(sound: "ClickAudio", type: "mp3"); nextPhase() } label: {
                                                    Text("NEXT")
                                                        .font(.system(size: 20, weight: .heavy))
                                                        .frame(width: 100, height: 25)
                                                    
                                                }
                                                .modifier(ButtonSetUpView())

                                            }
                                        }
                                    }
                                }
                                
                            }
                            
                        }
                        
                        
                        
                    }
                    
                    
                } else if (setupPhase == 3.0) {
                    
                    VStack {
                        HStack {
                            Text("Pool: ")
                            ForEach(fiveStarSelections) {
                                op in
                                Image(op.image.profile)
                            }
                        }.padding(.horizontal, 5)
                            .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center)
                        
                        
                        VStack {
                            
                            ScrollView {
                                VStack {
                                    LazyVGrid(columns: columns, alignment: .center, spacing: 5, pinnedViews: [], content: {
                                        
                                        ForEach(0..<fiveStarPool.count, id: \.self) {
                                            i in
                                            
                                            ZStack{
                                                
                                                Image(fiveStarPool[i].image.tooltip)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 70)
                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                                
                                                ZStack {
                                                    VStack {
                                                        Spacer()
                                                        
                                                        Text(fiveStarPool[i].name.uppercased())
                                                            .foregroundColor(.white)
                                                            .font(.system(size: 8, weight: .heavy))
                                                            .frame(width: 70)
                                                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                                            .background{
                                                                RoundedRectangle(cornerRadius: 4)
                                                                    .foregroundColor(.black)
                                                                    .opacity(0.5)
                                                            }
                                                        
                                                    }
                                                    
                                                }.frame(height: 70*2)
                                                
                                                if (fiveStarSelections.contains(where: { $0.name == fiveStarPool[i].name })) {
                                                    
                                                    Color("ColorBackground")
                                                        .frame(width: 70, height: 140)
                                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                                    
                                                    
                                                    Image(systemName: "checkmark.circle")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 30)
                                                        .foregroundColor(.green)
                                                        .offset(x:15, y: 50)
                                                }
                                                
                                                
                                            }
                                            .overlay(RoundedRectangle(cornerRadius: 8)
                                                .stroke(fiveStarSelections.contains(where: { $0.name == fiveStarPool[i].name }) ? .green : .brown, lineWidth: 3))
                                            .onTapGesture(perform: {
                                                if (fiveStarSelections.count <= 3) {
                                                    playSoundEffect(sound: "ClickAudio2", type: "mp3")
                                                    if (fiveStarSelections.contains(where: { $0.name == fiveStarPool[i].name })) {
                                                        
                                                        let index = index(of: fiveStarPool[i], array: fiveStarSelections)
                                                        
                                                        fiveStarSelections.remove(at: index)
                                                        
                                                        
                                                    } else {
                                                        if (fiveStarSelections.count < 3) {
                                                            fiveStarSelections.append(fiveStarPool[i])
                                                            
                                                        }
                                                    }
                                                    
                                                }
                                                
                                            })
                                            
                                        }
                                        
                                    })
                                }
                            }
                            
                            HStack {
                                Button{ playSoundEffect(sound: "ClickAudio", type: "mp3"); previousPhase() } label: {
                                    Text("PREVIOUS")
                                        .font(.system(size: 20, weight: .heavy))
                                        .frame(width: 150, height: 25)
                                    
                                }
                                .modifier(ButtonSetUpView())

                                Button{ playSoundEffect(sound: "ClickAudio", type: "mp3"); gameSetup() ;nextPhase() } label: {
                                    Text("NEXT")
                                        .font(.system(size: 20, weight: .heavy))
                                        .frame(width: 100, height: 25)
                                    
                                }
                                .modifier(ButtonSetUpView())
                                .disabled(fiveStarSelections.count == 0)
                                
                            }
                            
                        }
                    }
                    
                } else {
                    
                    ScrollView {
                        VStack {
                            
                            Text("Are you sure you want to start new game with this setup?")
                                .font(.system(size: 15, weight: .heavy))
                                .padding(.all, 5)
                                .multilineTextAlignment(.center)
                            
                            VStack{
                                HStack{
                                    VStack(alignment: .center){
                                        Text("Player")
                                        Text("-")
                                        Text("\(username)")
                                            .font(.system(size: 20, weight: .heavy))
                                            .padding(.all, 1)
                                        
                                    }.frame(width: 200)
                                    .padding(.horizontal, 20)
                                    
                                    VStack(alignment: .center){
                                        Text("Game Mode")
                                        Text("-")
                                        Text("\(gameMode)")
                                            .font(.system(size: 20, weight: .heavy))
                                            .padding(.all, 1)
                                        
                                    }.frame(width: 200)
                                    .padding(.horizontal, 20)

                                    
                                    VStack(alignment: .center){
                                        Text("Banner Type")
                                        Text("-")
                                        Text("\(bannerType)")
                                            .font(.system(size: 20, weight: .heavy))
                                            .padding(.all, 1)
                                        
                                    }.frame(width: 200)
                                    .padding(.horizontal, 20)


                                }
                                .padding(.vertical, 10)
                                
                                VStack{
                                    VStack(alignment: .center) {
                                        Text("6* Pool")
                                        
                                        HStack {
                                            ForEach(sixStarSelections) {
                                                op in
                                                Image(op.image.profile)
                                                    .background{
                                                        RoundedRectangle(cornerRadius: 8).fill(Color("ColorBlack"))
                                                            .opacity(0.5)
                                                    }
                                                    .clipShape(RoundedRectangle(cornerRadius: 8))


                                            }
                                        }.padding(.all, 2)
                                    }
                                    
                                    if (offChanceSelections.count > 0) {
                                        VStack(alignment: .center) {
                                                
                                            Text("6* Off Chance Pool")
                                                   
                                            HStack {
                                                ForEach(offChanceSelections) {
                                                    op in
                                                    Image(op.image.profile)
                                                        .background{
                                                            RoundedRectangle(cornerRadius: 8).fill(Color("ColorBlack"))
                                                                .opacity(0.5)
                                                        }
                                                        .clipShape(RoundedRectangle(cornerRadius: 8))


                                                }
                                            }.padding(.all, 2)
                                            
                                        }
                                    }
                                    
                                    VStack {
                                        Text("5* Pool")
                                        
                                        HStack(alignment: .center) {
                                            ForEach(fiveStarSelections) {
                                                op in
                                                Image(op.image.profile)
                                                    .background{
                                                        RoundedRectangle(cornerRadius: 8).fill(Color("ColorBlack"))
                                                            .opacity(0.5)
                                                    }
                                                    .clipShape(RoundedRectangle(cornerRadius: 8))


                                            }
                                        }.padding(.all, 2)

                                    }
                                    
                                    
                                }.padding(.vertical, 5)
                                
                                
                                
                            }.frame(width: UIScreen.main.bounds.width-150, alignment: .center)
                                .background{
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color("ColorBlack"), lineWidth: 2)
                                    .opacity(0.5)
                                    
                                }

                        }
                        
                        
                        
                    }
                    
                    HStack{
                        Button{ playSoundEffect(sound: "ClickAudio3", type: "mp3"); viewModel.resetGame(); resetSetup() } label: {
                            Text("RESET SETUP")
                                .font(.system(size: 20, weight: .heavy))
                                .frame(width: 150, height: 50)
                            
                        }
                        .modifier(ButtonSetUpView())

                        
                        NavigationLink(destination: GameView( viewModel: viewModel, shouldGoToRootGame: self.$shouldGoToRootSetUp).navigationBarBackButtonHidden(true) ) {
                            Text("START GAME")
                                .font(.system(size: 20, weight: .heavy))
                                .frame(width: 150, height: 50)
                            
                                .modifier(ButtonSetUpView())

                        }.isDetailLink(false)
                        
                    }.frame(width: UIScreen.main.bounds.width-25)

                    
                }
                
            }.padding()
                .frame(width: UIScreen.main.bounds.width-100)

            
            Spacer()
            
        }
            .navigationTitle("")
            .navigationBarHidden(true)
            .onAppear{

            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    resumeMusic()
                } else if newPhase == .inactive {

                    pauseMusic()
                } else if newPhase == .background {

                }
            }

    }    //        }
    

}

//struct GameSetupView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = AKHeadhuntingGame()
//        let boolLee = false
//        GameSetupView(viewModel: game)
//            .previewInterfaceOrientation(.portrait)
//    }
//}
