//
//  MainAttributedTranslationTextProvider.swift
//  Al-Tanzeel
//
//  Created by Takasur Azeem on 9/14/24.
//  Copyright © 2024 Islam. All rights reserved.
//


import UIKit

struct MainAttributedTranslationTextProvider: AttributedTranslationTextProvider {
    func makeAttributedTranslationText(for string: String) -> NSAttributedString {
        NSAttributedString(
            string: string,
            attributes: makeTranslationTextAttributes()
        )
    }
    
    private func makeTranslationTextAttributes() -> [NSAttributedString.Key: Any] {
        let paragraphStyle = textParagraphStyle
        return [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: AppStyle.PDF.leftRightHeadingsFont.withSize(16.0),
            NSAttributedString.Key.writingDirection: [NSWritingDirection.rightToLeft.rawValue],
            NSAttributedString.Key.languageIdentifier: "ur_PK"
        ] as [NSAttributedString.Key: Any]
    }
    
    var textParagraphStyle: NSMutableParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        paragraphStyle.lineBreakMode = .byWordWrapping
        return paragraphStyle
    }
}
