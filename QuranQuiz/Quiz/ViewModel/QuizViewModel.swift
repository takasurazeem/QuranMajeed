//
//  QuizViewModel.swift
//  Quran
//
//  Created by Takasur Azeem on 30/07/2023.
//  Copyright © 2023 Takasur Azeem. All rights reserved.
//

import Foundation

extension QuizView {
    class ViewModel: ObservableObject {
        
        init() {
            selectedAyahNumber = 1
            surahs = []
            selectedVerse = ""
            selectedSurah = Bundle.main.decode(SurahElement.self, from: "Al-Fatihah.json")
            surahs = Bundle.main.decode(Surahs.self, from: "Quran.json")
            setTextForSelectedAya()
        }
        
        func setTextForSelectedAya() {
            for surah in surahs {
                if surah.id == selectedSurah.id {
                    for verse in selectedSurah.verses {
                        if verse.id == selectedAyahNumber {
                            selectedVerse = verse.text
                        }
                    }
                }
            }
        }

        @Published var selectedAyahNumber: Int
        @Published var selectedSurah: SurahElement
        @Published var surahs: Surahs
        @Published private(set) var selectedVerse: String
    }
}
