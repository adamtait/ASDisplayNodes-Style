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
    // IMPORTANT! to begin, you must retrieve self.styleset (this sets up the observer on changes to ASDisplayNode.styleset)
{
    private static let association = ObjectAssociation<MutableProperty<Style>>()
    
    // Style
    static let defaultStyle : Style = [StyleType.bgColor : UIColor.white,
                                       StyleType.fgColor : UIColor.blue,
                                       StyleType.fontName : UIFont.systemFont(ofSize: 12.0).fontName,
                                       StyleType.fontSize : UIFont.systemFontSize]
    
    static func cascade(styles: [Style]) -> Style {
        return ASControlNode.defaultStyle.merge(styles)
    }
    
    var styleset: MutableProperty<Style>
        // NOTE: can't use 'style' b/c ASLayoutElement (subclass of ASDisplayNode) has already claimed it
    {
        get {
            if let v = ASDisplayNode.association[self]  { return v }
            
            // else create+save new
            let v = MutableProperty<Style>(ASDisplayNode.defaultStyle)
            ASDisplayNode.association[self] = v
            _ = v.addObserver(styleChanged)
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
        
        if let v = style[.alpha] {
            self.alpha = toCgFloat(anyNumber: v)
        }
    }
    
    
    // observers
    func styleChanged(_: Observable)
    {
        let s = ASDisplayNode.cascade(styles: [styleset.get()!])
        apply(style: s)
    }
}
