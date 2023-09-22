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
            selectedVerse = Verse(id: UUID(), ayaNumber: 1, text: "", translation: "")
            selectedSurah = theQuranRepository.getFirstSura()
            urduQuran = theQuranRepository.getQuranTranslations()
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
                let translatedVerses = try await theQuranRepository.getTranslatedVerses(verses: selectedSurah.verses)
                versesOfSelectedSura = translatedVerses
                    .verses
                    .enumerated()
                    .map { (id, verse) in
                        let translation = urduQuran.first { $0.id == selectedSurah.suraNumber }?.verses.first { $0.id == id + 1 }?.translation ?? ""
                        let verse = Verse(ayaNumber: id + 1, text: verse.arabicText, translation: translation)
                        return verse
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
            _ = PDFGenerator(verses: selectedVerses.asQuizVerses(selectedSuraNumber: selectedSurah.suraNumber))
            
            
            return nil
        }
        
        private let theQuranRepository: QuranRepository
        
        @Published var selectedAyahNumber: Int
        @Published var selectedSurah: Sura
        @Published private(set)var versesOfSelectedSura: [Verse] = []
        @Published var suras: [Sura] = []
        @Published private(set) var selectedVerse: Verse
        @Published var selectedVerses: [Verse] = [] {
            didSet {
                quizVerses = selectedVerses.asQuizVerses(selectedSuraNumber: selectedSurah.suraNumber)
            }
        }
        private(set) var quizVerses: [QuizVerse] = []
        private let readingPreferences = ReadingPreferences.shared
        private let urduQuran: [UrduTranslatedSuras]
    }
}

extension Array where Element == Verse {
    func asQuizVerses(selectedSuraNumber: Int) -> [QuizVerse] {
        self.map {
            QuizVerse(verse: $0, selectedSuraNumber: selectedSuraNumber)
        }
    }
}
