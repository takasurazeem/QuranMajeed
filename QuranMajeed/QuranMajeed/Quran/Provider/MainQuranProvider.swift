//
//  MainQuranProvider.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 15/09/2023.
//

import QuranKit
import QuranTextKit
import AppDependencies

struct MainQuranProvider: QuranProvider {
    func getQuranKit() -> Quran {
        Quran.hafsMadani1440
    }
    
    func getQuranTextDataService() -> QuranTextDataService {
        AppDependencyContainer.shared.textDataService()
    }
}
