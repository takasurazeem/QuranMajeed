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
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading, spacing: AppStyle.Spacing.space12) {
                        Text("Select verse for translation")
                            .font(.caption)
                        Text(viewModel.selectedVerse.text)
                            .font(.callout)
                    }
                    Spacer(minLength: AppStyle.Spacing.space16)
                    ChevronView()
                }
                VStack(alignment: .leading) {
                    Divider()
                        .background(Color.accentColor)
                    Text(
                        viewModel.selectedVersesForTranslation.isEmpty ? "Please tap on the row to select veress" : "Verses selected for translation: \(viewModel.selectedVersesForTranslation.count)"
                    )
                    .font(.footnote)
                    .foregroundStyle(Color.accentColor.opacity(0.9))
                    .padding(.top, AppStyle.Spacing.space4)
                }
                .padding(.top, AppStyle.Spacing.space8)
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
