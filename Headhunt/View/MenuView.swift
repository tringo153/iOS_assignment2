
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Ngo Huu Tri
  ID: 3818520
  Created  date: 13/08/2022
  Last modified: 28/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct MenuView: View {
    
    @ObservedObject var viewModel: AKHeadhuntingGame
    
    var songList = ["Void","Tech","Street", "Guiding Ahead (Lobby)"]
    
    @State var songName = UserDefaults.standard.string(forKey: "Theme Song") ?? "Void"
    
    @State var isGameSaved = false
    
    @Environment(\.scenePhase) var scenePhase
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var showSettingsView = false
    @State var showLeaderboardView = false
    @State var showHowToPlayView = false
    
    @State var isActiveToSetUp: Bool = false
    @State var isActiveToGame: Bool = false
    @State var isActiveToGameUnsaved: Bool = false

    @State var isShowingResume = false
    
    @State var username = ""
    @State var gameMode = ""
    @State var bannerType = ""
    @State var difficulty = ""
    
    @State var score = 0
    @State var headhuntTicket = 0
    @State var sparkCounter = 0
    @State var greenTicket = 0
    @State var goldTicket = 0
    @State var offerCounter = 0
    @State var sixStarCounter = 0
    
    @State var sixStarRateUp = Array<Operator>()
    @State var fiveStarRateUp = Array<Operator>()
    @State var offChanceRateUp = Array<Operator>()

    @State var roster = Array<HeadhuntingGame.CharacterCard>()
    @State var rosterCopy = Array<HeadhuntingGame.CharacterCard>()
    @State var shop = Array<HeadhuntingGame.ShopItem>()
    @State var sparkShop = Array<HeadhuntingGame.SparkShopItem>()

    func playMusic(song: String) {
        playSound(sound: song, type: "mp3")
        
        UserDefaults.standard.set(song, forKey: "Theme Song")
        
    }
    
    func loadSavedGame() {
        
        username = UserDefaults.standard.string(forKey: "Username") ?? ""
        gameMode = UserDefaults.standard.string(forKey: "GameMode") ?? ""
        bannerType = UserDefaults.standard.string(forKey: "BannerType") ?? ""
        difficulty = UserDefaults.standard.string(forKey: "Difficulty") ?? ""
        
        score = UserDefaults.standard.integer(forKey: "Score")
        headhuntTicket = UserDefaults.standard.integer(forKey: "HeadhuntTicket")
        sparkCounter = UserDefaults.standard.integer(forKey: "SparkCounter")
        greenTicket = UserDefaults.standard.integer(forKey: "GreenTicket")
        goldTicket = UserDefaults.standard.integer(forKey: "GoldTicket")
        offerCounter = UserDefaults.standard.integer(forKey: "OfferCounter")
        sixStarCounter = UserDefaults.standard.integer(forKey: "SixStarCounter")
        
        if let sixStarRateUpData = UserDefaults.standard.data(forKey: "SixStarRateUp") {
            do {
                sixStarRateUp = try JSONDecoder().decode(Array<Operator>.self, from: sixStarRateUpData)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        if let fiveStarRateUpData = UserDefaults.standard.data(forKey: "FiveStarRateUp") {
            do {
                fiveStarRateUp = try JSONDecoder().decode(Array<Operator>.self, from: fiveStarRateUpData)
            } catch {
                print(error.localizedDescription)
            }
        }

        if let offChanceRateUpData = UserDefaults.standard.data(forKey: "OffChanceRateUp") {
            do {
                offChanceRateUp = try JSONDecoder().decode(Array<Operator>.self, from: offChanceRateUpData)
            } catch {
                print(error.localizedDescription)
            }
        }

        if let rosterData = UserDefaults.standard.data(forKey: "Roster") {
            do {
                roster = try JSONDecoder().decode(Array<HeadhuntingGame.CharacterCard>.self, from: rosterData)
            } catch {
                print(error.localizedDescription)
            }
        }
    
        if let rosterCopyData = UserDefaults.standard.data(forKey: "RosterCopy") {
            do {
                rosterCopy = try JSONDecoder().decode(Array<HeadhuntingGame.CharacterCard>.self, from: rosterCopyData)
            } catch {
                print(error.localizedDescription)
            }
        }


        if let shopData = UserDefaults.standard.data(forKey: "Shop") {
            do {
                shop = try JSONDecoder().decode(Array<HeadhuntingGame.ShopItem>.self, from: shopData)
            } catch {
                print(error.localizedDescription)
            }
        }

        if let sparkShopData = UserDefaults.standard.data(forKey: "SparkShop") {
            do {
                sparkShop = try JSONDecoder().decode(Array<HeadhuntingGame.SparkShopItem>.self, from: sparkShopData)
            } catch {
                print(error.localizedDescription)
            }
        }

            
        viewModel.resumeGame(username: username, mode: gameMode, type: bannerType, difficulty: difficulty, sixStarRateup: sixStarRateUp, fiveStarRateup: fiveStarRateUp, offChanceRateup: offChanceRateUp, currentRoster: roster, rosterCopy: rosterCopy, shop: shop, sparkShop: sparkShop, score: score, headhuntTicket: headhuntTicket, goldTicket: goldTicket, greenTicket: greenTicket, sparkCounter: sparkCounter, offerCounter: offerCounter, sixStarCounter: sixStarCounter)

    }
    
    var body: some View {
        NavigationView{
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [Color("ColorWhite"), Color("ColorHeadhunt")]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea(.all)
                
                ZStack{
                    VStack{
                        HStack{
                            Button{ playSoundEffect(sound: "ClickAudio", type: "mp3"); self.showHowToPlayView.toggle() } label: {
                                Image(systemName: "questionmark.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)

                            }
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                            .foregroundColor(Color("ColorButton"))
                            .sheet(isPresented: $showHowToPlayView) {
                                HowToPlayView(isShowing: $showHowToPlayView)
                            }
                            
                            Spacer()
                            Button{ playSoundEffect(sound: "ClickAudio", type: "mp3"); self.showSettingsView.toggle() } label: {
                                Image(systemName: "gearshape.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                            }
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                            .foregroundColor(Color("ColorButton"))
                            .sheet(isPresented: $showSettingsView) {
                                SettingsView(isShowing: $showSettingsView)
                            }
                            
                            Button{ playSoundEffect(sound: "ClickAudio", type: "mp3"); self.showLeaderboardView.toggle() } label: {
                                Image(systemName: "chart.bar.xaxis")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)

                            }
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                            .foregroundColor(Color("ColorButton"))
                            .sheet(isPresented: $showLeaderboardView) {
                                LeaderboardView(isShowing: $showLeaderboardView)
                            }
                            
                            
                        }
                        Spacer()
                        
                        HStack{
                            Text("Now Playing: ")
                            Picker("Choose theme music", selection: $songName) {
                                ForEach(songList, id: \.self) {
                                    Text($0)
                                        .foregroundColor(Color("ColorButton"))
                                }
                            }
                            .onChange(of: songName) {
                                name in
                                playSoundEffect(sound: "ClickAudio", type: "mp3")
                                self.playMusic(song: name)

                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding(.vertical, 10)
                    }
                }
                
                VStack{
                    
                    Image(colorScheme == .dark ? "logo-dark" : "logo-light")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .padding()
                    
                    //If detect saved game in userdefaults, switch to "Resume" button
                    if (isGameSaved) {
                        Button{
                            
                            loadSavedGame()
                            playSoundEffect(sound: "ClickAudio3", type: "mp3")
                            self.isShowingResume = true
                            
                            
                            
                        } label: {
                            Text("RESUME")
                                .frame(width: 200, height: 50)
                            
                        }
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                        .background(Color("ColorButton"))
                        .foregroundColor(Color("ColorWhite"))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                    } else {
                        NavigationLink(
                            destination: GameSetupView(viewModel: viewModel, shouldGoToRootSetUp: self.$isActiveToGameUnsaved),
                            isActive: self.$isActiveToGameUnsaved
                        ) {
                            Text("START GAME")
                                .frame(width: 200, height: 50)
                                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                                .background(Color("ColorButton"))
                                .foregroundColor(Color("ColorWhite"))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                        }.isDetailLink(false)
                    }
                    

                }

                //Show confirm resume pop up
                if (isShowingResume) {
                    Color("ColorBackground")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea(.all)
                    
                    VStack {
                        HStack{
                            Spacer()
                            Image(systemName: "x.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .foregroundColor(.black)
                                .padding(.all, 3)
                                .onTapGesture {
                                    self.isShowingResume = false
                                }
                        }
                        Spacer()
                        
                        Text("Continue with your saved data?")
                            .foregroundColor(.black)
                            .font(.system(.body, design: .rounded))
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        HStack{
                            
                            NavigationLink(
                                destination: GameSetupView(viewModel: viewModel, shouldGoToRootSetUp: self.$isActiveToSetUp),
                                isActive: self.$isActiveToSetUp
                            ) {
                                
                                Text("Start New Game")
                                    .foregroundColor(Color("ColorWhite"))
                                    .padding(.all, 10)
                                    .background(
                                        Capsule().fill(Color("ColorButton"))
                                    )
                                
                            }.isDetailLink(false)

                            
                            NavigationLink(
                                destination: GameView(viewModel: viewModel, shouldGoToRootGame: self.$isActiveToGame),
                                isActive: self.$isActiveToGame
                            ) {
                                
                                Text("Continue")
                                    .foregroundColor(Color("ColorWhite"))
                                    .padding(.all, 10)
                                    .background(
                                        Capsule().fill(Color("ColorButton"))
                                    )
                                
                            }.isDetailLink(false)
                            
                        }
                        
                        Spacer()
                    }
                    .frame(width: 250 , height: 150, alignment: .center)
                        .background(.white)
                        .cornerRadius(20)
                    
                }

            }.navigationTitle("")
            .navigationBarHidden(true)
            .onAppear{
                if (AppDelegate.orientationLock != .landscape) {
                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation") // Forcing the rotation to portrait

                }
                AppDelegate.orientationLock = .landscape

                if ((audioPlayer?.isPlaying) == nil) {
                    playSound(sound: UserDefaults.standard.string(forKey: "Theme Song") ?? "Void", type: "mp3")
                }
                
                if (UserDefaults.standard.bool(forKey: "Saved")) {
                    isGameSaved = true
                } else {
                    isGameSaved = false
                }
                
                self.isShowingResume = false
                self.isActiveToSetUp = false
                self.isActiveToGame = false
                self.isActiveToGameUnsaved = false
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    resumeMusic()
                } else if newPhase == .inactive {

                    pauseMusic()
                } else if newPhase == .background {

                }
            }
                    
        }
    }
}

//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = AKHeadhuntingGame()
//        Group {
//            MenuView(viewModel: game)
//                .previewInterfaceOrientation(.landscapeLeft)
//            MenuView(viewModel: game)
//        }
//    }
//}
