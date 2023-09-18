//
//  QuranRepository.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 15/09/2023.
//

import QuranKit

protocol QuranRepository {
    func getSuras() -> [Sura]
    func getFirstSura() -> Sura
    func getTextFor(verses: [AyahNumber]) async throws -> [String]
}
