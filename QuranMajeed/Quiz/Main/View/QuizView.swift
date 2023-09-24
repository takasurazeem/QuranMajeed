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
            VStack {
                ScrollViewReader { proxy in
                    List {
                        SelectedSurahView(viewModel: viewModel)
                        SelectTranslationVersesView(viewModel: viewModel)
                        SelectVersesForWordsMeaningView(viewModel: viewModel)
                    }
                }
                .navigationTitle("Prepare Quiz")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink("PDF Preview") {
                            PDFKitView(
                                documentData: PDFGenerator(
                                    verses: viewModel.quizVerses
                                )
                                .generateQuiz()
                            )
                            .navigationTitle("PDF Preview")
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                // FIXME: - Not a good place to put it here. Move to a file of its own.
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    if let document = PDFDocument(data: PDFGenerator(
                                        verses: viewModel.quizVerses
                                    )
                                    .generateQuiz()) {
                                        ShareLink(item: document, preview: SharePreview("PDF"))
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .task {
                await viewModel.start()
            }
        }
    }
}


struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(
            viewModel: QuizView.ViewModel(
                theQuranRepository: try! AppDependencyContainer
                    .shared
                    .theQuranDependencyContainer
                    .makeQuranRepository()
            )
        )
    }
}
