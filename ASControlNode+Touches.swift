//
//  ASControlNode+Touches.swift
//  pinknoise
//
//  Created by Adam Tait on 4/20/18.
//  Copyright © 2018 Sisterical Inc. All rights reserved.
//

import Foundation
import AsyncDisplayKit

extension ASControlNode
    //   keeps track of the number of times that it's touched (up inside)
    //   implementors should observe MutableControlNode.touches and
    //   perform actions based on changes
    //   To begin, call ASControlNode.enableTouches()
{
    private static let association = ObjectAssociation<MutableProperty<Int>>()
    
    var touches: MutableProperty<Int>
    {
        get {
            if let v = ASControlNode.association[self]  { return v }
            
            // else create+save new
            let v = MutableProperty<Int>(0)
            ASControlNode.association[self] = v
            return v
        }
    }
    
    // public interface
    //   Implementors: you need to call .enableTouches() on init
    func enableTouches()
    {
        self.isEnabled = true
        self.isUserInteractionEnabled = true
        self.addTarget(self,
                       action: #selector(self.touched),
                       forControlEvents: .touchUpInside)
    }
    
    
    // observers
    @objc func touched()
    {
        let t = touches
        let v = t.get()! + 1
        t.set(v)
    }
}
