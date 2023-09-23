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
    @State private var searchText: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                ScrollViewReader { proxy in
                    List {
                        Section("Selected Surah") {
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
                        Section("Select Verses") {
                            NavigationLink {
                                VerseListView(
                                    allVerses: viewModel.versesOfSelectedSura,
                                    selectedVerses: $viewModel.selectedVerses
                                )
                            } label: {
                                HStack {
                                    Text(viewModel.selectedVerse.text)
                                }
                            }
                        }
                        .deleteDisabled(true)
                        Section("Selected Verses") {
                            ForEach(viewModel.selectedVerses) { verse in
                                HStack {
                                    Text(("\(verse.ayaNumber)"))
                                    Text(verse.text)
                                        .font(Font.custom("ScheherazadeNew-Bold", size: 24.0))
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .multilineTextAlignment(.trailing)
                                }
                            }
                            .onDelete(perform: viewModel.delete(at:))
                        }
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
