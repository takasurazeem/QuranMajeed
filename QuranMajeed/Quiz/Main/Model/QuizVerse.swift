//
//  QuizVerse.swift
//  QuranMajeed
//
//  Created by Takasur A. on 26/09/2023.
//

import Foundation

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
