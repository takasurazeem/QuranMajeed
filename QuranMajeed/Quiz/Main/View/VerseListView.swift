//
//  VerseListView.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 18/09/2023.
//

import SwiftUI

struct VerseListView: View {
    
    let verses: [Verse]
    
    var body: some View {
        List(verses) { verse in
            /*@START_MENU_TOKEN@*/Text(verse.text)/*@END_MENU_TOKEN@*/
                .frame(maxWidth: .infinity, alignment: .trailing)
                .multilineTextAlignment(.trailing)
        }
    }
}

struct VerseListView_Previews: PreviewProvider {
    @State static var verses: [Verse] = []
    static var previews: some View {
        VerseListView(verses: verses)
            .task {
                let repo = try! AppDependencyContainer
                    .shared
                    .theQuranDependencyContainer
                    .makeQuranRepository()
                if let verses = try? await repo.getTextFor(verses: repo.getFirstSura().verses) {
                    self.verses = verses.enumerated().map { Verse(id: $0 + 1, text: $1) }
                }
            }
    }
}
