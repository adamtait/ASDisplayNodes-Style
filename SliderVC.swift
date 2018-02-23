//
//  SliderVC.swift
//  pinknoise
//
//  Created by Adam Tait on 2/20/18.
//  Copyright © 2018 Sisterical Inc. All rights reserved.
//

import Foundation
import AsyncDisplayKit




class SliderVC : ASViewController<ASDisplayNode>
{
    let p : MutableProperty<Float>
    var o : Observable.Ref? = nil
    
    let slider = UISlider(frame: .zero)

    
    
    // initializers
    init(property: MutableProperty<Float>)
    {
        self.p = property
        
        let s = self.slider
        super.init(node: ASDisplayNode { () -> UIView in
            return s
        })
        self.node.backgroundColor = .white
        
        self.update()
        self.slider.addTarget(self, action: #selector(changed), for: .valueChanged)
        self.o = p.addObserver(propertyChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // observers
    func propertyChanged(_ o: Observable)   { update() }
    
    @objc func changed()
    {
        _ = self.o?.remove()        // no need to update with the same value
        
        let v = self.slider.value
        self.p.set(v)
        
        self.o = self.p.addObserver(propertyChanged)
    }
    
    
    // mutators
    func update()
    {
        slider.setValue(self.p.get()!, animated: true)
    }
}
