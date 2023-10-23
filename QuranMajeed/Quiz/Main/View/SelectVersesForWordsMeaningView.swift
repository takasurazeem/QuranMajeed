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
    var rowFooterText: LocalizedStringKey {
        viewModel.selectedVersesForWordsMeaning.isEmpty ?
        "Please tap on the row to select words for words meanings." : "You selected \(viewModel.wordsForWordsMeaning.filter{$0.isSelected}.count) words for words meaning."
    }
    
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
                    Text(rowFooterText)
                        .multilineTextAlignment(.leading)
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
