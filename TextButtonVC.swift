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
    let titlePrimary : MutableProperty<String>
    let buttonNode : ASButtonNode
    
    
    // initializers
    init(style: Style = [:], title: String)
    {
        self.titlePrimary = MutableProperty<String>(title)
        let s = ASDisplayNode.cascade(styles: [TextButtonVC.defaultTextStyle, style])
        self.buttonNode = ASButtonNode()
        super.init(node: self.buttonNode, style: s)
        set(title: title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // helpers
    func set(title: String)
    {
        let s = self.node.styleset.get()!
        buttonNode.setTitle(title,
                            with: s.font(),
                            with: s[.fgColor] as? UIColor,
                            for: .normal)
    }
}


