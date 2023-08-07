
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

struct GameView: View {
    
    @ObservedObject var viewModel: AKHeadhuntingGame
        
    @Binding var shouldGoToRootGame: Bool
    
    @Environment(\.scenePhase) var scenePhase
    
    @State var showRosterView = false
    @State var showShopView = false
    @State var showResultView = false
    @State var showInfoGameView = false
    
    @State var isWinning = false
    @State var isLosing = false
    
    @State var showReturnConfirm = false
    @State var showSavedPopup = false
    
    @State var hiddenCounter = 0
    
    @State private var showResult = false
    
    func saveScore() {
        let userDetaults = UserDefaults.standard
        
        var scoreList: [String:Int] = userDetaults.object(forKey: "Leaderboard") as? [String:Int] ?? [:]
        
        scoreList[viewModel.username] = viewModel.score
        
        userDetaults.set(scoreList, forKey: "Leaderboard")
    }

    func saveGame() {
        do {
            let sixStarRateUp = try JSONEncoder().encode(viewModel.sixStarRateup)
            let fiveStarRateUp = try JSONEncoder().encode(viewModel.fiveStarRateup)
            let offChanceRateUp = try JSONEncoder().encode(viewModel.offChanceRateup)
            
            let roster = try JSONEncoder().encode(viewModel.rosters)
            let rosterCopy = try JSONEncoder().encode(viewModel.rosterCopy)
            let shop = try JSONEncoder().encode(viewModel.shop)
            let sparkShop = try JSONEncoder().encode(viewModel.sparkShop)
            
            UserDefaults.standard.set(sixStarRateUp, forKey: "SixStarRateUp")
            UserDefaults.standard.set(fiveStarRateUp, forKey: "FiveStarRateUp")
            UserDefaults.standard.set(offChanceRateUp, forKey: "OffChanceRateUp")

            UserDefaults.standard.set(roster, forKey: "Roster")
            UserDefaults.standard.set(rosterCopy, forKey: "RosterCopy")
            UserDefaults.standard.set(shop, forKey: "Shop")
            UserDefaults.standard.set(sparkShop, forKey: "SparkShop")

            
        } catch {
            print(error.localizedDescription)
        }
        
        UserDefaults.standard.set(viewModel.username, forKey: "Username")
        UserDefaults.standard.set(viewModel.score, forKey: "Score")
        UserDefaults.standard.set(viewModel.headhuntTicket, forKey: "HeadhuntTicket")
        UserDefaults.standard.set(viewModel.sparkCounter, forKey: "SparkCounter")
        UserDefaults.standard.set(viewModel.goldTicket, forKey: "GoldTicket")
        UserDefaults.standard.set(viewModel.greenTicket, forKey: "GreenTicket")
        UserDefaults.standard.set(viewModel.offerCounter, forKey: "OfferCounter")
        UserDefaults.standard.set(viewModel.bannerType, forKey: "BannerType")
        UserDefaults.standard.set(viewModel.gameMode, forKey: "GameMode")
        UserDefaults.standard.set(viewModel.difficulty, forKey: "Difficulty")
        UserDefaults.standard.set(viewModel.SixStarCounter, forKey: "SixStarCounter")
        
    }
    
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
        
//    @SwiftUI.Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
//        NavigationView {
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [Color("ColorWhite"), Color("ColorHeadhunt")]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea(.all)

                
                VStack {
                    HStack{
                        Button{ playSoundEffect(sound: "ClickAudio", type: "mp3"); self.showInfoGameView.toggle() } label: {
                            Image(systemName: "questionmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)

                        }
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                        .foregroundColor(Color("ColorButton"))
                        .sheet(isPresented: $showInfoGameView) {
                            InfoGameView(isShowing: $showInfoGameView)
                        }
                        
                        NumberDisplayView(viewModel: viewModel, itemType: "Headhunt Ticket")
                        
                        NumberDisplayView(viewModel: viewModel, itemType: "Green Ticket")
                        
                        NumberDisplayView(viewModel: viewModel, itemType: "Gold Ticket")
                        
                        if (viewModel.bannerType == "Limited") {
                            NumberDisplayView(viewModel: viewModel, itemType: "Spark")
                        }
                        
                        Spacer()
                        
                        //MARK: - SHOW ROSTER BUTTON
                        Button( action: {
                            viewModel.resetRosterOrder()
                            self.showRosterView.toggle()
                            playSoundEffect(sound: "ClickAudio", type: "mp3")
                        }, label: {
                            Image(systemName: "person.crop.rectangle.stack.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                            
                        })
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                        .foregroundColor(Color("ColorButton"))
                        .sheet(isPresented: $showRosterView) {
                            RosterView(isShowing: $showRosterView, game: viewModel)
                        }
                        
                        //MARK: - SHOW SHOP VIEW BUTTON
                        if (viewModel.gameMode == "Challenge") {
                            Button( action: {
                                playSoundEffect(sound: "ClickAudio", type: "mp3")
                                self.showShopView.toggle()
                            }, label: {
                                Image(systemName: "cart.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)

                            })
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                            .foregroundColor(Color("ColorButton"))
                            .sheet(isPresented: $showShopView) {
                                ShopView(isShowing: $showShopView, game: viewModel, winningState: $isWinning)
                            }

                        }
                        
                        Button( action: {
                            playSoundEffect(sound: "ClickAudio3", type: "mp3")
                            self.showReturnConfirm = true
                        }, label: {
                            Image(systemName: "arrowshape.turn.up.left.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)

                        })
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                        .foregroundColor(Color("ColorButton"))

                        
                    }.padding(EdgeInsets(top: 5, leading: 50, bottom: 5, trailing: 50))
                    
                    ZStack {
                        Image("wallpaper1")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width-100, height: 300)
                        VStack {
                            
                            HStack {
                                
                                VStack{
                                    
                                    //MARK: - BANNER DETAILS VIEW
                                    ZStack(alignment: .leading)  {
                                        
                                        Color("ColorBackground")
                                        
                                        ScrollView{
                                            Text("BANNER FEATURE")
                                                .font(.system(size: 17, weight: .bold , design: .monospaced))
                                                .foregroundColor(.white)
                                                .padding(.vertical, 5)
                                            VStack(alignment: .leading) {
                                                
                                                
                                                
                                                if (viewModel.bannerType == "Standard") {
                                                    Text("6* - Accounts for 50% of the odds when pulling a 6*")
                                                        .font(.system(size: 14, weight: .heavy , design: .monospaced))
                                                        .foregroundColor(.white)
                                                    
                                                } else {
                                                    Text("6* - Accounts for 70% of the odds when pulling a 6*")
                                                        .font(.system(size: 14, weight: .heavy , design: .monospaced))
                                                        .foregroundColor(.white)
                                                    
                                                }
                                                
                                                ScrollView(.horizontal) {
                                                    HStack {
                                                        
                                                        ForEach(0..<viewModel.sixStarRateup.count, id: \.self) {
                                                            i in
                                                            ZStack{
                                                                
                                                                Image(viewModel.sixStarRateup[i].image.tooltip)
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 60)
                                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                                                
                                                                ZStack {
                                                                    VStack {
                                                                        Spacer()
                                                                        
                                                                        Text(viewModel.sixStarRateup[i].name.uppercased())
                                                                            .foregroundColor(.white)
                                                                            .font(.system(size: 6, weight: .heavy))
                                                                            .frame(width: 60)
                                                                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                                                            .background{
                                                                                RoundedRectangle(cornerRadius: 4)
                                                                                    .foregroundColor(.black)
                                                                                    .opacity(0.5)
                                                                            }
                                                                        
                                                                    }
                                                                    
                                                                }.frame(height: 60*2)
                                                                
                                                            }
                                                            .overlay(RoundedRectangle(cornerRadius: 8)
                                                                .stroke(.brown, lineWidth: 3))
                                                        }
                                                        
                                                        
                                                        
                                                    }
                                                    
                                                }.padding(.horizontal, 10)
                                                
                                                if (viewModel.offChanceRateup.count > 0) {
                                                    
                                                    Text("Off Chance 6* - 5 times the weight of the rest of 6*")
                                                        .font(.system(size: 14, weight: .heavy , design: .monospaced))
                                                        .foregroundColor(.white)
                                                    
                                                    ScrollView(.horizontal) {
                                                        HStack {
                                                            
                                                            ForEach(0..<viewModel.offChanceRateup.count, id: \.self) {
                                                                i in
                                                                ZStack{
                                                                    
                                                                    Image(viewModel.offChanceRateup[i].image.tooltip)
                                                                        .resizable()
                                                                        .scaledToFit()
                                                                        .frame(width: 60)
                                                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                                                    
                                                                    ZStack {
                                                                        VStack {
                                                                            Spacer()
                                                                            
                                                                            Text(viewModel.offChanceRateup[i].name.uppercased())
                                                                                .foregroundColor(.white)
                                                                                .font(.system(size: 6, weight: .heavy))
                                                                                .frame(width: 60)
                                                                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                                                                .background{
                                                                                    RoundedRectangle(cornerRadius: 4)
                                                                                        .foregroundColor(.black)
                                                                                        .opacity(0.5)
                                                                                }
                                                                            
                                                                        }
                                                                        
                                                                    }.frame(height: 60*2)
                                                                    
                                                                    
                                                                }
                                                                .overlay(RoundedRectangle(cornerRadius: 8)
                                                                    .stroke(.brown, lineWidth: 3))
                                                            }
                                                            
                                                            
                                                            
                                                        }.padding(.horizontal, 10)
                                                        
                                                    }
                                                    
                                                }
                                                
                                                Text("5* - Accounts for 50% of the odds when pulling a 5*")
                                                    .font(.system(size: 14, weight: .heavy , design: .monospaced))
                                                    .foregroundColor(.white)
                                                
                                                ScrollView(.horizontal) {
                                                    HStack {
                                                        
                                                        ForEach(0..<viewModel.fiveStarRateup.count, id: \.self) {
                                                            i in
                                                            ZStack{
                                                                
                                                                Image(viewModel.fiveStarRateup[i].image.tooltip)
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 60)
                                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                                                
                                                                ZStack {
                                                                    VStack {
                                                                        Spacer()
                                                                        
                                                                        Text(viewModel.fiveStarRateup[i].name.uppercased())
                                                                            .foregroundColor(.white)
                                                                            .font(.system(size: 6, weight: .heavy))
                                                                            .frame(width: 60)
                                                                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                                                            .background{
                                                                                RoundedRectangle(cornerRadius: 4)
                                                                                    .foregroundColor(.black)
                                                                                    .opacity(0.5)
                                                                            }
                                                                        
                                                                    }
                                                                    
                                                                }.frame(height: 60*2)
                                                                
                                                                
                                                            }
                                                            .overlay(RoundedRectangle(cornerRadius: 8)
                                                                .stroke(.brown, lineWidth: 3))
                                                        }
                                                        
                                                        
                                                        
                                                    }.padding(.horizontal, 10)
                                                    
                                                }
                                                
                                                
                                            }
                                        }.padding()
                                        
                                    }
                                    
                                }
                                .frame(width: 300, height: 300, alignment: .leading)
                                
                                Spacer()
                                
                                VStack {
                                    
                                    if (viewModel.gameMode == "Challenge") {
                                        //MARK: - SCORE VIEW
                                        HStack {

                                            ZStack {
                                                LinearGradient(gradient: Gradient(colors: [Color(.black)]), startPoint: .top, endPoint: .bottom)
                                                    .opacity(0.6)
                                                                        
                                                    .frame(width: 60, height: 30)
                                                
                                                HStack {
                                                    Text("Score")
                                                        .modifier(NumberDisplay())
                                                                                
                                                }
                                            }.clipShape(Capsule())
                                            
                                            HStack {
                                                Text("\(viewModel.score)")
                                                        .modifier(NumberDisplay())

                                            }
                                            .modifier(NumberDisplayBox())
                                            .clipShape(Capsule())
                                        }
                                        .frame(width: 150, height: 30)
                                        .padding(.all, 10)
                                        
                                        //MARK: - WINNING TARGET VIEW
                                        VStack(alignment: .leading){
                                                                  
                                            Text("Target: ")

                                            if (viewModel.difficulty == "Free To Play") {
                                                HStack{

                                                    Image(viewModel.sixStarRateup[0].image.profile)
                                                    Image("potential-1")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 20)
                                                    
                                                    if (viewModel.sixStarRateup.count > 1) {
                                                        Text("OR")
                                                        
                                                        Image(viewModel.sixStarRateup[1].image.profile)
                                                        Image("potential-1")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 20)


                                                    }

                                                }
                                            } else if (viewModel.difficulty == "Dolphin") {
                                                HStack{

                                                    if (viewModel.sixStarRateup.count > 1) {
                                                        Image(viewModel.sixStarRateup[0].image.profile)
                                                        Image("potential-1")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 20)

                                                        
                                                        Text("&")
                                                        
                                                        Image(viewModel.sixStarRateup[1].image.profile)
                                                        Image("potential-1")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 20)


                                                    } else {
                                                        Image(viewModel.sixStarRateup[0].image.profile)
                                                        Image("potential-3")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 20)

                                                    }

                                                }

                                            } else {
                                                HStack{

                                                    Image(viewModel.sixStarRateup[0].image.profile)
                                                    Image("potential-6")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 20)
                                                    
                                                    if (viewModel.sixStarRateup.count > 1) {
                                                        Text("AND")
                                                        
                                                        Image(viewModel.sixStarRateup[1].image.profile)
                                                        Image("potential-6")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 20)

                                                    }

                                                }
                                            }
                                            
                                        }.foregroundColor(.white)
                                        .frame(width: 200, height: (viewModel.offerCounter > 10 && viewModel.offerCounter < 0) ? 100 : 130)
                                        
                                    }
                                    
                                    Spacer()
                                    
                                    VStack {
                                        if (viewModel.offerCounter > 0) {
                                            ZStack {
                                                Color("ColorBackground")
                                                    .frame(height: 50)
                                                VStack {
                                                    Text("Guarantees a 5* or higher")
                                                    HStack {
                                                        Text("IN THE NEXT ")
                                                        Text("\(viewModel.offerCounter) ")
                                                            .font(.system(size: 20, weight: .bold))
                                                            .foregroundColor(.yellow)
                                                        Text("PULLS")
                                                    }
                                                    
                                                }
                                                .foregroundColor(.white)
                                                
                                                ZStack {
                                                    Text("Offer")
                                                        .fontWeight(.bold)
                                                        .foregroundColor(.yellow)
                                                        .padding(.all, 15)
                                                        .background
                                                    { Circle().stroke(.yellow, lineWidth: 2).opacity(0.8) }
                                                    
                                                    Text("Once Only")
                                                        .font(.system(size: 12))
                                                        .padding(.all, 4)
                                                        .background{
                                                            Rectangle().fill(.yellow)
                                                        }
                                                        .offset(x: 0, y: -20)
                                                    
                                                }
                                                .rotationEffect(Angle(degrees: 10))
                                                .offset(x: 130, y: 5)
                                                
                                            }
                                            .frame(width: 270)
                                            
                                        }
                                        
                                        //MARK: - HEADHUNT BUTTONS VIEW
                                        HStack{
                                            Button {
                                                playSoundEffect(sound: "HeadhuntAudio", type: "mp3")
                                                hiddenCounter = 1;
                                                viewModel.oneTimeRoll()
                                                self.showResultView = true
                                                
                                                if (viewModel.gameMode == "Challenge") {
                                                    saveGame()
                                                    
                                                }
                                                
                                            } label: {
                                                Text("Headhunt x1")
                                                    .font(.system(size: 15, weight: .heavy , design: .monospaced))

                                            }
                                            .padding(.all, 10)
                                            .background(.white)
                                            .foregroundColor(.black)
                                            .overlay(Rectangle()
                                                .stroke())
                                            .disabled(viewModel.gameMode == "Challenge" && viewModel.headhuntTicket == 0)
                                            .sheet(isPresented: self.$showResultView) {
                                                ResultView(viewModel: viewModel, hiddenCounter: $hiddenCounter, winningState: $isWinning, losingState: $isLosing, isShowing: $showResultView)
                                            }
                                            
                                            Button {
                                                playSoundEffect(sound: "HeadhuntAudio", type: "mp3")
                                                hiddenCounter = 10;
                                                viewModel.tenTimesRoll()
                                                self.showResultView = true
                                                
                                                if (viewModel.gameMode == "Challenge") {
                                                    saveGame()
                                                }
                                                
                                            } label: {
                                                Text("Headhunt x10")
                                                    .font(.system(size: 15, weight: .heavy , design: .monospaced))

                                            }
                                            .padding(.all, 10)
                                            .background(.white)
                                            .foregroundColor(.black)
                                            .overlay(Rectangle()
                                                .stroke())
                                            
                                            .disabled(viewModel.gameMode == "Challenge" && viewModel.headhuntTicket < 10)
                                            .sheet(isPresented: self.$showResultView) {
                                                ResultView(viewModel: viewModel, hiddenCounter: $hiddenCounter, winningState: $isWinning, losingState: $isLosing, isShowing: $showResultView)
                                            }
                                            
                                        }
                                        
                                    }
                                    .padding(.bottom, 10)
                                    .padding(.trailing, 10)
                                    
                                    
                                }
                                
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width-100, height: 300)
                    }
                    
                }.frame(width: UIScreen.main.bounds.width)
                
                //MARK: - WIN POP UP VIEW
                if isWinning {
                    Color("ColorBackground")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea(.all)

                    VStack {


                        Text("YOU WON!")
                            .font(.system(size: 20, design: .rounded))
                            .fontWeight(.bold)
                            .frame(minWidth: 0, idealWidth: 280, maxWidth: 320, minHeight: 50, maxHeight: 50)
                            .background(.blue)
                            .foregroundColor(.white)
                        
                        ScrollView {
                            HStack {
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text("\(Image("headhunt-icon")) Remaning: \(viewModel.headhuntTicket)")
                                    Text("\(Image("green-ticket-icon")) Remaining: \(viewModel.greenTicket)")
                                    Text("\(Image("gold-ticket-icon")) Remaning: \(viewModel.goldTicket)")
                                    
                                }.padding(.leading, 20)
                                .foregroundColor(.black)
                                Spacer()
                                
                                VStack(alignment: .leading){
                                    Text("x 10")
                                    Text("x 1")
                                    Text("x 5")
                                    
                                }
                                .padding(.trailing, 20)
                                .foregroundColor(.black)
                                Spacer()
                            }
                            
                            Text("Difficulty: \(viewModel.difficulty) -> Score x \(viewModel.difficulty == "Free To Play" ? "1" : (viewModel.difficulty == "Dolphin" ? "1.5" : "2"))")
                                .foregroundColor(.black)
                            
                            Divider()
                            
                            Text("Total Score: \(viewModel.score)")
                                .foregroundColor(.black)
                            
                        }
                        
                        Spacer()

                        HStack{
                            Button {
                                playSound(sound: UserDefaults.standard.string(forKey: "Theme Song") ?? "Void", type: "mp3")
                                UserDefaults.standard.set(false, forKey: "Saved")
                                
                                saveScore()
                                
                                self.shouldGoToRootGame = false

                            } label: {
                                Text("Return to Main Menu")
                                    .foregroundColor(Color("ColorWhite"))
                            }.padding(.all, 10)
                                .background(
                                    Capsule().fill(Color("ColorButton"))
                                )

                        }.padding()

                    }.frame(width: 300 , height: 250, alignment: .center)
                    .background(.white)
                    .cornerRadius(20)
                    .onAppear{
                        playSound(sound: "win-theme", type: "mp3")

                    }

                }
                
                //MARK: - LOSING POP UP VIEW
                if isLosing {
                    Color("ColorBackground")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea(.all)

                    VStack {

                        Text("YOU LOST!")
                            .font(.system(size: 20, design: .rounded))
                            .fontWeight(.bold)
                            .frame(minWidth: 0, idealWidth: 280, maxWidth: 320, minHeight: 50, maxHeight: 50)
                            .background(.blue)
                            .foregroundColor(.white)
                        
                        ScrollView {
                            HStack {
                                VStack(alignment: .center) {
                                    Text("You did not aquired the target characters")
                                }.padding(.leading, 5)
                                .foregroundColor(.black)
                                
                            }
                            
                            HStack {
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text("\(Image("headhunt-icon")) Remaning: \(viewModel.headhuntTicket)")
                                    Text("\(Image("green-ticket-icon")) Remaining: \(viewModel.greenTicket)")
                                    Text("\(Image("gold-ticket-icon")) Remaning: \(viewModel.goldTicket)")
                                    
                                }.padding(.leading, 20)
                                .foregroundColor(.black)
                                Spacer()
                                
                                VStack(alignment: .leading){
                                    Text("x 10")
                                    Text("x 1")
                                    Text("x 5")
                                    
                                }
                                .padding(.trailing, 20)
                                .foregroundColor(.black)
                                Spacer()
                            }
                            
                            Text("Difficulty: \(viewModel.difficulty) -> Score x \(viewModel.difficulty == "Free To Play" ? "1" : (viewModel.difficulty == "Dolphin" ? "1.5" : "2"))")
                                .foregroundColor(.black)
                            
                            Divider()
                            
                            Text("Total Score: \(viewModel.score)")
                                .foregroundColor(.black)


                        }


                        HStack{
                            Button {
                                playSound(sound: UserDefaults.standard.string(forKey: "Theme Song") ?? "Void", type: "mp3")
                                UserDefaults.standard.set(false, forKey: "Saved")
                                
                                saveScore()
                                
                                self.shouldGoToRootGame = false

                            } label: {
                                Text("Return to Main Menu")
                                    .foregroundColor(Color("ColorWhite"))
                            }.padding(.all, 10)
                                .background(
                                    Capsule().fill(Color("ColorButton"))
                                )

                        }.padding()

                    }.frame(width: 300 , height: 250, alignment: .center)
                    .background(.white)
                    .cornerRadius(20)
                    .onAppear{
                        playSound(sound: "lose-theme", type: "mp3")
                        
                    }

                }

                
                //MARK: - SAVE GAME CONFIRM POPUP
                if showReturnConfirm {
                    Color("ColorBackground")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea(.all)

                    VStack {
                        Spacer()

                        Text("Are you sure you want to return to main menu?")
                            .foregroundColor(.black)
                            .font(.system(.body, design: .rounded))
                            .multilineTextAlignment(.center)
                            .padding(.all, 10)

                        Spacer()

                        HStack{
                            Button {
                                self.showReturnConfirm = false

                            } label: {
                                Text("Cancel")
                                    .foregroundColor(Color("ColorWhite"))
                            }.padding(.all, 10)
                                .background(
                                    Capsule().fill(Color("ColorButton"))
                                )

                            Button {
                                self.showReturnConfirm = false
                                
                                if (viewModel.gameMode == "Challenge") {
                                    UserDefaults.standard.set(true, forKey: "Saved")

                                }
                                
                                self.shouldGoToRootGame = false

                            } label: {
                                Text("Confirm")
                                    .foregroundColor(Color("ColorWhite"))
                            }.padding(.all, 10)
                                .background(
                                    Capsule().fill(Color("ColorButton"))
                                )


                        }

                        Spacer()
                    }.frame(width: 250 , height: 150, alignment: .center)
                    .background(.white)
                    .cornerRadius(20)

                }
                
                
                
            }
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .onAppear {
                saveGame()
            }
            .onDisappear{
                if (isLosing || isWinning) {
                    UserDefaults.standard.set(false, forKey: "Saved")
                } else {
                    UserDefaults.standard.set(true, forKey: "Saved")

                }
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    resumeMusic()
                } else if newPhase == .inactive {
                    UserDefaults.standard.set(false, forKey: "Saved")
                    saveGame()
                    pauseMusic()
                } else if newPhase == .background {
                    UserDefaults.standard.set(true, forKey: "Saved")
                }
            }


                    
//        }
        
        
    }
            

}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = AKHeadhuntingGame()
//        GameView(viewModel: game)
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
//


