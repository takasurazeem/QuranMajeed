//
//  QuranService.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 15/09/2023.
//

import QuranKit

protocol QuranService {
    func getSuras() -> [Sura]
    func getFirstSura() -> Sura
    func getAyasFor(surah number: Int) -> [String]
    func getAyahFor(surahNumber: Int, ayahNumber: Int) -> String
}

