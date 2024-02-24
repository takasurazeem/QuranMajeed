//
//  QuizPreparationViewSteps.swift
//  Al-Tanzeel
//
//  Created by Takasur Azeem on 23/10/2023.
//  Copyright © 2023 Islam. All rights reserved.
//

import SwiftUI

struct QuizPreparationViewSteps: View {
    @ObservedObject var viewModel: QuizView.ViewModel
    var body: some View {
        List {
            Section {
                SelectedSurahView(viewModel: viewModel)
            }
            // MARK: - Select verses for translation
            Section {
                SelectTranslationVersesView(viewModel: viewModel)
            }
            // MARK: Select Verses For Words Meaning
            Section {
                SelectVersesForWordsMeaningView(viewModel: viewModel)
            }
        }
        .navigationTitle("Prepare Quiz")
    }
}

#Preview {
    ApplicationMainView()
}
