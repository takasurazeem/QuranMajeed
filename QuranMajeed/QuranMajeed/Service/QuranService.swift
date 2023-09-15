//
//  QuranService.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 15/09/2023.
//

import Foundation

protocol QuranService {
    func loadQuran() throws
    func getSurahNames() throws -> [String]
    func getAyasFor(surah number: Int) throws -> [String]
    func getAyahFor(surahNumber: Int, ayahNumber: Int) throws -> String
}

