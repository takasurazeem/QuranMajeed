//
//  MainQuranService.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 15/09/2023.
//

import QuranSDK

struct MainQuranService: QuranService {
    init() throws {
        self.quran = QuranDatabase()
        try loadQuran()
    }
    
    func loadQuran() throws {
        try self.quran.openDatabase()
    }
    
    func getSurahNames() throws -> [String] {
        try quran.getSurahNames()
    }
    
    func getAyasFor(surah number: Int) throws -> [String] {
        try quran.getAyahsInSurah(number)
    }
    
    func getAyahFor(surahNumber: Int, ayahNumber: Int) throws -> String {
        try quran.getAyah(surahNumber: surahNumber, ayahNumber: ayahNumber)
    }
    
    private let quran: QuranDatabase
}
