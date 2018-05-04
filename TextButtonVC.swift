//
//  TextButtonVC.swift
//  pinknoise
//
//  Created by Adam Tait on 2/20/18.
//  Copyright © 2018 Sisterical Inc. All rights reserved.
//

import Foundation
import AsyncDisplayKit





class TextButtonVC : ButtonVC
{
    static let defaultTextStyle : Style = [:]
    
    
    
    // private properties
    let buttonNode : ASButtonNode
    
    
    // initializers
    init(style: Style = [:])
    {
        let s = ASDisplayNode.cascade(styles: [TextButtonVC.defaultTextStyle, style])
        self.buttonNode = ASButtonNode()
        super.init(node: self.buttonNode, style: s)
        setTitle(style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // helpers
    func setTitle(_ style : Style)
    {
        let f = font(style)
        buttonNode.setTitle(style[.text] as! String,
                            with: f,
                            with: style[.fgColor] as? UIColor,
                            for: .normal)
    }
    
    func font(_ s: Style) -> UIFont
    {
        let size = s[.fontSize] != nil ? CGFloat(s[.fontSize] as! Double) : UIFont.systemFontSize
        if let n = s[.fontName] as? String
        {
            return UIFont(name: n,
                          size: size)!
        }
        return UIFont.systemFont(ofSize: size)
    }
}


