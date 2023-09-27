//

import SwiftUI

class ContentViewModel: ObservableObject {
    
    @Published var originalItems: [String] = """
آمَنَ الرَّسُولُ بِمَا أُنزِلَ إِلَيْهِ مِن رَّبِّهِ وَالْمُؤْمِنُونَ ۚ كُلٌّ آمَنَ بِاللَّهِ وَمَلَائِكَتِهِ وَكُتُبِهِ وَرُسُلِهِ لَا نُفَرِّقُ بَيْنَ أَحَدٍ مِّن رُّسُلِهِ ۚ وَقَالُوا سَمِعْنَا وَأَطَعْنَا ۖ غُفْرَانَكَ رَبَّنَا وَإِلَيْكَ الْمَصِيرُ(۲۸۵) لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا ۚ لَهَا مَا كَسَبَتْ وَعَلَيْهَا مَا اكْتَسَبَتْ ۗ رَبَّنَا لَا تُؤَاخِذْنَا إِن نَّسِينَا أَوْ أَخْطَأْنَا ۚ رَبَّنَا وَلَا تَحْمِلْ عَلَيْنَا إِصْرًا كَمَا حَمَلْتَهُ عَلَى الَّذِينَ مِن قَبْلِنَا ۚ رَبَّنَا وَلَا تُحَمِّلْنَا مَا لَا طَاقَةَ لَنَا بِهِ ۖ وَاعْفُ عَنَّا وقفہ وَاغْفِرْ لَنَا وقفہ وَارْحَمْنَا وقفہ ۚ أَنتَ مَوْلَانَا فَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ(۲۸۶)
""".split(separator: " ").map(String.init)
    
    @Published var spacing: CGFloat = 8
    @Published var padding: CGFloat = 8
    @Published var wordCount: Int = 79
    @Published var alignmentIndex = 2
    
    var words: [String] {
        Array(originalItems.prefix(wordCount))
    }
    
    let alignments: [HorizontalAlignment] = [.leading, .center, .trailing]
    
    var alignment: HorizontalAlignment {
        alignments[alignmentIndex]
    }
}

struct ContentView: View {
    @StateObject var model = ContentViewModel()
    
    var body: some View {
        ScrollView {
            FlexibleView(
                data: model.words,
                spacing: model.spacing,
                alignment: model.alignment
            ) { item in
                Text(verbatim: item)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.2))
                    )
            }
            .padding(.horizontal, model.padding)
        }
//        .overlay(Settings(model: model), alignment: .bottom)
    }
}

struct Settings: View {
    @ObservedObject var model: ContentViewModel
    let alignmentName: [String] = ["leading", "center", "trailing"]
    
    var body: some View {
        VStack {
            Stepper(value: $model.wordCount, in: 0...model.originalItems.count) {
                Text("\(model.wordCount) words")
            }
            
            HStack {
                Text("Padding")
                Slider(value: $model.padding, in: 0...60) { Text("") }
            }
            
            HStack {
                Text("Spacing")
                Slider(value: $model.spacing, in: 0...40) { Text("") }
            }
            
            HStack {
                Text("Alignment")
                Picker("Choose alignment", selection: $model.alignmentIndex) {
                    ForEach(0..<model.alignments.count, id: \.self) {
                        Text(alignmentName[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Button {
                model.originalItems.shuffle()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
