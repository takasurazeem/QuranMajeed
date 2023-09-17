//
//  QuranProvider.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 15/09/2023.
//

import QuranKit

protocol QuranProvider {
    func getQuranKit() -> Quran
    func getQuranTextKit() -> Void
}
