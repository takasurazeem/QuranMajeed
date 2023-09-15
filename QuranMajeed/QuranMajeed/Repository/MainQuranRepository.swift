//
//  MainQuranRepository.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 15/09/2023.
//

import QuranSDK

struct MainQuranRepository: QuranRepository {
    
    init(
        quranService: QuranService
    ) throws {
        self.quranService = quranService
        try loadQuran()
    }
    
    func loadQuran() throws {
        try quranService.loadQuran()
    }
    
    func getSurahNames() throws -> [String] {
        try quranService.getSurahNames()
    }
    
    func getAyasFor(
        surah number: Int
    ) throws -> [String] {
        try quranService.getAyasFor(
            surah: number
        )
    }
    
    func getAyahFor(
        surahNumber: Int,
        ayahNumber: Int
    ) throws -> String {
        try quranService.getAyahFor(
            surahNumber: surahNumber,
            ayahNumber: ayahNumber
        )
    }
    
    private let quranService: QuranService
}
