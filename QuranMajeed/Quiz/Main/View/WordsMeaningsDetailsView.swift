//
//  WordsMeaningsDetailsView.swift
//  Al-Tanzeel
//
//  Created by Takasur Azeem on 22/10/2023.
//  Copyright © 2023 Islam. All rights reserved.
//

import SwiftUI

struct WordsMeaningsDetailsView: View {
    @ObservedObject var viewModel: QuizView.ViewModel
    var body: some View {
        ScrollView {
            NavigationLink {
                VerseListView(
                    allVerses: viewModel.versesOfSelectedSura,
                    selectedVerses: $viewModel.selectedVersesForWordsMeaning
                )
            } label: {
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading, spacing: AppStyle.Spacing.space12) {
                            Text("Select ayas for words meaning")
                                .font(.caption)
                        }
                        Spacer(minLength: AppStyle.Spacing.space16)
                        ChevronView()
                    }
                    VStack(alignment: .leading, spacing: AppStyle.Spacing.space4) {
                        Divider()
                            .background(Color.accentColor)
                        Text(
                            viewModel.selectedVersesForWordsMeaning.isEmpty ? "Please tap on the row to select verses for words meanings." : "Verses selected for words meaning: \(viewModel.selectedVersesForWordsMeaning.count)"
                        )
                        .multilineTextAlignment(.leading)
                        .font(.footnote)
                        .foregroundStyle(Color.accentColor.opacity(0.9))
                        .padding(.top, AppStyle.Spacing.space4)
                    }
                    .padding(.top, AppStyle.Spacing.space8)
                }
            }
            .roundedCornersView()
            if !viewModel.selectedVersesForWordsMeaning.isEmpty {
                VStack(alignment: .leading, spacing: AppStyle.Spacing.space8) {
                    Text("Tap words to select them.")
                        .font(.subheadline)
                    FlexibleViewContainer(
                        viewModel: FlexibleViewContainer.ViewModel(
                            originalItems: $viewModel.wordsForWordsMeaning
                        )
                    )
                }
                .padding(.top, AppStyle.Spacing.space8)
            }
        }
        .navigationTitle("Select Words Meaning")
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
