//
//  SelectTranslationVersesView.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 25/09/2023.
//

import SwiftUI

/// Use the ``QuizView`` for the preview
struct SelectTranslationVersesView: View {
    @ObservedObject var viewModel: QuizView.ViewModel
    var body: some View {
        DisclosureGroup(
            "Select Translation Verses",
            isExpanded: $viewModel.expandSelectVersesSection
        ) {
            NavigationLink {
                VerseListView(
                    allVerses: viewModel.versesOfSelectedSura,
                    selectedVerses: $viewModel.selectedVerses
                )
            } label: {
                HStack {
                    Spacer()
                    Text(viewModel.selectedVerse.text)
                    Spacer()
                }
            }
            .deleteDisabled(true)
            if !viewModel.selectedVerses.isEmpty {
                DisclosureGroup(
                    "Selected Verses",
                    isExpanded: $viewModel.expandSelectedVersesSection
                ) {
                    ForEach(viewModel.selectedVerses) { verse in
                        HStack {
                            Text(("\(verse.ayaNumber)"))
                            Text(verse.text)
                                .font(Font.custom("ScheherazadeNew-Bold", size: 24.0))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    .onDelete(perform: viewModel.delete(at:))
                }
            }
        }
    }
}
