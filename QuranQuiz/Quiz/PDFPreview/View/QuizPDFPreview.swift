//
//  QuizPDFPreview.swift
//  QuranQuiz
//
//  Created by Takasur Azeem on 31/07/2023.
//

import SwiftUI
import PDFKit

struct QuizPDFPreview: View {
    var documentData: Data?
    var body: some View {
        VStack {
            // Using the PDFKitView and passing the previously created pdfURL
            if let documentData {
                PDFKitView(documentData: documentData)
            }
        }
        .navigationTitle("PDF Preview")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if let documentData, let document = PDFDocument(data: documentData) {
                    ShareLink(item: document, preview: SharePreview("PDF"))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            QuizPDFPreview(
                documentData: PDFCreator(
                    title: "Quiz",
                    verses: []
                )
                .createFlyer()
            )
        }
    }
}
