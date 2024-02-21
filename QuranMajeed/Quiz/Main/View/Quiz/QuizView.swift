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
    @State private var isShowingSettingsPage: Bool = false
    @State private var locale: Locale?
    @State private var layoutDirection: LayoutDirection?

    @Environment(\.layoutDirection) private var appLayoutDirection
    @Environment(\.locale) private var appLocale
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("darkMode") private var darkMode = false

    var body: some View {
        NavigationStack {
            QuizPreparationViewSteps(viewModel: viewModel)
                .toolbar {
                    ToolbarItemGroup(placement: .navigation) {
                        // MARK: - Right toolbar
                        PDFPreviewView(viewModel: viewModel)
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
                        Button {
                            darkMode.toggle()
                        } label: {
                            Image(systemName: colorScheme == .dark ? "moon.circle.fill" : "moon.circle")
                        }
                        Button {
                            isShowingSettingsPage = true
                        } label: {
                            Image(systemName: "gearshape.circle")
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
        .environment(\.colorScheme, darkMode ? .dark : .light)
        .sheet(isPresented: $isShowingSettingsPage) {
            NavigationStack {
                QuizSettingsView(
                    viewModel: QuizSettingsView.ViewModel(
                        quizPreferencesRepository: AppDependencyContainer.shared.quizPreferenncesDependencyContainer.makePreferencesRepository()
                    )
                )
                .navigationTitle("Quiz Settings")
            }
        }
    }
}

#Preview {
    ApplicationMainView()
}
