//
//  SelectedSurahView.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 25/09/2023.
//

import SwiftUI
import QuranKit

/// Use the ``QuizView`` for the preview
struct SelectedSurahView: View {
    @ObservedObject var viewModel: QuizView.ViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Selected Surah")
                    .font(.caption)
                NavigationLink(value: viewModel.suras) {
                    VStack {
                        SuraNameView(for: viewModel.selectedSurah)
                    }
                }
                .navigationDestination(for: [Sura].self) { suras in
                    SuraListView(
                        suras: suras,
                        selectedSura: $viewModel.selectedSurah
                    )
                }
            }
            Spacer(minLength: AppStyle.Spacing.space16)
            Image(systemName: "chevron.right.circle")
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundStyle(Color.accentColor)
        }
        .padding(AppStyle.Spacing.space16)
        .background(Color.gray.opacity(0.18))
        .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
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
