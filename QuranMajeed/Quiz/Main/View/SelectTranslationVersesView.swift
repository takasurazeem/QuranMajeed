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
    var rowFooterText: LocalizedStringKey {
        viewModel.selectedVersesForTranslation.isEmpty ?
        "Please tap on the row to select verses." : "You selected \(viewModel.selectedVersesForTranslation.count) verses for translation."
    }
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
                    Text(rowFooterText)
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
    ApplicationMainView()
}
