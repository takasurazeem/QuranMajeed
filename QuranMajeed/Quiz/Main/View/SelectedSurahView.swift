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
        NavigationLink(value: viewModel.suras) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Selected Surah")
                        .font(.caption)
                    SuraNameView(for: viewModel.selectedSurah)
                }
                Spacer(minLength: AppStyle.Spacing.space16)
                ChevronView()
            }
        }
        .navigationDestination(for: [Sura].self) { suras in
            SuraListView(
                suras: suras,
                selectedSura: $viewModel.selectedSurah
            )
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

struct  RoundedCornersModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(AppStyle.Spacing.space16)
            .background(Color.gray.opacity(0.18))
            .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
    }
}

extension View {
    func roundedCornersView() -> some View {
        modifier(RoundedCornersModifier())
    }
}
