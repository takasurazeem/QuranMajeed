//
//  TagView.swift
//  EventApp
//
//  Created by Ahmadreza on 10/15/21.
//  Copyright © 2021 Alexani. All rights reserved.
//

import SwiftUI

struct TagViewItem: Hashable {
    
    var title: WordForWordsMeaning
    var isSelected: Bool = false
    
    static func == (lhs: TagViewItem, rhs: TagViewItem) -> Bool {
        return lhs.isSelected == rhs.isSelected
    }
    
    init(word: WordForWordsMeaning) {
        self.title = word
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(isSelected)
    }
}

struct TagView: View {
    @State var tags: [TagViewItem]
    @State private var totalHeight = CGFloat.zero       // << variant for ScrollView/List //    = CGFloat.infinity   // << variant for VStack
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)// << variant for ScrollView/List
        //.frame(maxHeight: totalHeight) // << variant for VStack
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return ZStack(alignment: .topLeading) {
            ForEach(tags.indices, id: \.self) { index in
                item(for: tags[index].title.word, isSelected: tags[index].isSelected)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tags[index].title == self.tags.last!.title {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tags[index].title == self.tags.last!.title {
                            height = 0 // last item
                        }
                        return result
                    }).onTapGesture {
                        tags[index].isSelected.toggle()
                    }
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(for text: String, isSelected: Bool) -> some View {
        Text(text)
            .foregroundColor(isSelected ? Color.blue : Color.white)
            .padding()
            .lineLimit(1)
            .background(isSelected ? Color.white : Color.blue)
            .frame(height: 36)
            .cornerRadius(18)
            .overlay(Capsule().stroke(Color.blue, lineWidth: 1))
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

#Preview {
    TagContentView()
}

fileprivate struct TagContentView: View {
    let ipsum = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
    var exampleWords: [TagViewItem] {
        var words = Set<WordForWordsMeaning>()
        for (lineIndex, line) in ipsum.split(separator: ".").enumerated() {
            for (index, word) in line.split(separator: " ").enumerated() {
                words
                    .insert(
                        WordForWordsMeaning(
                            id: Double(lineIndex) + (Double("0.\(index)") ?? 0.0),
                            word: String(word)
                        )
                    )
            }
        }
        return Array(words)
            .sorted()
            .map(TagViewItem.init)
    }
    var body: some View {
        VStack {
            TagView(
                tags: exampleWords
            )
            .border(.red)
        }
    }
}
