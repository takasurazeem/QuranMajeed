//
//  MainQuranProvider.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 15/09/2023.
//

import QuranKit
import QuranTextKit

struct MainQuranProvider: QuranProvider {
    func getQuranKit() -> Quran {
        Quran.madani
    }
    func getQuranTextKit() -> QuranTextKit.QuranTextDataService {
        fatalError("Need to learn this.")
    }
}
