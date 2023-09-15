//
//  MainQuranProvider.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 15/09/2023.
//

import QuranSDK

struct MainQuranProvider: QuranProvider {
    func getQuran() -> QuranDatabase {
        QuranDatabase()
    }
}
