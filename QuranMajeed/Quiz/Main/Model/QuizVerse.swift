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
        translatedText: String,
        numberOfLinesForTranslation: Int
    ) {
        self.surahId = surahId
        self.ayahId = ayahId
        self.text = text
        self.translatedText = translatedText
        self.numberOfLinesForTranslation = numberOfLinesForTranslation
    }

    init(
        verse: Verse,
        selectedSuraNumber: Int
    ) {
        surahId = selectedSuraNumber
        ayahId = verse.ayaNumber
        text = verse.text
        translatedText = verse.translation
        self.numberOfLinesForTranslation = verse.numberOfLinesForTranslation
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(surahId)
        hasher.combine(ayahId)
        hasher.combine(text)
        hasher.combine(numberOfLinesForTranslation)
    }

    let id = UUID()
    let surahId: Int
    let ayahId: Int
    let text: String
    let translatedText: String
    var numberOfLinesForTranslation: Int
}
