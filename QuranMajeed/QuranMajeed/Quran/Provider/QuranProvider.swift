//
//  QuranProvider.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 15/09/2023.
//

import QuranSDK

protocol QuranProvider {
    func getQuran() -> QuranDatabase
}
