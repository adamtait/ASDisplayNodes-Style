//
//  ASDisplayNode+Style.swift
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



extension ASDisplayNode
    // IMPORTANT! to begin, you must retrieve self.style (this sets up the observer on changes to ASDisplayNode.style)
{
    static let defaultStyle : Style = [StyleType.bgColor : UIColor.white,
                                       StyleType.fgColor : UIColor.blue]
    
    fileprivate static func cascade(style s: Style) -> Style {
        return merge(styles: [MutableControlNode.defaultStyle, s])
    }
    
    private static let association = ObjectAssociation<MutableProperty<Style>>()
    
    var style: MutableProperty<Style>
    {
        get {
            if let v = ASDisplayNode.association[self]  { return v }
            
            // else create+save new
            let v = MutableProperty<Style>(ASDisplayNode.defaultStyle)
            ASDisplayNode.association[self] = v
            v.addObserver(styleChanged)
            return v
        }
    }
    
    // public interface
    func apply(style : Style)
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
    
    
    // observers
    func styleChanged(_: Observable)
    {
        let s = ASDisplayNode.cascade(style: style)
        apply(style: s)
    }
}
