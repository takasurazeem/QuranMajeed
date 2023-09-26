//
//  ChipContainerView.swift
//  CustomChipView
//
//  Created by Vasim Khan on 2/20/23.
//

import SwiftUI

struct ChipContainerView: View {
    @ObservedObject var viewModel: ChipsViewModel
    
    var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return GeometryReader { geo in
            ZStack(alignment: .topLeading) {
                if !viewModel.chipArray.isEmpty {
                    ForEach(viewModel.chipArray) { data in
                        ChipView(
                            titleKey: data.titleKey,
                            isSelected: data.isSelected
                        )
                        .padding(.all, 5)
                        .alignmentGuide(.leading) { dimension in
                            if (abs(width - dimension.width) > geo.size.width) {
                                width = 0
                                height -= dimension.height
                            }
                            let result = width
                            if data.id == viewModel.chipArray.last!.id {
                                width = 0
                            } else {
                                width -= dimension.width
                            }
                            return result
                        }
                        .alignmentGuide(.top) { dimension in
                            let result = height
                            if data.id == viewModel.chipArray.last!.id {
                                height = 0
                            }
                            return result
                        }
                    }
                }
            }
        }
    }
}

struct ChipContainerView_Previews: PreviewProvider {
    static var exampleWords: [ChipModel] {
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
            .map(ChipModel.init)
    }
    static var previews: some View {
            ChipContainerView(
                viewModel: ChipsViewModel(
                    chipArray: exampleWords
                )
            )
    }
}


fileprivate let ipsum = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."




