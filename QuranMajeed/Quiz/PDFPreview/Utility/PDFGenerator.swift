//
//  PDFCreator.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 31/07/2023.
//

import PDFKit
import Foundation
import SwiftUI

class PDFGenerator {
    init(
        verses: [QuizVerse],
        words: [WordForWordsMeaning],
        preferences: QuizPreferences
    ) {
        self.verses = verses
        self.words = words.filter { $0.isSelected }
        self.preferences = preferences

        // 1
        pdfMetaData = [
            kCGPDFContextCreator: "Quiz Builder",
            kCGPDFContextAuthor: "takasurazeem@gmail.com"
        ]
        format = UIGraphicsPDFRendererFormat()
        // 2
        pageWidth   = 595.2
        pageHeight  = 841.0
        pageRect    = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

        // 3
        renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        rightAndLeftHeadingTextAttributes = [
            NSAttributedString.Key.font: leftRightHeadingsFont
        ]
    }

    /// This method uses the injected QuizVerses to generate the quiz and calls internal methods
    /// - Returns: Data that can be used by `PDFKitView`
    func generateQuiz() -> Data {
        format.documentInfo = pdfMetaData as [String: Any]

        // 4
        let data = renderer.pdfData { (context) in
            // 5
            context.beginPage()
            addBorder(
                context: context,
                pageRect: pageRect
            )
            drawQuizHeaders()
            var yPosForNextTask = drawVerses(context)
            drawWordsMeanings(
                context: context,
                yPos: &yPosForNextTask
            )
        }

        return data
    }

    private func addBorder(
        context: UIGraphicsPDFRendererContext,
        pageRect: CGRect  // Assuming pageRect is passed to the function
    ) {
        // Set the line width and color for the border
        context.cgContext.setLineWidth(8.0)  // Adjust the border width as needed
        context.cgContext.setStrokeColor(UIColor.black.cgColor)  // Adjust the border color

        // Define a custom pattern for the border (e.g., a dashed pattern)
        let customPattern: [CGFloat] = [8, 4, 2, 4, 2, 4]  // Adjust the values for your custom pattern

        // Set the line dash pattern with a custom pattern
        context.cgContext.setLineDash(phase: 0, lengths: customPattern)

        // Calculate the border rectangle based on the page size (assuming pageRect is provided)
        let borderRect = CGRect(x: 0, y: 0, width: pageRect.width, height: pageRect.height)

        // Draw a border around the entire page with the custom pattern
        context.cgContext.addRect(borderRect)
        context.cgContext.strokePath()
    }

