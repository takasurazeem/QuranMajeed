//
//  AppStyle.swift
//  Al-Tanzeel
//
//  Created by Takasur Azeem on 21/10/2023.
//  Copyright © 2023 Islam. All rights reserved.
//

import Foundation
import UIKit

enum AppStyle {

    enum Spacing {
        static let space4: CGFloat = 4.0
        static let space8: CGFloat = 8.0
        static let space16: CGFloat = 16.0
        static let space12: CGFloat = 12.0
        static let space24: CGFloat = 24.0
        static let space32: CGFloat = 32.0
    }
    
    enum PDF {
        static var theOpeningFont: UIFont {
            UIFont(name: "_PDMS_Saleem_QuranFont", size: 20) ?? .boldSystemFont(ofSize: 64)
        }
        
        static var verseFont: UIFont {
            UIFont(name: "ScheherazadeNew-Bold", size: 20) ?? .boldSystemFont(ofSize: 64)
        }
        
        static var leftRightHeadingsFont: UIFont {
            UIFont(name: "NotoNastaliqUrdu", size: 10) ?? .boldSystemFont(ofSize: 64)
        }
        
        static var belowOpeningTextFont: UIFont {
            UIFont(name: "DiwaniBent", size: 20) ?? .boldSystemFont(ofSize: 64)
        }
        
        static var nameAndDateTextFont: UIFont {
            UIFont(name: "NotoNastaliqUrdu", size: 14) ?? .boldSystemFont(ofSize: 64)
        }
    }

}
