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

// Add this:
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuizPDFPreview(documentData: PDFCreator(title: "Test", verses: []).createFlyer())
    }
}

extension PDFDocument: Transferable {
    public static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(contentType: .pdf) { pdf in
                if let data = pdf.dataRepresentation() {
                    return data
                } else {
                    return Data()
                }
            } importing: { data in
                if let pdf = PDFDocument(data: data) {
                    return pdf
                } else {
                    return PDFDocument()
                }
            }
        DataRepresentation(exportedContentType: .pdf) { pdf in
            pdf.dataRepresentation() ?? Data()
        }
     }
}
