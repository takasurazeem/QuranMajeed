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
    // TODO: Remove this method and get `getTranslatedVerses` to return translation as well. However TEMPORARILY we are relying on the JSON file that contains the tranlsations we need.
    func getQuranTranslations() -> [UrduTranslatedSuras]
    var arabicBismillah: String { get }
}
