//
//  FlexibleViewContainerViewModel.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 28/09/2023.
//

import Foundation
import SwiftUI
import Combine

extension FlexibleViewContainer {
    class ViewModel: ObservableObject {
        
        init(originalItems: Binding<[WordForWordsMeaning]>) {
            self._originalItems = originalItems
            wordCount = originalItems.count
        }
        
        @Binding var originalItems: [WordForWordsMeaning]
        @Published var spacing: CGFloat = 8
        @Published var padding: CGFloat = 8
        @Published var wordCount: Int
        @Published var alignmentIndex = 2
        
//        var words: [WordForWordsMeaning] {
//            originalItems
//            //Array(originalItems.prefix(wordCount))
//        }
        
        let alignments: [HorizontalAlignment] = [.leading, .center, .trailing]
        
        var alignment: HorizontalAlignment {
            alignments[alignmentIndex]
        }
    }
}
