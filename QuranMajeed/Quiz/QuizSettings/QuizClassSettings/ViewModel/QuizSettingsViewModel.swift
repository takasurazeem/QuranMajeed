//
//  QuizSettingsViewModel.swift
//  Al-Tanzeel
//
//  Created by Takasur A. on 19/02/2024.
//  Copyright © 2024 Islam. All rights reserved.
//

import SwiftUI

extension QuizClassSettingsView {

    @MainActor class ViewModel: ObservableObject {

        init(
            quizPreferencesRepository: QuizPreferencesRepository
        ) {
            self.quizPreferencesRepository = quizPreferencesRepository
            
            // Load classes
            self.classes = quizPreferencesRepository.get().classList
         }

        func savePreferences() {
            var preferences = quizPreferencesRepository.get()
            preferences.classList = classes
            quizPreferencesRepository.save(quizPreferences: preferences)
        }
        
        func addClass(
            className: String,
            masjidName: String
        ) {
            let newClass = QuizPreferences.QuizClass(
                className: className,
                masjidName: masjidName,
                isSelected: classes.isEmpty ? true : false
            )
            if !classes.contains(newClass) {
                classes.append(newClass)
            }
            savePreferences()
        }

        private let quizPreferencesRepository: QuizPreferencesRepository
        @Published var classes: [QuizPreferences.QuizClass] = []
    }
}
