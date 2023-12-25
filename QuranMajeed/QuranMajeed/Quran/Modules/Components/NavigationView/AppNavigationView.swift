//
//  AppNavigationView.swift
//  Al-Tanzeel
//
//  Created by Takasur A. on 25/12/2023.
//  Copyright © 2023 Islam. All rights reserved.
//

import SwiftUI

/// An AppNavigationView that contains has three containers that the caller can provide views for: left, right, and center.
struct AppNavigationView<Left: View, Right: View, Center: View>: View {
    var leftView: Left
    var rightView: Right
    var centerView: Center

    /// Init with viewbuilder for left, right and center
    init(
        @ViewBuilder leftView: () -> Left,
        @ViewBuilder rightView: () -> Right,
        @ViewBuilder centerView: () -> Center
    ) {
        self.leftView = leftView()
        self.rightView = rightView()
        self.centerView = centerView()
    }

    var body: some View {
        HStack(alignment: .center) {
            leftView
            Spacer()
            centerView
            Spacer()
            rightView
        }
    }
}

#Preview {
    AppNavigationView {
        Text(verbatim: "Left")
    } rightView: {
        Text(verbatim: "Right")
    } centerView: {
        Text(verbatim: "Center")
    }
}
