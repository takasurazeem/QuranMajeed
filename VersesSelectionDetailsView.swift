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
//                        Spacer(minLength: AppStyle.Spacing.space16)
//                        ChevronView()
                    }
                    .padding(.top, AppStyle.Spacing.space8)
                }
            }
            .roundedCornersView()
            if !viewModel.selectedVersesForTranslation.isEmpty {
//                VStack(alignment: .leading) {
//                    Text(selectedVersesForTranslationText)
//                        .multilineTextAlignment(.leading)
//                        .font(.footnote)
//                        .foregroundStyle(Color.accentColor.opacity(0.9))
//                    List {
                        ForEach(viewModel.selectedVersesForTranslation) { verse in
                            VStack(spacing: AppStyle.Spacing.space12) {
                                HStack {
                                    Text(verse.text)
                                        .multilineTextAlignment(.leading)
                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                        .padding(.vertical, AppStyle.Spacing.space4)
//                                        .padding(.horizontal, AppStyle.Spacing.space8)
                                    Spacer()
                                }
//                                Divider()
                            }
                        }
                        .onDelete(perform: viewModel.deleteTranslationVerse(at:))
//                    }
//                    .background(Color.white)
//                    .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
//                }
                .roundedCornersView()
                .padding(.top, AppStyle.Spacing.space8)
            }
        }
//        .listStyle(.plain)
        .navigationTitle("Select Words")
    }
}

#Preview {
    ApplicationMainView()
        .environment(\.locale, Locale(identifier: "ur_Arab_PK"))
        .environment(\.layoutDirection, .rightToLeft)
}
