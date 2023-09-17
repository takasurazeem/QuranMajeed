//
//  MainQuranService.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 15/09/2023.
//

import QuranKit

struct MainQuranService: QuranService {
    init(
        providerForQuran: QuranProvider
    ) {
        self.providerForQuran = providerForQuran
        self.theQuranKit = providerForQuran.getQuranKit()
        let anotherQuran = QuranKit.Quran.hafsMadani1405
    }
    
    func getSuras() -> [Sura] {
        theQuranKit.suras
    }
    
    func getAyasFor(
        surah number: Int
    ) -> [String] {
//        try theQuran.getAyahsInSurah(
//            number
//        )
        fatalError("work in progress")
    }
    
    func getAyahFor(
        surahNumber: Int,
        ayahNumber: Int
    ) -> String {
//        try theQuranKit.getAyah(
//            surahNumber: surahNumber,
//            ayahNumber: ayahNumber
//        )
        fatalError("work in progress")
    }
    
    private let providerForQuran: QuranProvider
    private let theQuranKit: Quran
}