    private func addFancyBorder(
        context: UIGraphicsPDFRendererContext,
        pageRect: CGRect
    ) {
        // Set a thicker line width for a bold border
        context.cgContext.setLineWidth(4.0)

        // Create a custom pattern with varying dash lengths
        let customPattern: [CGFloat] = [12, 8, 4, 8, 4, 12]

        // Set the line dash pattern with the custom pattern
        context.cgContext.setLineDash(phase: 0, lengths: customPattern)

        context.cgContext.setStrokeColor(UIColor.black.cgColor)

        // Draw a custom shape, such as a rounded rectangle, for the border
        let cornerRadius: CGFloat = 8.0
        let borderPath = UIBezierPath(roundedRect: pageRect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        context.cgContext.addPath(borderPath.cgPath)

        // Draw a shadow for a 3D effect
        context.cgContext.setShadow(offset: CGSize(width: 3, height: 3), blur: 5.0)

        // Stroke the border
        context.cgContext.strokePath()
    }

    func drawWordsMeanings(
        context: UIGraphicsPDFRendererContext,
        yPos: inout CGFloat
    ) {
        let textFont = verseFont
        // 1
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        paragraphStyle.lineBreakMode = .byWordWrapping
        // 2
        let verseTextAttributes = makeVerseTextAttributes(paragraphStyle, textFont)
        let pageRectMaxY = pageRect.maxY
        let boundedWidth = pageRect.width - 20
        let xOffset = boundedWidth / 3 // 3 words in a row
        var xPos = 2.0
        for (index, word) in words.enumerated() {
            let attributedVerseText = NSAttributedString(
                string: word.word,
                attributes: verseTextAttributes
            )
            let wordTextHeight = attributedVerseText.height(containerWidth: xOffset)
            if yPos + wordTextHeight > pageRectMaxY - 5 {
                context.beginPage()
                addBorder(
                    context: context,
                    pageRect: pageRect
                )
                yPos = 5
            }
            let wordTextRect = CGRect(
                x: xOffset * xPos,
                y: yPos,
                width: xOffset,
                height: wordTextHeight
            )
            attributedVerseText.draw(in: wordTextRect)
            xPos -= 1
            if (index + 1).isMultiple(of: 3) {
                yPos += 45
                xPos = 2
            }
        }
    }

    /// This method takes context and draw verses in that context
    /// - Parameter context: ``UIGraphicsPDFRendererContext``
    /// - Returns: yPos for the next task
    func drawVerses(
        _ context: UIGraphicsPDFRendererContext
    ) -> CGFloat {
        var yPos = studentNameRowYPos + 45
        for verse in verses {
            let nextPost = addVerseText(
                context: context,
                verse: verse,
                textTop: yPos
            )
            yPos = nextPost
        }
        return yPos
    }

    /// This method adds verse and empty horizontal lines required to write answer for that verse.
    /// - Parameters:
    ///   - context: This context is passed down to `drawLineBreak` method as  context.cgContext
    ///   - verse: The verse with its text and translation
    ///   - textTop: The Y Position of the text where it should be drawn
    /// - Returns: Y Position for the next text to be drawn.
    private func addVerseText(
        context: UIGraphicsPDFRendererContext,
        verse: QuizVerse,
        textTop: CGFloat
    ) -> CGFloat {
        var textPos = textTop
        let textFont = verseFont
        // 1
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        paragraphStyle.lineBreakMode = .byWordWrapping
        // 2
        let verseTextAttributes = makeVerseTextAttributes(paragraphStyle, textFont)
        let attributedVerseText = NSAttributedString(
            string: " ✤\t" + verse.text + "  ❍",
            attributes: verseTextAttributes
        )
        let translationTextAttributes = makeTranslationTextAttributes(paragraphStyle)
        // FIXME: -
        let attributedTranslationText = NSAttributedString(
            string: verse.translatedText,
            attributes: translationTextAttributes
        )
        // I think I will move the above properties to a better place ان شاء اللہ تَعَالٰی
        // 3
        let width = pageRect.width - 20
        let verseTextHeight = attributedVerseText.height(containerWidth: width)
        //        let translationTextHeight = attributedTranslationText.height(containerWidth: width)
        var verseTextRect = CGRect(
            x: 10,
            y: textPos,
            width: width,
            height: verseTextHeight
        )
        /*
         let translationTextRect = CGRect(
         x: 10,
         y: verseTextRect.maxY + 10,
         width: width,
         height: translationTextHeight
         )
         */
        let numberOfLines = attributedTranslationText.numberOfLines(with: pageRect.width)
        let verseTextMaxY = verseTextRect.maxY
        let pageRectMaxY = pageRect.maxY
        if verseTextMaxY > pageRectMaxY - 5 {
            context.beginPage()
            addBorder(
                context: context,
                pageRect: pageRect
            )
            textPos = 5
        }
        verseTextRect = CGRect(
            x: 10,
            y: textPos,
            width: width,
            height: verseTextHeight
        )
        attributedVerseText.draw(in: verseTextRect)
        // The text is drawn now, space the text from text's y + line's height
        textPos = verseTextRect.maxY
        //        attributedTranslationText.draw(in: translationTextRect)
        let lineHeight = 35.0
        var yOffSet = textPos + lineHeight
        for number in 1...numberOfLines {
            if yOffSet > pageRect.maxY - 5 {
                context.beginPage()
                addBorder(
                    context: context,
                    pageRect: pageRect
                )
                yOffSet = lineHeight
            }
            if number > 1 {
                yOffSet += lineHeight
            }
            drawLineBreak(
                drawContext: context.cgContext,
                pageRect: pageRect,
                yOffset: yOffSet
            )
        }

        return yOffSet + 8
    }

    /// This method draws in a horizontal rule
    /// - Parameters:
    ///   - drawContext: Context in which you draw
    ///   - pageRect: Rect in which the rule will be drawn
    ///   - numberOfLines: Number of lines (horizontal rule) to draw,
    ///   - yOffset: Y Position of the line in the rect.
    private func drawLineBreak(
        drawContext: CGContext,
        pageRect: CGRect,
        yOffset: Double
    ) {
        // 2
        drawContext.saveGState()
        // 3
        drawContext.setLineWidth(1.0)

        // 4
        drawContext.move(to: CGPoint(x: 5, y: yOffset))
        drawContext.addLine(to: CGPoint(x: pageRect.width - 5, y: yOffset))
        drawContext.strokePath()
        drawContext.restoreGState()
    }

    // TODO: - Use AppStorage, some of these will be set from a settings menu for more flexibility in future ان شاء اللہ تَعَالٰی
    // MARK: - Fonts
    let theOpeningFont = UIFont(name: "_PDMS_Saleem_QuranFont", size: 20) ?? .boldSystemFont(ofSize: 64)
    let verseFont = UIFont(name: "ScheherazadeNew-Bold", size: 20) ?? .boldSystemFont(ofSize: 64)
    let leftRightHeadingsFont = UIFont(name: "NotoNastaliqUrdu", size: 10) ?? .boldSystemFont(ofSize: 64)
    let belowOpeningTextFont = UIFont(name: "DiwaniBent", size: 20) ?? .boldSystemFont(ofSize: 64)
    let nameAndDateTextFont = UIFont(name: "NotoNastaliqUrdu", size: 14) ?? .boldSystemFont(ofSize: 64)

    // MARK: - Shared Attributes
    let rightAndLeftHeadingTextAttributes: [NSAttributedString.Key: UIFont]

    // MARK: - Texts
    let theOpeningText = "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ"
    let belowOpeningText = NSLocalizedString("Weekly Test", comment: "Middle heading")
    let studentNameText = NSLocalizedString("Name: ____________________", comment: "") // "نام طالب علم:"
    let nameUnderScores = Array(repeating: "_", count: 20).reduce("", +)
    let dateText = NSLocalizedString("Date:", comment: "")
    let translateFollowingAyahsText  = NSLocalizedString("Translate the following verses", comment: "")

    // MARK: - MetaData
    let pdfMetaData: [CFString: String]
    let renderer: UIGraphicsPDFRenderer
    let format: UIGraphicsPDFRendererFormat

    // MARK: - Page Dimensions (A4 right now, but this will as well be configurablein in near future ان شاء اللہ تَعَالٰی
    let pageWidth: Double
    let pageHeight: Double
    let pageRect: CGRect

    // MARK: - Dependencies
    private let verses: [QuizVerse]
    private let words: [WordForWordsMeaning]
    private let preferences: QuizPreferences
}

extension PDFGenerator {

