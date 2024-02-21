//
//  PDFPreviewView.swift
//  Al-Tanzeel
//
//  Created by Takasur Azeem on 23/10/2023.
//  Copyright © 2023 Islam. All rights reserved.
//

import SwiftUI
import PDFKit

struct PDFPreviewView: View {
    // FIXME: This entire implementation is a concept for a quick requirement as there's one more Masjid الحمدالله that is going to benefit fromt this. We will surely enhance this implementation with the best of the world. ان شاء اللہ تَعَالٰی
    @AppStorage("MasjidName") private var masjidName: String = ""
    @AppStorage("ClassName") private var className: String = ""
    @ObservedObject var viewModel: QuizView.ViewModel

    // Fix in the morning ان شاء اللہ تَعَالٰی , this needs to be passed from the previous screen.
    //    @State private var quizDate = Date.now

    var body: some View {
        NavigationLink {
            VStack {
                //                DatePicker(selection: $quizDate, in: Date.now..., displayedComponents: .date) {
                //                    Text("Select a date")
                //                }
                //                .padding()
                PDFKitView(
                    documentData: PDFGenerator(
                        verses: viewModel.quizVerses,
                        words: viewModel.wordsForWordsMeaning
                    )
                    .generateQuiz()
                )
                .navigationTitle("PDF Preview")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if let document = PDFDocument(data: PDFGenerator(
                            verses: viewModel.quizVerses,
                            words: viewModel.wordsForWordsMeaning
                        )
                        .generateQuiz()) {
                            ShareLink(item: document, preview: SharePreview("PDF"))
                        }
                    }
                }
            }
        } label: {
            if #available(iOS 17, *), !viewModel.selectedVersesForTranslation.isEmpty {
                Image(systemName: "doc.viewfinder")
                    .symbolEffect(.pulse)
            } else if !viewModel.selectedVersesForTranslation.isEmpty {
                Image(systemName: "doc.viewfinder")
                    .pulse(RoundedRectangle(cornerRadius: 4))
            } else {
                Image(systemName: "doc.viewfinder")
            }
        }
    }
}

#Preview {
    ApplicationMainView()
}
