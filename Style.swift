//
//  Style.swift
//  pinknoise
//
//  Created by Adam Tait on 2/22/18.
//  Copyright © 2018 Sisterical Inc. All rights reserved.
//

import Foundation

enum StyleType
{
    case bgColor
    case fgColor
    case borderColor
    case borderWidth
    case cornerRadius
    case text
    case font
    case imageName
    case insets
}
typealias Style = [StyleType : Any]

func merge(styles s: [Style]) -> Style
{
    return s.reduce([:], { acc, style in
        acc.merging(style, uniquingKeysWith: { (_, n) in n})
    })
}

