//
//  ButtonVC.swift
//  pinknoise
//
//  Created by Adam Tait on 2/19/18.
//  Copyright © 2018 Sisterical Inc. All rights reserved.
//

import Foundation
import AsyncDisplayKit



class ButtonVC : ASViewController<ASControlNode>
{
    // public properties
    let selected = MutableProperty<Bool>(false)

    
    // initializers
    init(node: ASControlNode,
         style: Style = [:])
    {
        super.init(node: node)
        self.node.styleset.set(style)
        self.node.enableTouches()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


