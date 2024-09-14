//
//  NumberOfLinesProvider.swift
//  Al-Tanzeel
//
//  Created by Takasur Azeem on 9/14/24.
//  Copyright © 2024 Islam. All rights reserved.
//

import Foundation

protocol NumberOfLinesProvider {
    func numberOfLines(for text: String, horizontalPadding: CGFloat) -> Int
}
