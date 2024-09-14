//
//  AttributedTranslationTextProvider.swift
//  Al-Tanzeel
//
//  Created by Takasur Azeem on 9/14/24.
//  Copyright © 2024 Islam. All rights reserved.
//

import UIKit

protocol AttributedTranslationTextProvider {
    func makeAttributedTranslationText(for string: String) -> NSAttributedString
    var textParagraphStyle: NSMutableParagraphStyle { get }
}
