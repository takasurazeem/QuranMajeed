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
        Quran.hafsMadani1440
    }
    func getShareableTextRetriever() -> ShareableVerseTextRetriever {
        ShareableVerseTextRetriever(
            databasesURL: container.databasesURL,
            quranFileURL: container.quranUthmaniV2Database
        )
    }
    func getQuranTextKit() -> Void {
        fatalError("Need to learn this.")
    }
    
    private let container = AppDependencyContainer.shared
}
