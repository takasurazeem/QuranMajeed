//
//  WordOfQuran.swift
//  QuranMajeed
//
//  Created by Takasur A. on 26/09/2023.
//

import Foundation
import SwiftUI

struct WordForWordsMeaning: Identifiable, Hashable, Comparable, Equatable {
    static func < (lhs: WordForWordsMeaning, rhs: WordForWordsMeaning) -> Bool {
        lhs.id < rhs.id
    }

    static func == (lhs: WordForWordsMeaning, rhs: WordForWordsMeaning) -> Bool {
        lhs.word == rhs.word
    }

    var id: Double
    let word: String
    var isSelected = false

    func hash(into hasher: inout Hasher) {
        hasher.combine(word)
    }
}
