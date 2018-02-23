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
    static let defaultTextStyle : Style = [StyleType.font : UIFont.systemFont(ofSize: UIFont.systemFontSize)]
    fileprivate static func cascade(style s: Style) -> Style
    {
        return merge(styles: [ButtonVC.defaultStyle, TextButtonVC.defaultTextStyle, s])
    }
    
    
    
    // private properties
    let buttonNode : ASButtonNode
    
    
    // initializers
    init(style: Style = [:])
    {
        let s = TextButtonVC.cascade(style: style)
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
        buttonNode.setTitle(style[.text] as! String,
                            with: style[.font] as? UIFont,
                            with: style[.fgColor] as? UIColor,
                            for: .normal)
    }
}


