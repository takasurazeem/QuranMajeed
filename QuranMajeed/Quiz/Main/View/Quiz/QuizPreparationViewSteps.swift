//
//  QuizPreparationViewSteps.swift
//  Al-Tanzeel
//
//  Created by Takasur Azeem on 23/10/2023.
//  Copyright © 2023 Islam. All rights reserved.
//

import SwiftUI
import QuranKit

struct QuizPreparationViewSteps: View {
    @ObservedObject var viewModel: QuizView.ViewModel
    var body: some View {
        List {
            Section {
                // Date picker with date only, do not let select past date and not more than 7 days in advance
                DatePicker(
                    "Quiz Date",
                    selection: $viewModel.quizDate,
                    in: Date()...Date().addingTimeInterval(
                        7 * 24 * 60 * 60
                    ),
                    displayedComponents: .date
                )
                .environment(
                    \.calendar,
                     Calendar(
                        identifier: .islamicUmmAlQura
                     )
                )
            }
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
        .navigationDestination(for: [Sura].self) { suras in
            SuraListView(
                suras: suras,
                selectedSura: $viewModel.selectedSurah
            )
        }
        .navigationTitle("Prepare Quiz")
    }
}

#Preview {
    ApplicationMainView()
}
