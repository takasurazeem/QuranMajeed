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
                        Text("Select verses for translation.")
                            .font(.caption)
                        Text(viewModel.selectedVerse.text)
                            .font(.callout)
                    }
                    Spacer(minLength: AppStyle.Spacing.space16)
                    ChevronView()
                }
                VStack(alignment: .leading, spacing: AppStyle.Spacing.space4) {
                    Divider()
                        .background(Color.accentColor)
                    Text(
                        viewModel.selectedVersesForTranslation.isEmpty ? "Please tap on the row to select veress." : "Verses selected for translation: \(viewModel.selectedVersesForTranslation.count)."
                    )
                    .font(.footnote)
                    .foregroundStyle(Color.accentColor.opacity(0.9))
                    .padding(.top, AppStyle.Spacing.space4)
                }
                .padding(.top, AppStyle.Spacing.space8)
            }
        }
        .roundedCornersView()
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
