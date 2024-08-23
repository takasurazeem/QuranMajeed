//
//  String+size.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 24/08/2023.
//

import UIKit

extension String {

    func width(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }

    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }

    func size(font: UIFont, width: CGFloat) -> CGSize {
        let attrString = NSAttributedString(
            string: self,
            attributes: [NSAttributedString.Key.font: font]
        )
        let bounds = attrString.boundingRect(
            with: CGSize(
                width: width, height: .greatestFiniteMagnitude
            ),
            options: .usesLineFragmentOrigin, context: nil
        )
        let size = CGSize(
            width: bounds.width,
            height: bounds.height
        )
        return size
    }
}
