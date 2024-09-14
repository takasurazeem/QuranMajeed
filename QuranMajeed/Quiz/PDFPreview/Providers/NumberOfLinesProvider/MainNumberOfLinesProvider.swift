//
//  MainNumberOfLinesProvider.swift
//  Al-Tanzeel
//
//  Created by Takasur Azeem on 9/14/24.
//  Copyright © 2024 Islam. All rights reserved.
//

import Foundation

struct MainNumberOfLinesProvider: NumberOfLinesProvider {
    
    init(
        translationTextAttributesProvider: AttributedTranslationTextProvider,
        pageSizeProvider: PageSizeProvider
    ) {
        self.translationTextAttributesProvider = translationTextAttributesProvider
        self.pageSizeProvider = pageSizeProvider
    }
    
    func numberOfLines(
        for text: String,
        horizontalPadding: CGFloat = 10
    ) -> Int {
        translationTextAttributesProvider.makeAttributedTranslationText(for: text).numberOfLines(forWidth: pageSizeProvider.pageWidth - horizontalPadding)
    }
    
    private let translationTextAttributesProvider: AttributedTranslationTextProvider
    private let pageSizeProvider: PageSizeProvider
}
