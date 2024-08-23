//
//  FlexibleViewContainerSettings.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 28/09/2023.
//

import SwiftUI

/* THE FILE REFERENCE IS REMOVED TO KEEP DIRECTORY CLEAN */
struct FlexibleViewContainerSettings: View {
    @ObservedObject var viewModel: FlexibleViewContainer.ViewModel
    let alignmentName: [String] = ["leading", "center", "trailing"]

    var body: some View {
        VStack {
            Stepper(value: $viewModel.wordCount, in: 0...viewModel.originalItems.count) {
                Text("\(viewModel.wordCount) words")
            }

            HStack {
                Text("Padding")
                Slider(value: $viewModel.padding, in: 0...60) { Text("") }
            }

            HStack {
                Text("Spacing")
                Slider(value: $viewModel.spacing, in: 0...40) { Text("") }
            }

            HStack {
                Text("Alignment")
                Picker("Choose alignment", selection: $viewModel.alignmentIndex) {
                    ForEach(0..<viewModel.alignments.count, id: \.self) {
                        Text(alignmentName[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            Button {
                viewModel.originalItems.shuffle()
            } label: {
                Text("Shuffle")
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.primary, lineWidth: 4)
        )
        .padding()
    }
}
