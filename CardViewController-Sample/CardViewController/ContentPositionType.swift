//
//  ContentPositionType.swift
//  CardViewController-Sample
//
//  Created by kawaharadai on 2020/04/06.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

import Foundation
import UIKit

enum ContentPositionType {
    case full
    case upperMiddle
    case half
    case underMiddle
    case hidden

    var originY: CGFloat {
        switch self {
        case .full:
            return UIScreen.main.bounds.origin.y
        case .upperMiddle:
            return UIScreen.main.bounds.height * 0.25
        case .half:
            return UIScreen.main.bounds.height * 0.5
        case .underMiddle:
            return UIScreen.main.bounds.height * 0.75
        case .hidden:
            return UIScreen.main.bounds.height
        }
    }

    var closeLimitOriginY: CGFloat {
        switch self {
        case .full:
            return UIScreen.main.bounds.height * 0.5
        case .upperMiddle:
            return UIScreen.main.bounds.height * 0.6
        case .half:
            return UIScreen.main.bounds.height * 0.7
        case .underMiddle:
            return UIScreen.main.bounds.height * 0.75
        case .hidden:
            return UIScreen.main.bounds.height
        }
    }
}
