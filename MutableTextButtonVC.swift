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
    struct State
    {
        let title : String
        let style : Style
    }
    
    // private properties
    let primary     : MutableProperty<State>
    let secondary   : MutableProperty<State>
    
    
    // initializers
    init(primary    : State,
         selected   : State)
    {
        self.primary    = MutableProperty<State>(primary)
        self.secondary  = MutableProperty<State>(selected)
        super.init(style: primary.style, title: primary.title)
        _ = self.selected.addObserver(selectedPropertyChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // observers
    func selectedPropertyChanged(_: Observable)
    {
        let s = selected.get()! ? secondary.get()! : primary.get()!
        self.node.styleset.set(s.style)
        self.set(title: s.title)
    }
}
