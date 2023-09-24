//
//  SelectedSurahView.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 25/09/2023.
//

import SwiftUI
import QuranKit

/// Use the ``QuizView`` for the preview
struct SelectedSurahView: View {
    @ObservedObject var viewModel: QuizView.ViewModel
    var body: some View {
        Section("Selected Surah") {
            NavigationLink(value: viewModel.suras) {
                VStack {
                    SuraNameView(for: viewModel.selectedSurah)
                }
            }
            .navigationDestination(for: [Sura].self) { suras in
                SuraListView(
                    suras: suras,
                    selectedSura: $viewModel.selectedSurah
                )
            }
        }
    }
}
