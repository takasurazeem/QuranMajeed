//
//  QuranRepository.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 15/09/2023.
//

import QuranKit
import QuranText

protocol QuranRepository {
    func getQuran() -> Quran
    func getSuras() -> [Sura]
    func getFirstSura() -> Sura
    func getTranslatedVerses(verses: [AyahNumber]) async throws -> TranslatedVerses
    
    var arabicBismillah: String { get }
}
