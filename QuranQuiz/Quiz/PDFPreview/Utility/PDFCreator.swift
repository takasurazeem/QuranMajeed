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
            let font = UIFont(name: "_PDMS_Saleem_QuranFont", size: 24) ?? .boldSystemFont(ofSize: 24)
            // 6
            let attributes = [
                NSAttributedString.Key.font: font
            ]
            
            print("Text Width: \(theOpeningText.width(usingFont: font))")
            theOpeningText.draw(
                at: CGPoint(
                    x: pageWidth / 2 - theOpeningText.width(usingFont: font) / 2,
                    y: 5
                ),
                withAttributes: attributes
            )
        }
        
        return data
    }
    
    // TODO: - Use AppStorage, some of these will be set from a settings menu for more flexibility in future ان شاء اللہ تَعَالٰی 
    let theOpeningText = "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ"
    let leftHeadingText = ""
    let rightHeadingText = ""
    let belowOpeningText = ""
    let studentNameText = ""
    let dateText = ""
    let translateFollowingAyahsText = ""
    
    
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
