//
//  VersesSelectionDetailsView.swift
//  Al-Tanzeel
//
//  Created by Takasur Azeem on 28/10/2023.
//  Copyright © 2023 Islam. All rights reserved.
//

import SwiftUI

struct VersesSelectionDetailsView: View {
    @ObservedObject var viewModel: QuizView.ViewModel
    var selectedVersesForTranslationText: LocalizedStringKey {
        "You selected \(viewModel.selectedVersesForTranslation.count) verses for translation."
    }
    
    var body: some View {
        List {
            Section {
                NavigationLink {
                    VerseListView(
                        allVerses: viewModel.versesOfSelectedSura,
                        selectedVerses: $viewModel.selectedVersesForTranslation
                    )
                } label: {
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading, spacing: AppStyle.Spacing.space12) {
                                Text("Please tap on the row to select verses.")
                                    .font(.caption)
                            }
                        }
                    }
                    .padding(.vertical, AppStyle.Spacing.space16)
                }
            }
            Section {
                if !viewModel.selectedVersesForTranslation.isEmpty {
                    Text(selectedVersesForTranslationText)
                        .multilineTextAlignment(.leading)
                        .font(.footnote)
                        .foregroundStyle(Color.accentColor.opacity(0.9))
                    ForEach(viewModel.selectedVersesForTranslation.indices, id:\.self) { index in
                        VStack(spacing: AppStyle.Spacing.space12) {
                            HStack {
                                Text(viewModel.selectedVersesForTranslation[index].text)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, AppStyle.Spacing.space4)
                                    .padding(.horizontal, AppStyle.Spacing.space8)
                            }
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button {
                                viewModel.deleteTranslationVerse(at: IndexSet(integer: index))
                            } label: {
                                Image(systemName: "book.closed")
                            }
                        }
                    }
                    .padding(.top, AppStyle.Spacing.space8)
                }
            }
        }
        .navigationTitle("Select Verses")
    }
}

#Preview {
    ApplicationMainView()
        .environment(\.locale, Locale(identifier: "ur_Arab_PK"))
        .environment(\.layoutDirection, .rightToLeft)
}
