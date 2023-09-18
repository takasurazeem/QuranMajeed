//
//  LoggingAnalyticsLibrary.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 18/09/2023.
//

import VLogging
import Analytics

struct LoggingAnalyticsLibrary: AnalyticsLibrary {
    func logEvent(_ name: String, value: String) {
        logger.info("[Analytics] \(name)=\(value)")
    }
}
