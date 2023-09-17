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
        self.quranService = quranService
    }
    
    func getSuras() -> [Sura] {
        quranService.getSuras()
    }
    
    func getFirstSura() -> Sura {
        quranService.getFirstSura()
    }
    
    func getAyasFor(
        surah number: Int
    ) -> [String] {
        quranService.getAyasFor(
            surah: number
        )
    }
    
    func getAyahFor(
        surahNumber: Int,
        ayahNumber: Int
    ) -> String {
        quranService.getAyahFor(
            surahNumber: surahNumber,
            ayahNumber: ayahNumber
        )
    }
    
    private let quranService: QuranService
}
