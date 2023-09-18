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

struct MainQuranService: QuranService {
    init(
        providerForQuran: QuranProvider
    ) {
        self.providerForQuran = providerForQuran
        self.theQuranKit = providerForQuran.getQuranKit()
        self.shareableTextRetriever = providerForQuran.getShareableTextRetriever()
    }
    
    func getSuras() -> [Sura] {
        theQuranKit.suras
    }
    
    func getFirstSura() -> Sura {
        theQuranKit.suras[0]
    }
    
    func getTextFor(
        verses: [AyahNumber]
    ) async throws -> [String] {
        try await shareableTextRetriever.textForVerses(verses)
    }
    
    private let providerForQuran: QuranProvider
    private let theQuranKit: Quran
    private let shareableTextRetriever: ShareableVerseTextRetriever
}



