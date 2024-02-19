//
//  UrduTranslation.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 23/09/2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let urduTranslation = try? JSONDecoder().decode(UrduTranslation.self, from: jsonData)

import Foundation

// MARK: - UrduTranslationElement
struct UrduTranslatedSuras: Decodable, Hashable {
    static func == (lhs: UrduTranslatedSuras, rhs: UrduTranslatedSuras) -> Bool {
        lhs.id == rhs.id
    }

    let id: Int
    let name: String
    let translation: String
    let verses: [VerseTranslation]
}

// MARK: - Verse
struct VerseTranslation: Decodable, Hashable {
    let id: Int
    let translation: String
}
