//
//  QuizSettingsViewModel.swift
//  Al-Tanzeel
//
//  Created by Takasur A. on 19/02/2024.
//  Copyright © 2024 Islam. All rights reserved.
//

import SwiftUI

extension QuizSettingsView {

    class QuizSettingsViewModel: ObservableObject {

        init() { }

        @AppStorage("MasjidName") private var masjidName: String = ""
        @AppStorage("ClassName") private var className: String = ""
    }
}
