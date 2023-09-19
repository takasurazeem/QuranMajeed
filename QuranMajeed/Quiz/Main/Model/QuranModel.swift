//
//  QuranModel.swift
//  Quran
//
//  Created by Takasur Azeem on 30/07/2023.
//  Copyright © 2023 Takasur Azeem. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let surahNames = try? JSONDecoder().decode(SurahNames.self, from: jsonData)

import Foundation

// MARK: - SurahElement
struct SurahElement: Codable, Identifiable, Hashable {
    static func == (lhs: SurahElement, rhs: SurahElement) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: Int
    let name: String
//    let transliteration: String
//    let translation: String
//    let type: TypeEnum
    let totalVerses: Int
    let verses: [Verse]

    enum CodingKeys: String, CodingKey {
        case id, name //, type //, translation, transliteration,
        case totalVerses = "total_verses"
        case verses
    }
}

enum TypeEnum: String, Codable {
    case meccan = "meccan"
    case medinan = "medinan"
}

// MARK: - Verse
struct Verse: Codable, Identifiable, Hashable {
    var id: Int
    let text: String
//    let translation: String
}

typealias Surahs = [SurahElement]

struct QuizVerse: Identifiable, Hashable {
    let id = UUID()
    let surahId: Int
    let ayahId: Int
    let text: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(surahId)
        hasher.combine(ayahId)
        hasher.combine(text)
    }
}
