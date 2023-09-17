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
import Localization

extension QuizView {
    class ViewModel: ObservableObject {
        
        init(
            theQuranRepository: QuranRepository
        ) {
            self.theQuranRepository = theQuranRepository
            selectedAyahNumber = 1
            
            
            selectedVerse = Verse(id: 1, text: "")
            selectedSurah = Bundle.main.decode(SurahElement.self, from: "Al-Fatihah.json")
            
            if let verse = selectedSurah.verses.first {
                selectedVerse = verse
            }
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
            _ = await [suras]
        }
        
        private func loadSuras() async {
            let readings = readingPreferences.$reading
                .prepend(readingPreferences.reading)
                .values()

            for await reading in readings {
                DispatchQueue.main.async { [weak self] in
                    if let self {
                        self.suras = reading.quran.suras
                    }
                }
            }
        }
        
        func addSelectedVerseToQuiz() {
            if selectedVerses.contains(where: { verse in
                (verse.surahId == selectedSurah.id && verse.ayahId == selectedVerse.id) || verse.text == selectedVerse.text
            }) == false {
                let verse = QuizVerse(
                    surahId: selectedSurah.id,
                    ayahId: selectedVerse.id,
                    text: selectedVerse.text
                )
                print(verse)
                selectedVerses.append(verse)
            }
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
        @Published var selectedSurah: SurahElement
        @Published var suras: [Sura] = []
        @Published private(set) var selectedVerse: Verse
        @Published private(set) var selectedVerses: [QuizVerse] = []
        
        private let readingPreferences = ReadingPreferences.shared
    }
}



extension Sura {
    public var localizedSuraNumber: String {
        NumberFormatter.shared.format(suraNumber)
    }

    public func localizedName(withPrefix: Bool = false, withNumber: Bool = false, language: Language? = nil) -> String {
        var suraName = l("sura_names[\(suraNumber - 1)]", table: .suras, language: language)
        if withPrefix {
            suraName = lFormat("quran_sura_title", table: .android, language: language, suraName)
        }
        if withNumber {
            suraName = "\(localizedSuraNumber). \(suraName)"
        }
        return suraName
    }
}

