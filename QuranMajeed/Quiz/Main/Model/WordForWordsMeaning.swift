//
//  WordOfQuran.swift
//  QuranMajeed
//
//  Created by Takasur A. on 26/09/2023.
//

import Foundation

struct WordForWordsMeaning: Identifiable, Hashable, Comparable {
    static func < (lhs: WordForWordsMeaning, rhs: WordForWordsMeaning) -> Bool {
        lhs.id < rhs.id
    }
    
    var id: Double
    let word: String
}
