//
//  QuizViewModel.swift
//  Quran
//
//  Created by Takasur Azeem on 30/07/2023.
//  Copyright © 2023 Islam. All rights reserved.
//

import Foundation
import PDFKit
import QuranKit
import ReadingService
import SwiftUI

extension QuizView {
    class ViewModel: ObservableObject {
        
        init(
            theQuranRepository: QuranRepository,
            quizPreferencesRepository: QuizPreferencesRepository,
            pageSizeProvider: PageSizeProvider,
            attributedTranslationTextProvider: AttributedTranslationTextProvider,
            numberOfLinesProvider: NumberOfLinesProvider
        ) {
            self.numberOfLinesProvider = numberOfLinesProvider
            self.pageSizeProvider = pageSizeProvider
            self.attributedTranslationTextProvider = attributedTranslationTextProvider
            self.theQuranRepository = theQuranRepository
            self.quizPreferencesRepository = quizPreferencesRepository
            selectedAyahNumber = 1
            selectedVerse = Verse(ayaNumber: 1, text: "", translation: "", numberOfLinesForTranslation: 1)
            selectedSurah = theQuranRepository.getFirstSura()
            urduQuran = theQuranRepository.getQuranTranslations()
            
            // set quizDate to the current date
            quizDate = Date()
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
                        let verse = Verse(
                            ayaNumber: id + 1,
                            text: verse.arabicText,
                            translation: translation,
                            numberOfLinesForTranslation: numberOfLinesProvider.numberOfLines(
                                for: translation,
                                horizontalPadding: 10
                            )
                        )
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

        func deleteTranslationVerse(at offsets: IndexSet) {
            selectedVersesForTranslation.remove(atOffsets: offsets)
        }

        func deleteWordsMeaningVerse(at offsets: IndexSet) {
            selectedVersesForWordsMeaning.remove(atOffsets: offsets)
        }

        private let theQuranRepository: QuranRepository
        
        @Published var quizDate: Date = .now
        @Published var expandSelectedVersesForTranslationSection = false
        @Published var expandSelectedVersesForWordsMeaningSection = false
        @Published var expandSelectVersesForTranslationSection = true
        @Published var expandSelectVersesForWordsMeaningSection = true
        @Published var selectedAyahNumber: Int
        @Published var selectedSurah: Sura
        @Published private(set)var versesOfSelectedSura: [Verse] = []
        @Published var suras: [Sura] = []
        @Published private(set) var selectedVerse: Verse
        @Published var selectedVersesForWordsMeaning: [Verse] = [] {
            didSet {
                var words = Set<WordForWordsMeaning>()
                for verse in selectedVersesForWordsMeaning {
                    for (index, word) in verse.text.split(separator: " ").enumerated() {
                        words
                            .insert(
                                WordForWordsMeaning(
                                    id: Double(verse.id) + (Double("0.\(index)") ?? 0.1),
                                    word: String(word)
                                )
                            )
                    }
                }
                wordsForWordsMeaning.append(contentsOf: (Array(words).sorted()))
                wordsForWordsMeaning = wordsForWordsMeaning.uniqueWords
            }
        }
        @Published var wordsForWordsMeaning: [WordForWordsMeaning] = []
        @Published var selectedVersesForTranslation: [Verse] = [] {
            didSet {
                quizVerses = selectedVersesForTranslation.asQuizVerses(selectedSuraNumber: selectedSurah.suraNumber)
                expandSelectedVersesForTranslationSection = true
            }
        }
        private(set) var quizVerses: [QuizVerse] = []
        private let readingPreferences = ReadingPreferences.shared
        private let urduQuran: [UrduTranslatedSuras]
        private let quizPreferencesRepository: QuizPreferencesRepository
        private let pageSizeProvider: PageSizeProvider
        private let numberOfLinesProvider: NumberOfLinesProvider
        private let attributedTranslationTextProvider: AttributedTranslationTextProvider
        var pdfGenerator: PDFGenerator {
            PDFGenerator(
                numberOfLinesProvider: numberOfLinesProvider,
                pageSizeProvider: pageSizeProvider,
                attributedTranslationTextProvider: attributedTranslationTextProvider,
                verses: quizVerses,
                words: wordsForWordsMeaning,
                preferences: quizPreferencesRepository.get(),
                quizDate: quizDate
            )
        }
    }
}

extension Array where Element == Verse {
    func asQuizVerses(selectedSuraNumber: Int) -> [QuizVerse] {
        self.map {
            QuizVerse(
                verse: $0,
                selectedSuraNumber: selectedSuraNumber
            )
        }
    }
}

extension [WordForWordsMeaning] {
    var uniqueWords: Self {
        Array(Set<WordForWordsMeaning>(self)).sorted()
    }
}
