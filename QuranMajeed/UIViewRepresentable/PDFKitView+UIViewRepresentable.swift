//
//  PDFKitView+UIViewRepresentable.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 01/08/2023.
//

import PDFKit
import SwiftUI

struct PDFKitView: UIViewRepresentable {
    public var documentData: Data?

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

            let lastPage = document.page(at: document.pageCount - 1)
            lastPage?.addAnnotation(annotation)
            pdfView.autoScales = true
        }

        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: UIViewRepresentableContext<PDFKitView>) {
        // TODO
    }
}
