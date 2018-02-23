//
//  ASControlNode+Style.swift
//  pinknoise
//
//  Created by Adam Tait on 2/22/18.
//  Copyright © 2018 Sisterical Inc. All rights reserved.
//

import UIKit
import AsyncDisplayKit


func toCgFloat(anyNumber n: Any) -> CGFloat
{
    if      let c = n as? CGFloat    { return c }
    else if let d = n as? Double     { return CGFloat(d) }
    else if let f = n as? Float      { return CGFloat(f) }
    return CGFloat(n as! Int)
}



extension ASControlNode
{
    func set(style : Style)
    {
        if let v = style[.bgColor] as? UIColor      { self.backgroundColor = v }
        if let v = style[.fgColor] as? UIColor      { self.tintColor = v }
        if let v = style[.borderColor] as? UIColor  { self.borderColor = v.cgColor }
        
        if let v = style[.borderWidth] {
            self.borderWidth = toCgFloat(anyNumber: v)
        }
        
        if let v = style[.cornerRadius] {
            self.cornerRadius = toCgFloat(anyNumber: v)
        }
    }
}
