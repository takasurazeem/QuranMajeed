//
//  QuizClass.swift
//  Al-Tanzeel
//
//  Created by Takasur A. on 19/02/2024.
//  Copyright © 2024 Islam. All rights reserved.
//

import Foundation

extension QuizPreferences {
    struct QuizClass: Codable, Hashable, Equatable, Identifiable {
        var id = UUID()
        var className: String
        var masjidName: String
        var isSelected: Bool = false
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(className)
            hasher.combine(masjidName)
        }
        
        static func == (lhs: QuizPreferences.QuizClass, rhs: QuizPreferences.QuizClass) -> Bool {
            (rhs.className == lhs.className) &&
            (rhs.masjidName == lhs.masjidName) &&
            (rhs.isSelected) == lhs.isSelected
        }
    }
}
