//
//  QuizSettingsView.swift
//  Al-Tanzeel
//
//  Created by Takasur Azeem on 16/02/2024.
//  Copyright © 2024 Islam. All rights reserved.
//

import SwiftUI

struct QuizSettingsView: View {
    @AppStorage("MasjidName") private var masjidName: String = ""
    @AppStorage("ClassName") private var className: String = ""
    private let masjidNameLabel: String = "Masjid Name"
    private let classNameLabel: String = "Class Name"
    
    var body: some View {
        List {
            Section("Top Header") {
                NavigationLink {
                    VStack {
                        TextField(masjidNameLabel, text: $masjidName)
                            .padding()
                        Spacer()
                    }
                    .navigationTitle(masjidNameLabel)
                } label: {
                    VStack {
                        HStack {
                            Text("🕌")
                                .frame(minWidth: 32)
                            Text(masjidNameLabel)
                        }
                        if !masjidName.isEmpty {
                            Text(masjidName)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        } else {
                            Text("Tap here to set the Masjid name")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }

                NavigationLink {
                    VStack {
                        TextField(classNameLabel, text: $className)
                            .padding()
                        Spacer()
                    }
                    .navigationTitle(classNameLabel)
                } label: {
                    VStack {
                        HStack {
                            Text("🎓")
                                .frame(minWidth: 32)
                            Text(classNameLabel)
                        }
                        
                        if !className.isEmpty {
                            Text(className)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        } else {
                            Text("Tap here to set the class name")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }

            }
        }
    }
}

#Preview {
    NavigationStack {
        QuizSettingsView()
            .navigationTitle("Quiz Settings")
    }
}
