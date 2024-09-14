//
//  PageWidthProvider.swift
//  Al-Tanzeel
//
//  Created by Takasur Azeem on 9/14/24.
//  Copyright © 2024 Islam. All rights reserved.
//

import Foundation

struct A4PageSizeProvider: PageSizeProvider {
    var pageWidth: CGFloat {
        595.2
    }
    
    var pageHeight: CGFloat {
        841.0
    }
    
    var pageRect: CGRect {
        CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
    }
}
