//
//  QuizViewModel.swift
//  Quran
//
//  Created by Takasur Azeem on 30/07/2023.
//  Copyright © 2023 Takasur Azeem. All rights reserved.
//

import Foundation
import PDFKit
import QuranKit
import ReadingService

extension QuizView {
    class ViewModel: ObservableObject {
        
        init(
            theQuranRepository: QuranRepository
        ) {
            self.theQuranRepository = theQuranRepository
            selectedAyahNumber = 1
            selectedVerse = Verse(id: 1, text: "")
            selectedSurah = theQuranRepository.getFirstSura()
            
//            if let verse = selectedSurah.verses.first {
//                selectedVerse = verse
//            }
//            setTextForSelectedAya()
            
            // For testing only.
//            selectedVerses = surahs[4].verses[1...5].map { verse in
//                QuizVerse(surahId: surahs[4].id, ayahId: verse.id, text: verse.text, translation: verse.translation)
//            }
//            selectedVerses = surahs[0].verses.map { verse in
//                QuizVerse(surahId: surahs[4].id, ayahId: verse.id, text: verse.text, translation: verse.translation)
//            }
        }
        
        func start() async {
            async let suras: () = loadSuras()
            async let firstVerse: () = loadVersesOfFirstSurah()
            _ = await [suras, firstVerse]
        }
        
        @MainActor private func loadVersesOfFirstSurah() async {
            do {
                versesOfSelectedSura = try await theQuranRepository
                    .getTextFor(verses: selectedSurah.verses)[0]
                    .split(separator: "﴿")
                    .enumerated()
                    .map { (index, text) in
                        let snippet = String(text)
                        if let range = snippet.range(of: "﴾ ") {
                            let verse = snippet[range.upperBound...]
                            print(verse.trimmingCharacters(in: .whitespacesAndNewlines))
                        }
                        return Verse(id: index + 1, text: String(text))
                    }
                if let verse = versesOfSelectedSura.first {
                    selectedVerse = verse
                }
            } catch {
                // TODO: Show error if it occurs
            }
        }
        
        @MainActor private func loadSuras() async {
            let readings = readingPreferences.$reading
                .prepend(readingPreferences.reading)
                .values()

            for await reading in readings {
                suras = reading.quran.suras
            }
        }
        
        func addSelectedVerseToQuiz() {
//            if selectedVerses.contains(where: { verse in
//                (verse.surahId == selectedSurah.id && verse.ayahId == selectedVerse.id) || verse.text == selectedVerse.text
//            }) == false {
//                let verse = QuizVerse(
//                    surahId: selectedSurah.id,
//                    ayahId: selectedVerse.id,
//                    text: selectedVerse.text
//                )
//                print(verse)
//                selectedVerses.append(verse)
//            }
        }

        func delete(at offsets: IndexSet) {
            selectedVerses.remove(atOffsets: offsets)
        }
        
        func generatePDF() -> URL? {
            _ = PDFGenerator(verses: selectedVerses)
            
            
            return nil
        }
        
        private let theQuranRepository: QuranRepository
        
        @Published var selectedAyahNumber: Int
        @Published var selectedSurah: Sura
        @Published private(set) var versesOfSelectedSura: [Verse] = []
        @Published var suras: [Sura] = []
        @Published private(set) var selectedVerse: Verse
        @Published private(set) var selectedVerses: [QuizVerse] = []
        
        private let readingPreferences = ReadingPreferences.shared
    }
}
