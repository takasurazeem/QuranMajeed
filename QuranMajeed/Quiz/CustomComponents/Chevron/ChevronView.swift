//
//  ChevronView.swift
//  Al-Tanzeel
//
//  Created by Takasur A. on 23/10/2023.
//  Copyright © 2023 Islam. All rights reserved.
//

import SwiftUI

struct ChevronView: View {
    @Environment(\.layoutDirection) var layoutDirection
    var body: some View {
        Image(systemName: "chevron.\( layoutDirection == .rightToLeft ? "left" : "right")")
            .foregroundStyle(Color.accentColor)
    }
}

#Preview {
    ChevronView()
}
