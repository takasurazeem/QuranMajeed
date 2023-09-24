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
                        if !viewModel.selectedVerses.isEmpty {
                            DisclosureGroup(
                                "Selected Verses",
                                isExpanded: $viewModel.expandSelectedVersesSection
                            ) {
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

/* FIXME: - Fix later
struct QuizView_Previews: PreviewProvider {
    static let quizVerses = Bundle.main.decode(Surahs.self, from: "Quran_ur.json").first(where: {$0.id==67})?.verses.compactMap({
        QuizVerse(
            surahId: 1,
            ayahId: $0.id,
            text: $0.text,
            translatedText: ""
        )
    })
    static var previews: some View {
        if let quizVerses {
            PDFKitView(
                documentData: PDFGenerator(
                    verses: quizVerses
                )
                .generateQuiz()
            )
            .previewDisplayName("PDF")
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
        }
        PDFKitView(
            documentData: PDFGenerator(
                verses:
                    Bundle.main.decode(SurahElement.self, from: "Al-Fatihah.json").verses.map({
                        QuizVerse(
                            surahId: 1,
                            ayahId: $0.id,
                            text: $0.text
                        )
                    })
            )
            .generateQuiz()
        )
        .previewDisplayName("PDF")
        QuizView(
            viewModel: QuizView.ViewModel(
                theQuranRepository: try! AppDependencyContainer
                    .shared
                    .theQuranDependencyContainer
                    .makeQuranRepository()
            )
        )
        .previewDevice("iPad Pro (12.9-inch) (6th generation)")
    }
}
*/
