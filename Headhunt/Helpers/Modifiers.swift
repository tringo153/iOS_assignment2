//
//  Modifiers.swift
//  ArknightsGachaSim
//
//  Created by Huu Tri on 20/08/2022.
//

import SwiftUI

struct IconForHowToPlay: ViewModifier{
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(width: 35, height: 35)
    }
}

struct ButtonSetUpView: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            .background(Color("ColorButton"))
            .foregroundColor(Color("ColorWhite"))
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct ShopConfirmText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .font(.system(.body, design: .rounded))
            .multilineTextAlignment(.center)
    }
}

struct NumberDisplay: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17, weight: .bold , design: .monospaced))
            .foregroundColor(.white)
            

    }
}

struct NumberDisplayBox: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, idealWidth: 280, maxWidth: 320, minHeight: 10, maxHeight: 50,alignment: .trailing)
            .padding(.trailing, 5)
            .background(.black)
            .foregroundColor(.white)
    }
}

struct NumberDisplayItemImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(width: 25)
            .offset(x: 0, y: -5)
        
    }
}
