//
//  ApplicationMainView.swift
//  Al-Tanzeel
//
//  Created by Takasur A. on 23/10/2023.
//  Copyright © 2023 Islam. All rights reserved.
//

import SwiftUI

struct ApplicationMainView: View {
    var body: some View {
        if  let repo = try? AppDependencyContainer
                .shared
                .theQuranDependencyContainer
                .makeQuranRepository() {
            QuizView(
                viewModel: QuizView.ViewModel(
                    theQuranRepository: repo,
                    quizPreferencesRepository: AppDependencyContainer
                        .shared
                        .quizPreferenncesDependencyContainer
                        .makePreferencesRepository()
                )
            )
        } else {
            Text("Sorry, something went wrong.")
        }
    }
}

#Preview {
    ApplicationMainView()
}
