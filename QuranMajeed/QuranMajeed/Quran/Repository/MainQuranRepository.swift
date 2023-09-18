//
//  MainQuranRepository.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 15/09/2023.
//

import Foundation
import QuranKit

struct MainQuranRepository: QuranRepository {
    
    init(
        quranService: QuranService
    ) throws {
        self.theQuranService = quranService
    }
    
    func getSuras() -> [Sura] {
        theQuranService.getSuras()
    }
    
    func getFirstSura() -> Sura {
        theQuranService.getFirstSura()
    }
    
    func getTextFor(verses: [AyahNumber]) async throws -> [String] {
       try await theQuranService.getTextFor(verses: verses)
    }
    
    private let theQuranService: QuranService
}
