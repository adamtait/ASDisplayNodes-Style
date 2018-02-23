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
    // ButtonVC is a generic ASViewController that keeps track of the
    //   number of times that it's touched (up inside)
    // implementors should
    // 1. observe ButtonVC.touches and perform actions based on changes
    // 2. layout ButtonVC.node as desired
{
    // Style
    static let defaultStyle : Style = [StyleType.bgColor : UIColor.white,
                                       StyleType.fgColor : UIColor.blue]
    fileprivate static func cascade(style s: Style) -> Style
    {
        return merge(styles: [ButtonVC.defaultStyle, s])
    }
    
    
    // public properties
    let touches     = MutableProperty<Int>(0)
    let selected    = MutableProperty<Bool>(false)
    let style       = MutableProperty<Style>(ButtonVC.defaultStyle)

    
    // initializers
    init(node: ASControlNode,
         style s: Style = [:])
    {
        super.init(node: node)
        
        _ = style.addObserver(updateStyle)
        postInit(withStyle: s)
    }
    
    func postInit(withStyle s: Style)
    {
        self.style.set(ButtonVC.cascade(style: s))
        self.node.isUserInteractionEnabled = true
        self.node.addTarget(self,
                            action: #selector(self.touched),
                            forControlEvents: .touchUpInside)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // observers
    @objc func touched()
    {
        let v = touches.get()! + 1
        touches.set(v)
    }
    
    func updateStyle(_: Observable)
    {
        self.node.set(style: style.get()!)
    }
}


