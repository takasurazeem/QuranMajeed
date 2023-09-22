//
//  MainQuranService.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 15/09/2023.
//

import QuranKit
import QuranText
import QuranTextKit
import AppDependencies
import Foundation

struct MainQuranService: QuranService {
    init(
        providerForQuran: QuranProvider
    ) {
        self.providerForQuran = providerForQuran
        self.theQuranKit = providerForQuran.getQuranKit()
        self.theQuranTextDataService = providerForQuran.getQuranTextDataService()
    }
    
    func getQuran() -> Quran {
        theQuranKit
    }
    
    func getSuras() -> [Sura] {
        theQuranKit.suras
    }
    
    func getFirstSura() -> Sura {
        theQuranKit.suras[0]
    }
    
    func getTranslatedVerses(
        verses: [AyahNumber]
    ) async throws -> TranslatedVerses {
        try await theQuranTextDataService.textForVerses(verses)
    }
    
    func getQuranTranslations() -> [UrduTranslatedSuras] {
        Bundle.main.decode([UrduTranslatedSuras].self, from: providerForQuran.getQuranTranslationProviderName())
    }
    
    private let providerForQuran: QuranProvider
    private let theQuranKit: Quran
    private let theQuranTextDataService: QuranTextDataService
}



