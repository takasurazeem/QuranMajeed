//
//  QuranProvider.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 15/09/2023.
//

import QuranKit
import QuranTextKit

protocol QuranProvider {
    func getQuranKit() -> Quran
    func getQuranTextKit() -> Void
    func getShareableTextRetriever() -> ShareableVerseTextRetriever
}
