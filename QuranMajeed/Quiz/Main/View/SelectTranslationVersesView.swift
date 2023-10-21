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
        NavigationLink {
            VerseListView(
                allVerses: viewModel.versesOfSelectedSura,
                selectedVerses: $viewModel.selectedVersesForTranslation
            )
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    Text("Selected verse")
                        .font(.caption)
                    Text(viewModel.selectedVerse.text)
                }
                Spacer(minLength: AppStyle.Spacing.space16)
                ChevronView()
            }
        }
        .roundedCornersView()
        /*DisclosureGroup(
            "Select verses for translation",
            isExpanded: $viewModel.expandSelectVersesForTranslationSection
        ) {
            NavigationLink {
                VerseListView(
                    allVerses: viewModel.versesOfSelectedSura,
                    selectedVerses: $viewModel.selectedVersesForTranslation
                )
            } label: {
                HStack {
                    Spacer()
                    Text(viewModel.selectedVerse.text)
                    Spacer()
                }
            }
            .deleteDisabled(true)
            if !viewModel.selectedVersesForTranslation.isEmpty {
                DisclosureGroup(
                    "Selected verses for translation",
                    isExpanded: $viewModel.expandSelectedVersesForTranslationSection
                ) {
                    ForEach(viewModel.selectedVersesForTranslation) { verse in
                        HStack {
                            Text(("\(verse.ayaNumber)"))
                            Text(verse.text)
                                .font(Font.custom("ScheherazadeNew-Bold", size: 24.0))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    .onDelete(perform: viewModel.deleteTranslationVerse(at:))
                }
            }
        }
         */
    }
}

#Preview {
    QuizView(
        viewModel: QuizView.ViewModel(
            theQuranRepository: try! AppDependencyContainer
                .shared
                .theQuranDependencyContainer
                .makeQuranRepository()
        )
    )
}

struct ChevronView: View {
    @Environment(\.layoutDirection) var layoutDirection
    var body: some View {
        Image(systemName: "chevron.\( layoutDirection == .rightToLeft ? "left" : "right")")
//            .resizable()
//            .frame(width: 24, height: 24)
            .foregroundStyle(Color.accentColor)
    }
}
