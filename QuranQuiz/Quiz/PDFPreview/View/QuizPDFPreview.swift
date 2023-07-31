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
            Image(systemName: "doc.viewfinder")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("PDF Viewer")
                .foregroundColor(.accentColor)
            // Using the PDFKitView and passing the previously created pdfURL
            if let documentData {
                PDFKitView(documentData: documentData)
                if let document = PDFDocument(data: documentData) {
                    ShareLink(item: document, preview: SharePreview("PDF"))
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuizPDFPreview(
            documentData: PDFCreator(
                title: "Quiz",
                verses: []
            )
            .createFlyer()
        )
    }
}
