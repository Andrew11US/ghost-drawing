//
//  UIColor+Extensions.swift
//  ghost-drawing
//
//  Created by Andrew on 2022-07-21.
//

import UIKit

extension UIColor {
    var delay: Int {
        switch self {
        case .red: return 1
        case .blue: return 3
        case .green: return 5
        case .white: return 2
        default: return 0
        }
    }
}
