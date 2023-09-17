//
//  MainQuranProvider.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 15/09/2023.
//

import QuranKit

struct MainQuranProvider: QuranProvider {
    func getQuranKit() -> Quran {
        Quran.hafsMadani1440
    }
    func getQuranTextKit() -> Void {
        fatalError("Need to learn this.")
    }
}
