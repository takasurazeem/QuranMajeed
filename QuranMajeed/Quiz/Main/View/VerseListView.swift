//
//  VerseListView.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 18/09/2023.
//

import SwiftUI

struct VerseListView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.editMode) private var editMode
    @State var defaultEditMode = EditMode.active /// the edit mode
    @State private var searchText = ""
    @State private var selection = Set<Verse>()
    
    @Binding var selectedVerses: [Verse]
    var selectedSuraVerses: [Verse] = []
    var searchResults: [Verse] {
        if searchText.isEmpty {
            return selectedSuraVerses
        }
        return selectedSuraVerses
            .filter { "\($0.ayaNumber)".contains(searchText) }
    }
    
    var body: some View {
        List(searchResults, id: \.self, selection: $selection) { verse in
            HStack {
                Text(("\(verse.ayaNumber)"))
                Text(verse.text)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .multilineTextAlignment(.trailing)
            }
        }
        .environment(\.editMode, $defaultEditMode)
        .onDisappear {
            defaultEditMode = .inactive
        }
        .onChange(of: selection) { newValue in
            if newValue.count > 0 {
                selectedVerses = Array(selection).sorted()
            }
        }
        .onChange(of: editMode?.wrappedValue) { newValue in
            if newValue == EditMode.inactive {
                dismiss()
            } else {
                // Leaving edit mode (e.g. 'Done' tapped)
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("Ayah Selection")
//        .toolbar { EditButton() }
    }
}

struct VerseListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentPreview()
    }
}

fileprivate struct ContentPreview: View {
    @State var allVerses: [Verse] = []
    var body: some View {
        NavigationStack {
            VerseListView(selectedVerses: .constant([]), selectedSuraVerses: allVerses)
                .task {
                    let repo = try! AppDependencyContainer
                        .shared
                        .theQuranDependencyContainer
                        .makeQuranRepository()
                    if let verses = try? await repo.getTranslatedVerses(verses: repo.getFirstSura().verses).verses {
                        self.allVerses = verses.enumerated().map { Verse(ayaNumber: $0 + 1, text: $1.arabicText, translation: "") }
                    }
                }
        }
    }
}
