//
//  QuranModel.swift
//  Quran
//
//  Created by Takasur Azeem on 30/07/2023.
//  Copyright © 2023 Takasur Azeem. All rights reserved.
//

import Foundation

// MARK: - Verse
struct Verse: Codable, Identifiable, Hashable, Comparable {
    static func < (lhs: Verse, rhs: Verse) -> Bool {
        lhs.ayaNumber < rhs.ayaNumber
    }
    
    var id: Int { ayaNumber }
    var ayaNumber: Int
    var text: String
    let translation: String
}

struct QuizVerse: Identifiable, Hashable {
    
    init(
        surahId: Int,
        ayahId: Int,
        text: String,
        translatedText: String
    ) {
        self.surahId = surahId
        self.ayahId = ayahId
        self.text = text
        self.translatedText = translatedText
    }
    
    init(verse: Verse, selectedSuraNumber: Int) {
        surahId = selectedSuraNumber
        ayahId = verse.ayaNumber
        text = verse.text
        translatedText = verse.translation
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(surahId)
        hasher.combine(ayahId)
        hasher.combine(text)
    }
    
    let id = UUID()
    let surahId: Int
    let ayahId: Int
    let text: String
    let translatedText: String
}
