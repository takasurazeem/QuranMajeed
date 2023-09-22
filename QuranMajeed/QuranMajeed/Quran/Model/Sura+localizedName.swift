//
//  Sura+localizedName.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 18/09/2023.
//

import QuranKit
import Localization
import Foundation

extension Sura {
    public var localizedSuraNumber: String {
        NumberFormatter.shared.format(suraNumber)
    }

    public func localizedName(withPrefix: Bool = false, withNumber: Bool = false, language: Language? = nil) -> String {
        var suraName = l("sura_names[\(suraNumber - 1)]", table: .suras, language: language)
        if withPrefix {
            suraName = lFormat("quran_sura_title", table: .android, language: language, suraName)
        }
        if withNumber {
            suraName = "\(localizedSuraNumber). \(suraName)"
        }
        return suraName
    }
}

