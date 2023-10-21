//
//  QuizView.swift
//  Quran
//
//  Created by Takasur Azeem on 30/07/2023.
//  Copyright © 2023 Takasur Azeem. All rights reserved.
//

import QuranKit
import SwiftUI
import PDFKit

struct QuizView: View {
    @StateObject var viewModel: ViewModel
    var body: some View {
        NavigationStack {
            ScrollView {
                SelectedSurahView(viewModel: viewModel)
                // MARK: - Select verses for translation
                SelectTranslationVersesView(viewModel: viewModel)
                // MARK: Select Verses For Words Meaning
                SelectVersesForWordsMeaningView(viewModel: viewModel)
            }
            .padding(.horizontal, AppStyle.Spacing.space16)
            .navigationTitle("Prepare Quiz")
            .toolbar {
                // MARK: - Right toolbar
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        PDFKitView(
                            documentData: PDFGenerator(
                                verses: viewModel.quizVerses,
                                words: viewModel.wordsForWordsMeaning
                            )
                            .generateQuiz()
                        )
                        .navigationTitle("PDF Preview")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            // FIXME: - Not a good place to put it here. Move to a file of its own.
                            ToolbarItem(placement: .navigationBarTrailing) {
                                if let document = PDFDocument(data: PDFGenerator(
                                    verses: viewModel.quizVerses,
                                    words: viewModel.wordsForWordsMeaning
                                )
                                    .generateQuiz()) {
                                    ShareLink(item: document, preview: SharePreview("PDF"))
                                }
                            }
                        }
                    } label: {
                        if #available(iOS 17, *), !viewModel.selectedVersesForTranslation.isEmpty {
                            Image(systemName: "doc.viewfinder")
                                .symbolEffect(.pulse)
                        } else if !viewModel.selectedVersesForTranslation.isEmpty {
                            Image(systemName: "doc.viewfinder")
                                .pulse(RoundedRectangle(cornerRadius: 4))
                        } else {
                            Image(systemName: "doc.viewfinder")
                        }
                    }
                }
                
                // MARK: - Left toolbar
                //                    ToolbarItem(placement: .topBarLeading) {
                //                        print("Top left")
                //                    }
            }
            .task {
                await viewModel.start()
            }
        }
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
