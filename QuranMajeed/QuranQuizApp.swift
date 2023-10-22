//
//  QuranMajeedApp.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 30/07/2023.
//

import SwiftUI
import FontBlaster

@main
struct QuranMajeedApp: App {
    
    init() {
        FontBlaster.blast() // Defaults to Bundle.main if no arguments are passed
    }
    
    var body: some Scene {
        WindowGroup {
            QuizView(
                viewModel: QuizView.ViewModel(
                    theQuranRepository: try! AppDependencyContainer
                        .shared
                        .theQuranDependencyContainer
                        .makeQuranRepository()
                )
            )
        }
    }
}
