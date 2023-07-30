//
//  QuizView.swift
//  Quran
//
//  Created by Takasur Azeem on 30/07/2023.
//  Copyright © 2023 Takasur Azeem. All rights reserved.
//

import SwiftUI

struct QuizView: View {
    @StateObject var viewModel: ViewModel
    @State private var searchText: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Picker("Surah", selection: $viewModel.selectedSurah) {
                        ForEach(viewModel.surahs) { surah in
                            Text("\(surah.name) {\(surah.id)}")
                                .font(Font.custom("_PDMS_Saleem_QuranFont", size: 22.0))
                                .tag(surah)
                        }
                    }
                    Picker("Ayah", selection: $viewModel.selectedAyahNumber) {
                        ForEach(1...viewModel.selectedSurah.verses.count, id: \.self) { aya in
                            Text("\(aya)")
                        }
                    }
                    Text(viewModel.selectedVerse)
                        .font(Font.custom("_PDMS_Saleem_QuranFont", size: 24.0))
                        .multilineTextAlignment(.trailing)
                        .frame(maxWidth: .infinity)
                }
                
                Button("Add") {

                }
                .buttonStyle(PrimaryButtonStyle())
            }
            .navigationTitle("Prepare Quiz")
            .onChange(of: viewModel.selectedSurah) { _ in
                viewModel.setTextForSelectedAya()
            }
            .onChange(of: viewModel.selectedAyahNumber) { _ in
                viewModel.setTextForSelectedAya()
            }
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity)
            .frame(height: 45)
            .foregroundColor(.white)
            .background(Color(r: 32, g: 35, b: 37))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(16)
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(viewModel: QuizView.ViewModel())
    }
}

extension Color {
    
    init(
        r: Double,
        g: Double,
        b: Double
    ) {
        self.init(
            red: r/255,
            green: g/255,
            blue: b/255)
    }
    
}
