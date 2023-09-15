//
//  QuranService.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 15/09/2023.
//

import QuranKit
import QuranTextKit

protocol QuranService {
    func getSuras() -> [Sura]
    func getAyasFor(surah number: Int) -> [String]
    func getAyahFor(surahNumber: Int, ayahNumber: Int) -> String
}

