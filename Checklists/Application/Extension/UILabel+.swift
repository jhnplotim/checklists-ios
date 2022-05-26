//
//  UILabel+.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import UIKit

public class Label: UILabel {

    @IBInspectable var caption: Bool = false {
        didSet {
            if caption {
                textColor = Asset.lightGray.color
                font = UIFont.caption
            }
        }
    }

    @IBInspectable var headline: Bool = false {
        didSet {
            if headline {
                textColor = Asset.darkGray.color
                font = UIFont.headline
            }
        }
    }

    @IBInspectable var mainRegular: Bool = false {
        didSet {
            if mainRegular {
                textColor = Asset.darkGray.color
                font = UIFont.mainRegular
            }
        }
    }

    @IBInspectable var mainRegularTag: Bool = false {
        didSet {
            if mainRegularTag {
                textColor = Asset.darkGray.color
                font = UIFont.mainRegularTag
            }
        }
    }

    @IBInspectable var mainSemibold: Bool = false {
        didSet {
            if mainSemibold {
                textColor = Asset.darkGray.color
                font = UIFont.mainSemibold
            }
        }
    }

    @IBInspectable var bigSemibold: Bool = false {
        didSet {
            if bigSemibold {
                textColor = Asset.darkGray.color
                font = UIFont.bigSemibold
            }
        }
    }

}
