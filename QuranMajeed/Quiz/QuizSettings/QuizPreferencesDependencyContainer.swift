//
//  QuizPreferencesDependencyContainer.swift
//  Al-Tanzeel
//
//  Created by Takasur A. on 19/02/2024.
//  Copyright © 2024 Islam. All rights reserved.
//

import Foundation

class QuizPreferencesDependencyContainer {

    init(
        dataStore: SyncDatastore
    ) {
        self.dataStore = dataStore
    }
    
    func makePreferencesRepository() -> QuizPreferencesRepository {
        MainQuizPreferencesRepository(dataStore: dataStore)
    }

    private let dataStore: SyncDatastore
}
