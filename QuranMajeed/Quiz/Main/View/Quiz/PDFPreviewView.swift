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
    @ObservedObject var viewModel: QuizView.ViewModel
    @State private var showingIOS16OnlyAlert = false
    var body: some View {
        NavigationLink {
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
                        if #available(iOS 16.0, *) {
                            ShareLink(item: document, preview: SharePreview("PDF"))
                        } else {
                            // FIXME: - Fallback on earlier versions
                            EmptyView()
                                .onAppear {
                                    showingIOS16OnlyAlert = true
                                }
                                .alert("iOS 16 only feature", isPresented: $showingIOS16OnlyAlert) {
                                    Button("Ok") {
                                        showingIOS16OnlyAlert = false
                                    }
                                }
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
