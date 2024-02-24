//
//  QuizPreferences.swift
//  Al-Tanzeel
//
//  Created by Takasur Azeem on 16/02/2024.
//  Copyright © 2024 Islam. All rights reserved.
//

import Foundation

struct QuizPreferences {
    struct QuizHeader {
        var topRightText: String
        var topLeftText: String
    }
    
    var quizHeader: QuizHeader
    var quizDate = Date.now
}
