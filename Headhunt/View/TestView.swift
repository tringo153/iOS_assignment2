//
//  TestView.swift
//  ArknightsGachaSim
//
//  Created by Huu Tri on 27/08/2022.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        ZStack{
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
                
                HStack {
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("\(Image("headhunt-icon")) Remaning: 100")
                        Text("\(Image("green-ticket-icon")) Remaining: 2400")
                        Text("\(Image("gold-ticket-icon")) Remaning: 130")
                        
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
                
                Text("Difficulty: Free To Play -> Score x1")
                    .foregroundColor(.black)
                Divider()
                
                Text("Total Score: ")
                    .foregroundColor(.black)

                Spacer()

                HStack{
                    Button {


                    } label: {
                        Text("Return to Main Menu")
                            .foregroundColor(.white)
                    }.padding(.all, 10)
                        .background(
                            Capsule().fill(.blue)
                        )

                }.padding()

            }.frame(width: 300 , height: 250, alignment: .center)
            .background(.white)
            .cornerRadius(20)

        }
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
