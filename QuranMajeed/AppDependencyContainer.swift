//
//  AppDependencyContainer.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 14/09/2023.
//

import Foundation

class AppDependencyContainer {
    private init() {
        self.theQuranProvider = MainQuranProvider()
    }
    
    static let shared = AppDependencyContainer()
    
    lazy var theQuranDependencyContainer: QuranDataDependencyContainer = {
        QuranDataDependencyContainer(providerForQuran: theQuranProvider)
    }()
    
    private let theQuranProvider: QuranProvider
}
