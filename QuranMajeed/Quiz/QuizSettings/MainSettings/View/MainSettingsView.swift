//
//  MainSettingsView.swift
//  Al-Tanzeel
//
//  Created by Takasur Home on 25/02/2024.
//  Copyright © 2024 Islam. All rights reserved.
//

import SwiftUI

struct MainSettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Class Settings") {
                    QuizClassSettingsView(
                        viewModel: QuizClassSettingsView.ViewModel(
                            quizPreferencesRepository: AppDependencyContainer.shared.quizPreferenncesDependencyContainer.makePreferencesRepository()
                        )
                    )
                    .navigationTitle("Classes")
                }
            }
        }
    }
}

#Preview {
    MainSettingsView()
}
