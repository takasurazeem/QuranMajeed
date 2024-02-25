//
//  QuizPreferencesRepository.swift
//  Al-Tanzeel
//
//  Created by Takasur A. on 19/02/2024.
//  Copyright © 2024 Islam. All rights reserved.
//

import Foundation

protocol QuizPreferencesDataStore {
    func save(quizPreferences: QuizPreferences)
    func get() -> QuizPreferences?
}
