//
//  RoundedCornersModifier.swift
//  Al-Tanzeel
//
//  Created by Takasur Azeem on 22/10/2023.
//  Copyright © 2023 Islam. All rights reserved.
//

import SwiftUI

struct  RoundedCornersModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .padding(AppStyle.Spacing.space16)
            .background(Color.gray.opacity(0.18))
            .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
    }
}

extension View {
    func roundedCornersView() -> some View {
        modifier(RoundedCornersModifier())
    }
}
