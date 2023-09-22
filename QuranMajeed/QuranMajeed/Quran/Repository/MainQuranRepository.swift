//
//  MainQuranRepository.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 15/09/2023.
//

import Foundation
import QuranKit
import QuranText

struct MainQuranRepository: QuranRepository {
    
    init(
        quranService: QuranService
    ) throws {
        self.theQuranService = quranService
    }
    
    func getQuran() -> Quran {
        theQuranService.getQuran()
    }
    
    func getSuras() -> [Sura] {
        theQuranService.getSuras()
    }
    
    func getFirstSura() -> Sura {
        theQuranService.getFirstSura()
    }
    
    func getTranslatedVerses(verses: [AyahNumber]) async throws -> TranslatedVerses {
        try await theQuranService.getTranslatedVerses(verses: verses)
    }
    
    func getQuranTranslations() -> [UrduTranslatedSuras] {
        theQuranService.getQuranTranslations()
    }
    
    var arabicBismillah: String { "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَـٰنِ ٱلرَّحِیمِ" }
    private let theQuranService: QuranService
}