    private func makeTranslationTextAttributes(_ paragraphStyle: NSMutableParagraphStyle) -> [NSAttributedString.Key: Any] {
        return [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: leftRightHeadingsFont.withSize(15.0),
            NSAttributedString.Key.writingDirection: [NSWritingDirection.rightToLeft.rawValue],
            NSAttributedString.Key.languageIdentifier: "ur_PK"
        ] as [NSAttributedString.Key: Any]
    }

    private func makeVerseTextAttributes(_ paragraphStyle: NSMutableParagraphStyle, _ textFont: UIFont) -> [NSAttributedString.Key: Any] {
        return [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont.withSize(18),
            NSAttributedString.Key.writingDirection: [NSWritingDirection.rightToLeft.rawValue],
            NSAttributedString.Key.languageIdentifier: "ar_SA"
        ] as [NSAttributedString.Key: Any]
    }

    private func drawQuizHeaders() {
        // 6
        drawOpening()
        drawRightHeadingText()
        drawLeftHeadingText()
        drawBelowOpeningText()
        drawStudentNameField()
        drawDateField()
    }

    private func drawOpening() {
        let openingAttributes = [
            NSAttributedString.Key.font: theOpeningFont
        ]
        theOpeningText.draw(
            at: CGPoint(
                x: (pageWidth) / 2 - theOpeningText.width(usingFont: theOpeningFont) / 2,
                y: 5
            ),
            withAttributes: openingAttributes
        )
    }

    private func drawRightHeadingText() {
        let rightHeadingTextWidth = preferences.quizHeader.topRightText.width(usingFont: leftRightHeadingsFont)
        preferences.quizHeader.topRightText.draw(
            at: CGPoint(
                x: pageWidth - rightHeadingTextWidth - (rightHeadingTextWidth * 0.1),
                y: 5
            ),
            withAttributes: rightAndLeftHeadingTextAttributes
        )
    }

    private func drawLeftHeadingText() {
        preferences.quizHeader.topLeftText.draw(
            at: CGPoint(
                x: 10,
                y: 5
            ),
            withAttributes: rightAndLeftHeadingTextAttributes
        )
    }

    private func drawBelowOpeningText() {
        let belowOpeningTextAttributes = [
            NSAttributedString.Key.font: belowOpeningTextFont
        ]
        belowOpeningText.draw(
            at: CGPoint(
                x: (pageWidth) / 2 - belowOpeningText.width(usingFont: belowOpeningTextFont) / 2,
                y: theOpeningText.heightOfString(usingFont: theOpeningFont)
            ),
            withAttributes: belowOpeningTextAttributes
        )
    }

    private func drawStudentNameField() {
        let nameFieldAttributes = [
            NSAttributedString.Key.font: nameAndDateTextFont
        ]
        let studentNameTextWidth = studentNameText.width(usingFont: nameAndDateTextFont)
        studentNameText.draw(
            at: CGPoint(
                x: pageWidth - studentNameTextWidth - (studentNameTextWidth * 0.1),
                y: studentNameRowYPos
            ),
            withAttributes: nameFieldAttributes
        )
    }
    /*
     "\(dateText) \(date)".draw(
     at: CGPoint(
     x: dateTextXPos,
     y: studentNameRowYPos
     ),
     withAttributes: nameFieldAttributes
     )
     */
    private func drawDateField() {
        let fullText = "\(dateText) \(date)"
        let dateRange = (fullText as NSString).range(of: date)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.font, value: nameAndDateTextFont, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: dateRange)

        attributedString.draw(
            at: CGPoint(
                x: 15,
                y: studentNameRowYPos
            )
        )
    }

    var studentNameRowYPos: CGFloat {
        belowOpeningText.heightOfString(usingFont: belowOpeningTextFont) + theOpeningText.heightOfString(usingFont: theOpeningFont)
    }

    var dateTextXPos: CGFloat {
        date.width(usingFont: nameAndDateTextFont) + 20
    }

    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let formattedDate = dateFormatter.string(from: Date())
        return formattedDate
    }
}
