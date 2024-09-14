//
//  PageWidthProvider.swift
//  Al-Tanzeel
//
//  Created by Takasur Azeem on 9/14/24.
//  Copyright © 2024 Islam. All rights reserved.
//

import Foundation

public protocol PageSizeProvider {
    var pageWidth: CGFloat { get }
    var pageHeight: CGFloat { get }
    var pageRect: CGRect { get }
}
