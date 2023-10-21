//
//  QuizView.swift
//  Quran
//
//  Created by Takasur Azeem on 30/07/2023.
//  Copyright © 2023 Takasur Azeem. All rights reserved.
//

import QuranKit
import SwiftUI
import PDFKit

struct QuizView: View {
    @StateObject var viewModel: ViewModel
    var body: some View {
        NavigationStack {
            VStack {
                    SelectedSurahView(viewModel: viewModel)
                // Select verses for translation
//                SelectTranslationVersesView(viewModel: viewModel)
//                SelectVersesForWordsMeaningView(viewModel: viewModel)
                Spacer()
            }
            .padding(.horizontal, AppStyle.Spacing.space16)
            .navigationTitle("Prepare Quiz")
            .toolbar {
                // MARK: - Right toolbar
                ToolbarItem(placement: .navigationBarTrailing) {
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
                            // FIXME: - Not a good place to put it here. Move to a file of its own.
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
                    } label: {
                        if #available(iOS 17, *), !viewModel.selectedVersesForTranslation.isEmpty {
                            Image(systemName: "doc.viewfinder")
                                .symbolEffect(.pulse)
                        } else {
                            Image(systemName: "doc.viewfinder")
                                .pulse(RoundedRectangle(cornerRadius: 4))
                        }
                    }
                }
                
                // MARK: - Left toolbar
//                    ToolbarItem(placement: .topBarLeading) {
//                        print("Top left")
//                    }
            }
            .task {
                await viewModel.start()
            }
        }
    }
}


struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(
            viewModel: QuizView.ViewModel(
                theQuranRepository: try! AppDependencyContainer
                    .shared
                    .theQuranDependencyContainer
                    .makeQuranRepository()
            )
        )
    }
}



// Kieran Brown
// Kieran's Components "Pulse and Sheen"
// https://kieranb662.github.io/blog/2020/04/17/Pulse-and-Sheen
struct PulseEffect<S: Shape>: ViewModifier {
    var shape: S
    @State var isOn: Bool = false
    var animation: Animation {
        Animation
            .easeIn(duration: 1)
            .repeatCount(8, autoreverses: false)
    }

    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    shape
                        .stroke(Color.accentColor, lineWidth: 1)
                        .scaleEffect(self.isOn ? 2 : 1)
                        .opacity(self.isOn ? 0 : 1)
                    shape
                        .stroke(Color.accentColor)
            })
            .onAppear {
                withAnimation(self.animation) {
                    self.isOn = true
                }
        }
    }
}

public extension View {
    func pulse<S: Shape>(_ shape: S) -> some View  {
        self.modifier(PulseEffect(shape: shape))
    }
}
