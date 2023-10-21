//
//  PulseEffect.swift
//  Al-Tanzeel
//
//  Created by Takasur Azeem on 22/10/2023.
//  Copyright © 2023 Islam. All rights reserved.
//

import SwiftUI

/// Kieran Brown
/// Kieran's Components "Pulse and Sheen"
/// [Source](https://kieranb662.github.io/blog/2020/04/17/Pulse-and-Sheen)
struct PulseEffect<S: Shape>: ViewModifier {
    var shape: S
    @State var isOn: Bool = false
    var animation: Animation {
        Animation
            .easeIn(duration: 1)
            .repeatCount(8, autoreverses: false)
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    shape
                        .stroke(Color.accentColor, lineWidth: 1)
                        .scaleEffect(self.isOn ? 2 : 1)
                        .opacity(self.isOn ? 0 : 1)
                    shape
                        .stroke(Color.accentColor)
                })
            .onAppear {
                withAnimation(self.animation) {
                    self.isOn = true
                }
            }
    }
}

public extension View {
    func pulse<S: Shape>(_ shape: S) -> some View  {
        self.modifier(PulseEffect(shape: shape))
    }
}
