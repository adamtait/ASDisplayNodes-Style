//
//  MutableTextButtonVC.swift
//  pinknoise
//
//  Created by Adam Tait on 2/21/18.
//  Copyright © 2018 Sisterical Inc. All rights reserved.
//

import UIKit

class MutableTextButtonVC : TextButtonVC
{
    // private properties
    let selectedStyle : MutableProperty<Style>
    
    
    
    // initializers
    init(style          : Style,
         selectedStyle  : Style)
    {
        self.selectedStyle = MutableProperty<Style>(selectedStyle)
        super.init(style: style)
        _ = selected.addObserver(selectedPropertyChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // observers
    func selectedPropertyChanged(_: Observable)
    {
        let s = selected.get()! ? selectedStyle.get()! : self.style.get()!
        self.node.set(style: s)
        self.setTitle(s)
    }
}
