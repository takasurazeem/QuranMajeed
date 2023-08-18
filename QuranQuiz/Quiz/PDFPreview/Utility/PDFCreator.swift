//
//  PDFCreator.swift
//  QuranQuiz
//
//  Created by Takasur Azeem on 31/07/2023.
//

import PDFKit

class PDFCreator {
    init(
        title: String,
        verses: [QuizVerse]
    ) {
        self.title = title
        self.verses = verses
    }
    
    
    func generateQuiz() -> Data {
        // 1
        let pdfMetaData = [
          kCGPDFContextCreator: "Quiz Builder",
          kCGPDFContextAuthor: "takasurazeem@gmail.com",
          kCGPDFContextTitle: title
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        // 2
        let pageWidth = 8.5 * 72.0
        print("Page Width: \(pageWidth)")
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        // 3
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        // 4
        let data = renderer.pdfData { (context) in
            // 5
            context.beginPage()
            let theOpeningFont = UIFont(name: "_PDMS_Saleem_QuranFont", size: 24) ?? .boldSystemFont(ofSize: 24)
            let leftRightHeadingsFont = UIFont(name: "_PDMS_Saleem_QuranFont", size: 18) ?? .boldSystemFont(ofSize: 16)
            // 6
            let openingAttributes = [
                NSAttributedString.Key.font: theOpeningFont
            ]
            
            let rightHeadingTextAttributes = [
                NSAttributedString.Key.font: leftRightHeadingsFont
            ]
            
//            print("Text Width: \(theOpeningText.width(usingFont: theOpeningFont))")
            theOpeningText.draw(
                at: CGPoint(
                    x: (pageWidth) / 2 - theOpeningText.width(usingFont: theOpeningFont) / 2,
                    y: 5
                ),
                withAttributes: openingAttributes
            )
            let rightHeadingTextWidth = rightHeadingText.width(usingFont: leftRightHeadingsFont)
            rightHeadingText.draw(
                at: CGPoint(
                    x: pageWidth - rightHeadingTextWidth - (rightHeadingTextWidth * 0.1),
                    y: 5
                ),
                withAttributes: rightHeadingTextAttributes
            )
            let leftHeadingTextWidth = leftHeadingText.width(usingFont: leftRightHeadingsFont)
            print("leftHeadingTextWidth Width: \(leftHeadingTextWidth)")
            leftHeadingText.draw(
                at: CGPoint(
                    x: 5,
                    y: 5
                ),
                withAttributes: rightHeadingTextAttributes
            )
        }
        
        return data
    }
    
    // TODO: - Use AppStorage, some of these will be set from a settings menu for more flexibility in future ان شاء اللہ تَعَالٰی
    let theOpeningText = "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ"
    let rightHeadingText = "امن ترجمةالقرآن کلاس"
    let leftHeadingText = "جامع مسجد امن واپڈا ٹاؤن گوجراںوالہ"
    let belowOpeningText = "سلسلہ وار ٹیسٹ"
    let studentNameText = "_______________________:نام طالب علم"
    let dateText = "بتاریخ:"
    let translateFollowingAyahsText = "درج زیل آیات ترجمہ لکھیں:"
    
    
    private let title: String
    private let verses: [QuizVerse]
}


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
}
