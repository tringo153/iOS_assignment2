
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Ngo Huu Tri
  ID: 3818520
  Created  date: 20/08/2022
  Last modified: 22/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct NumberDisplayView: View {
    
    @ObservedObject var viewModel: AKHeadhuntingGame
    
    @State var itemType: String
    
    func getColor(item: String) -> Color {
        if (item == "Green Ticket") {
            return Color("ColorGreenTicket")
        } else if (item == "Gold Ticket") {
            return Color("ColorGoldTicket")
        } else if (item == "Spark") {
            return Color("ColorSpark")
        } else if (item == "Headhunt Ticket") {
            return Color("ColorHeadhuntTicket")
        } else {
            return Color(.black)
        }
                    
    }
    
    var body: some View {
        ZStack {
            HStack {

                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color(.black), getColor(item: itemType)]), startPoint: .top, endPoint: .bottom)
                                            
                        .frame(width: 35, height: 25)
                    
                    HStack {
                        
                        if (itemType == "Green Ticket") {
                            Image("green-ticket-icon")
                                .resizable()
                                .modifier(NumberDisplayItemImage())
                        } else if (itemType == "Gold Ticket") {
                            Image("gold-ticket-icon")
                                .resizable()
                                .modifier(NumberDisplayItemImage())
                        } else if (itemType == "Spark") {
                            Image("spark-icon")
                                .resizable()
                                .modifier(NumberDisplayItemImage())
                        } else if (itemType == "Headhunt Ticket") {
                            Image("headhunt-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25)
                        }
                                                    
                    }
                }
                
                HStack {
                    if (itemType == "Green Ticket") {
                        Text("\(viewModel.greenTicket)")
                            .modifier(NumberDisplay())
                    } else if (itemType == "Gold Ticket") {
                        Text("\(viewModel.goldTicket)")
                            .modifier(NumberDisplay())

                    } else if (itemType == "Spark") {
                        Text("\(viewModel.sparkCounter)")
                            .modifier(NumberDisplay())

                    } else if (itemType == "Headhunt Ticket") {
                        Text("\(viewModel.headhuntTicket)")
                            .modifier(NumberDisplay())
                    }

                }
                .modifier(NumberDisplayBox())
            }.frame(width: 125, height: 25)
        }
    }
}

struct NumberDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        let game = AKHeadhuntingGame()
        NumberDisplayView(viewModel: game, itemType: "Gold Ticket")
    }
}
