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
        NavigationLink {
            WordsMeaningsDetailsView(viewModel: viewModel)
                .padding(AppStyle.Spacing.space16)
        } label: {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading, spacing: AppStyle.Spacing.space12) {
                        Text("Select words meaning.")
                            .font(.caption)
                    }
                    Spacer(minLength: AppStyle.Spacing.space16)
                    ChevronView()
                }
                VStack(alignment: .leading, spacing: AppStyle.Spacing.space4) {
                    Divider()
                        .background(Color.accentColor)
                    Text(
                        viewModel.selectedVersesForWordsMeaning.isEmpty ? 
                        "Please tap on the row to select words meanings." : "Words selected for words meaning \(viewModel.wordsForWordsMeaning.filter{$0.isSelected}.count)."
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
