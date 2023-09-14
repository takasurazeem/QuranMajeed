//
//  QuranMajeedApp.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 30/07/2023.
//

import SwiftUI

@main
struct QuranMajeedApp: App {
    var body: some Scene {
        WindowGroup {
            QuizView(viewModel: QuizView.ViewModel())
        }
    }
}
