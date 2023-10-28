//
//  QuizView.swift
//  Quran
//
//  Created by Takasur Azeem on 30/07/2023.
//  Copyright © 2023 Islam. All rights reserved.
//

import QuranKit
import SwiftUI
import PDFKit

struct QuizView: View {
    @StateObject var viewModel: ViewModel
    
    @State private var locale: Locale?
    @State private var layoutDirection: LayoutDirection?
    
    @Environment(\.layoutDirection) private var appLayoutDirection
    @Environment(\.locale) private var appLocale
    
    var body: some View {
        NavigationStack {
            QuizPreparationViewSteps(viewModel: viewModel)
            .toolbar {
                ToolbarItemGroup(placement: .navigation) {
                    // MARK: - Right toolbar
                    PDFPreviewView(viewModel: viewModel)
                    Spacer()
                    Menu {
                        Button("English") {
                            locale = Locale(identifier: "en_US")
                            layoutDirection = .leftToRight
                        }
                        Button("Urdu") {
                            locale = Locale(identifier: "ur_Arab_PK")
                            layoutDirection = .rightToLeft
                        }
                        Button("Arabic") {
                            locale = Locale(identifier: "ar_SA")
                            layoutDirection = .rightToLeft
                        }
                    } label: {
                        Image(systemName: "globe")
                    }
                }
            }
            .task {
                await viewModel.start()
            }
        }
        .environment(\.locale, locale ?? appLocale)
        .environment(\.layoutDirection, layoutDirection ?? appLayoutDirection)
        .animation(.easeInOut, value: locale)
    }
}


#Preview {
    ApplicationMainView()
}
