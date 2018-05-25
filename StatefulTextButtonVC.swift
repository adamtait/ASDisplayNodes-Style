//
//  StatefulTextButtonVC.swift
//  ASDisplayNodes+Style
//
//  Created by Adam Tait on 2/21/18.
//  Copyright © 2018 Sisterical Inc. All rights reserved.
//

import UIKit


class StatefulTextButtonVC : TextButtonVC
{
    struct State : Hashable, Equatable
    {
        let uuid = UUID()
        let title : String
        let style : Style
        
        
        public static func == (lhs: State, rhs: State) -> Bool {
            return lhs.uuid == rhs.uuid
        }
        
        public var hashValue: Int { get { return uuid.hashValue } }
    }
    
    // private properties
    let states              : MutableCollection<State>
    
    
    // initializers
    init(_ states : [State])
    {
        self.states = MutableCollection<State>(states)
        super.init(style: states.first!.style,
                   title: states.first!.title)
        _ = self.selected.addObserver(selectedPropertyChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // observers
    func selectedPropertyChanged(_: Observable)
        // cycle through available states
    {
        let s = currentState()
        self.node.styleset.set(s.style)
        self.set(title: s.title)
    }
    
    
    // helpers
    func currentState() -> State
    {
        return selected.get()! ? states.at(1)! : states.at(0)!
    }
}
