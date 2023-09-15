//
//  QuranDataDependencyContainer.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 15/09/2023.
//

import Foundation

struct QuranDataDependencyContainer {
    init(providerForQuran: QuranProvider) {
        self.providerForQuran = providerForQuran
    }
    
    func makeQuranRepository() throws -> QuranRepository {
        try MainQuranRepository(quranService: try makeQuranService())
    }
    
    private func makeQuranService() throws -> QuranService {
        try MainQuranService(providerForQuran: providerForQuran)
    }
    
    private let providerForQuran: QuranProvider
}
