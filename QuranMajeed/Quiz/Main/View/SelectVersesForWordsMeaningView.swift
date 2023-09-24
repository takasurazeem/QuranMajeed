//
//  SelectVersesForWordsMeaningView.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 25/09/2023.
//

import SwiftUI

/// Use the ``QuizView`` for the preview
struct SelectVersesForWordsMeaningView: View {
    @ObservedObject var viewModel: QuizView.ViewModel
    var body: some View {
        DisclosureGroup(
            "Select Verses For Words Meaning",
            isExpanded: $viewModel.expandSelectVersesForWordsMeaningSection
        ) {
            NavigationLink {
                VerseListView(
                    allVerses: viewModel.versesOfSelectedSura,
                    selectedVerses: $viewModel.selectedVersesForWordsMeaning
                )
            } label: {
                HStack {
                    Spacer()
                    Text(viewModel.selectedVerse.text)
                    Spacer()
                }
            }
            .deleteDisabled(true)
            if !viewModel.selectedVersesForWordsMeaning.isEmpty {
                DisclosureGroup(
                    "Selected Verses",
                    isExpanded: $viewModel.expandSelectedVersesSection
                ) {
                    ForEach(viewModel.selectedVersesForWordsMeaning) { verse in
                        HStack {
                            Text(("\(verse.ayaNumber)"))
                            Text(verse.text)
                                .font(Font.custom("ScheherazadeNew-Bold", size: 24.0))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    .onDelete(perform: viewModel.deleteWordsMeaningVerse(at:))
                }
            }
        }
    }
}
