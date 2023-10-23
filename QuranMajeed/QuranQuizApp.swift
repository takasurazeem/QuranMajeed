//
//  QuranMajeedApp.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 30/07/2023.
//

import SwiftUI
import FontBlaster

@main
struct QuranMajeedApp: App {
    
    init() {
        FontBlaster.blast()
#if DEBUG
        memoryUsage = Memory.formattedMemoryFootprint()
#endif
            
    }
    
    var body: some Scene {
        WindowGroup {
            QuizView(
                viewModel: QuizView.ViewModel(
                    theQuranRepository: try! AppDependencyContainer
                        .shared
                        .theQuranDependencyContainer
                        .makeQuranRepository()
                )
            )
#if DEBUG
            .overlay(alignment: .bottomLeading) {
                Text(memoryUsage)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)
                    .font(.footnote)
                    .opacity(0.8)
            }
#endif
            .onReceive(timer) { _ in
#if DEBUG
                memoryUsage = Memory.formattedMemoryFootprint()
#else
                timer.upstream.connect().cancel()
#endif
            }
        }
    }
    
    @State private var memoryUsage = ""
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
}
