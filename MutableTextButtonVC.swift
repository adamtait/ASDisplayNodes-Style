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
    let titleSelected : MutableProperty<String>
    let styleSelected : MutableProperty<Style>
    
    
    
    // initializers
    init(style          : Style,
         selectedStyle  : Style,
         title          : String,
         selectedTitle  : String)
    {
        self.titleSelected = MutableProperty<String>(selectedTitle)
        self.styleSelected = MutableProperty<Style>(selectedStyle)
        super.init(style: style, title: title)
        _ = selected.addObserver(selectedPropertyChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // observers
    func selectedPropertyChanged(_: Observable)
    {
        let s = selected.get()! ? styleSelected.get()! : self.style.get()!
        self.node.styleset.set(s)
        
        let t = selected.get()! ? titleSelected.get()! : self.titlePrimary.get()!
        self.set(title: t)
    }
}
