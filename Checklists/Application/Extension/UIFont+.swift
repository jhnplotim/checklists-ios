//
//  UIFont+.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import UIKit

extension UIFont {

    static var caption: UIFont {
        return UIFont.systemFont(ofSize: 12, weight: .medium)
    }

    static var headline: UIFont {
        return UIFont.systemFont(ofSize: 34, weight: .medium)
    }

    static var mainRegular: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    static var mainRegularTag: UIFont {
        return UIFont.systemFont(ofSize: 8, weight: .regular)
    }

    static var mainSemibold: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .semibold)
    }

    static var bigSemibold: UIFont {
        return UIFont.systemFont(ofSize: 18, weight: .semibold)
    }

}
