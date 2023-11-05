//
//  PDFDocument+Transferable.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 01/08/2023.
//

import PDFKit
import SwiftUI

extension PDFDocument: Transferable {
    @available(iOS 16.0, *)
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
