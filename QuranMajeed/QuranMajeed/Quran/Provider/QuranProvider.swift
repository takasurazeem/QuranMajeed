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
    func getQuranTextDataService() -> QuranTextDataService
    // TODO: Remove this method and get `getTranslatedVerses` to return translation as well. However TEMPORARILY we are relying on the JSON file that contains the tranlsations we need.
    func getQuranTranslationProviderName() -> String
}
