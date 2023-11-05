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
        ScrollView {
            SelectedSurahView(viewModel: viewModel)
            // MARK: - Select verses for translation
            SelectTranslationVersesView(viewModel: viewModel)
            // MARK: Select Verses For Words Meaning
            SelectVersesForWordsMeaningView(viewModel: viewModel)
        }
        .padding(.horizontal, AppStyle.Spacing.space16)
        .navigationTitle("Prepare Quiz")
    }
}

#Preview {
    ApplicationMainView()
}
