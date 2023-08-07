
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Ngo Huu Tri
  ID: 3818520
  Created  date: 13/08/2022
  Last modified: 20/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct LeaderboardView: View {
    
    @Binding var isShowing: Bool
    
    @State var scoreList: [String:Int] = UserDefaults.standard.object(forKey: "Leaderboard") as? [String:Int] ?? [:]
    
    var indexCounter = 1
    
    func sortScore() -> [String:Int] {
        Dictionary(scoreList.sorted { $0.1 > $1.1 }.map { ($0.0, $0.1) },
                       uniquingKeysWith: { (first, _) in first })
    }
    
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    Spacer()
                    
                    Button {
                        playSoundEffect(sound: "ClickAudio", type: "mp3")
                        isShowing = false
                    } label: {
                        Image(systemName: "x.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                            .foregroundColor(Color("ColorButton"))
                    }
                }
                .padding()
                
                Spacer()
            }
            HStack {
                VStack {
                    List {
                        Section(header: Text("Leaderboard").font(.system(size: 17, weight: .bold , design: .monospaced))
                            ) {
                            
                            if (scoreList.count > 0) {
                                ForEach(scoreList.sorted{ $0.1 > $1.1 }.suffix(from: 0).indices, id: \.self) { i in
                                    //    credit: zhang lee
                                    HStack {
                                        Text("\(i + 1). \(scoreList.sorted{ $0.1 > $1.1 }.suffix(from: 0)[i].key)")
                                        Spacer()
                                        Text("\(scoreList.sorted{ $0.1 > $1.1 }.suffix(from: 0)[i].value)")

                                    }.font(.system(size: 17, weight: .bold , design: .monospaced))
                                }
                                
                            } else {
                                HStack {
                                    Text("No User Recored")
                                }.font(.system(size: 17, weight: .bold , design: .monospaced))

                            }


                            
                        }

                    }
                }.frame(width: UIScreen.main.bounds.width/2-50)

                
                Spacer()
                
                ZStack{
                    Image("podium")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                    VStack {
                        //MARK: - 1st place
                        Text("\(sortScore().count > 0 ? Array(scoreList.sorted{ $0.1 > $1.1 })[0].value : 0)")
                            .padding(.vertical,2)
                        Text("\(sortScore().count > 0 ? Array(scoreList.sorted{ $0.1 > $1.1 })[0].key : "No User")")
                        

                    }.foregroundColor(Color("ColorBlack"))
                    .modifier(NumberDisplay())
                    .offset(x: 0, y: -130)
                    
                    VStack {
                        //MARK: - 2nd place
                        Text("\(sortScore().count > 1 ? Array(scoreList.sorted{ $0.1 > $1.1 })[1].value : 0)")
                            .padding(.vertical,2)
                        Text("\(sortScore().count > 1 ? Array(scoreList.sorted{ $0.1 > $1.1 })[1].key : "No User")")
                        

                    }.foregroundColor(Color("ColorBlack"))
                        .modifier(NumberDisplay())

                    .offset(x: 65, y: -70)

                    
                    VStack {
                        //MARK: - 3rd place
                        Text("\(sortScore().count > 2 ? Array(scoreList.sorted{ $0.1 > $1.1 })[2].value : 0)")
                            .padding(.vertical,2)
                        Text("\(sortScore().count > 2 ? Array(scoreList.sorted{ $0.1 > $1.1 })[2].key : "No User")")
                        

                    }.foregroundColor(Color("ColorBlack"))
                        .modifier(NumberDisplay())

                    .offset(x: -65, y: -40)

                }.frame(width: UIScreen.main.bounds.width/2-50)

            }
        }.onAppear{
        }
    }
}

//struct LeaderboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        LeaderboardView()
//            .preferredColorScheme(.dark)
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
