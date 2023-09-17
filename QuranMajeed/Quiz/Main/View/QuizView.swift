//
//  QuizView.swift
//  Quran
//
//  Created by Takasur Azeem on 30/07/2023.
//  Copyright © 2023 Takasur Azeem. All rights reserved.
//

import Localization
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
                        Section("Select Surah and Verse") {
                            Picker("Surah", selection: $viewModel.selectedSurah) {
                                ForEach(viewModel.suras) { sura in
                                    Text("\(sura.localizedName(withNumber: true, language: .arabic))")
                                        .font(Font.custom("ScheherazadeNew-Bold", size: 22.0))
                                        .tag(sura)
                                }
                            }
                            Picker("Ayah", selection: $viewModel.selectedAyahNumber) {
                                ForEach(1...viewModel.selectedSurah.verses.count, id: \.self) { aya in
                                    Text("\(aya)")
                                }
                            }
                            Text(viewModel.selectedVerse.text)
                                .font(Font.custom("ScheherazadeNew-Bold", size: 24.0))
                                .multilineTextAlignment(.trailing)
                                .frame(maxWidth: .infinity)
                        }
                        .deleteDisabled(true)
                        Section("Selected Verses") {
                            ForEach(viewModel.selectedVerses) { verse in
                                Text(verse.text)
                                    .font(Font.custom("ScheherazadeNew-Bold", size: 24.0))
                                    .multilineTextAlignment(.trailing)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                
//                                    .border(.red)
                            }
                            .onDelete(perform: viewModel.delete(at:))
                        }
                    }

                    Button("Add") {
                        viewModel.addSelectedVerseToQuiz()
                        proxy.scrollTo(viewModel.selectedVerses.last, anchor: .bottom)
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }
                .navigationTitle("Prepare Quiz")
                .onChange(of: viewModel.selectedSurah) { _ in
//                    viewModel.setTextForSelectedAya()
                }
                .onChange(of: viewModel.selectedAyahNumber) { _ in
//                    viewModel.setTextForSelectedAya()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink("PDF Preview") {
                            PDFKitView(
                                documentData: PDFGenerator(
                                    verses: viewModel.selectedVerses
                                )
                                .generateQuiz()
                            )
                            .navigationTitle("PDF Preview")
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                // FIXME: - Not a good place to put it here. Move to a file of its own.
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    if let document = PDFDocument(data: PDFGenerator(
                                        verses: viewModel.selectedVerses
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

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity)
            .frame(height: 45)
            .foregroundColor(.white)
            .background(Color(r: 32, g: 35, b: 37))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(16)
    }
}

struct QuizView_Previews: PreviewProvider {
    static let quizVerses = Bundle.main.decode(Surahs.self, from: "Quran_ur.json").first(where: {$0.id==67})?.verses.compactMap({
        QuizVerse(
            surahId: 1,
            ayahId: $0.id,
            text: $0.text
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

extension Color {
    
    init(
        r: Double,
        g: Double,
        b: Double
    ) {
        self.init(
            red: r/255,
            green: g/255,
            blue: b/255)
    }
    
}
