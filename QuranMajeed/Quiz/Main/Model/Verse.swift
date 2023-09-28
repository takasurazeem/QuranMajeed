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
