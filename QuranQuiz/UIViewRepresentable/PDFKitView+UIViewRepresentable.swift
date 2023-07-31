//
//  PDFKitView+UIViewRepresentable.swift
//  QuranQuiz
//
//  Created by Takasur Azeem on 01/08/2023.
//

import PDFKit
import SwiftUI

// TODO: - Set custom border
//class BorderAnnotation: PDFBorder {
//    override func draw(in rect: CGRect) {
//        super.draw(in: rect)
//        style = .dashed
//    }
//}
//
//class MainPDFViewDelegate: NSObject, PDFDocumentDelegate {
//
//    func `class`(forAnnotationType annotationType: String) -> AnyClass {
//        BorderAnnotation.self
//    }
//}


struct PDFKitView: UIViewRepresentable {
    public var documentData: Data?
//    let documentDelegate = MainPDFViewDelegate()
    
    func makeUIView(context: UIViewRepresentableContext<PDFKitView>) -> PDFView {
        // Creating a new PDFVIew and adding a document to it
        let pdfView = PDFView()
        if let documentData {
            let document = PDFDocument(data: documentData)!
            pdfView.document = document
            let bounds = pdfView.document!.page(at: document.pageCount - 1)!.bounds(for: .mediaBox).size
            let annotation = PDFAnnotation(
                bounds: CGRect(
                    x: 0,
                    y: 0,
                    width: bounds.width,
                    height: bounds.height
                ),
                forType: .square,
                withProperties: nil
            )
            
            let border = PDFBorder()
            border.style = .dashed
            border.lineWidth = 3
            
            annotation.border = border
            let lastPage = document.page(at: document.pageCount - 1)
            lastPage?.addAnnotation(annotation)
            // TODO: - Set custom border
//            document.delegate = documentDelegate
            pdfView.autoScales = true
        }

        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: UIViewRepresentableContext<PDFKitView>) {
        // TODO
    }
}
