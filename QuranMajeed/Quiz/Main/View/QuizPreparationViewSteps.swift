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
            Group {
                SelectedSurahView(viewModel: viewModel)
                // MARK: - Select verses for translation
                SelectTranslationVersesView(viewModel: viewModel)
                // MARK: Select Verses For Words Meaning
                SelectVersesForWordsMeaningView(viewModel: viewModel)
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .foregroundColor(.accentColor)
        }
        .onAppear {
            UITableViewCell.appearance().selectionStyle = .none
        }
        .buttonStyle(PlainButtonStyle())
        .listRowSpacing(0)
        .listStyle(.plain)
        .navigationTitle("Prepare Quiz")
    }
}

#Preview {
    ApplicationMainView()
}
