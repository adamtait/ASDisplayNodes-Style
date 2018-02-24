//
//  RadioButtons.swift
//  pinknoise
//
//  Created by Adam Tait on 2/21/18.
//  Copyright © 2018 Sisterical Inc. All rights reserved.
//

import Foundation


func wrap<T>(_ before   : @escaping () -> Void,
             _ fn       : @escaping (T) -> Void,
             _ after    : @escaping () -> Void)
    -> (T)
    -> Void
{
    return { v in
        before()
        fn(v)
        after()
    }
}





class RadioButtons
    // a collection of mutually exclusively selected/highlighted ButtonVC
    // mutually exclusive => only one button is selected at a time
    // double selection: when the same button is selected twice in a row, that button is de-selected
{
    let buttons                         : [ButtonVC]
    let selectedIndex                   = MutableProperty<Int>(-1)      // -1 => none selected. Any value outside 0..<buttons.count will do
    fileprivate var selectedObservers   : [Observable.Ref]  = []
    
    init(_ btns : [ButtonVC])
    {
        self.buttons = btns
        
        // add observers
        for i in 0 ..< btns.count
        {
            let bvc = btns[i]
            let o = newTouchesObserver(buttonVC: bvc, index: i)
            _ = bvc.touches.addObserver(o)
            selectedObservers.append(bvc.selected.addObserver(o))
        }
    }
    
    
    // Observers
    func newTouchesObserver(buttonVC    : ButtonVC,
                            index i     : Int)
        -> (_ o: Observable)
        -> Void
    {
        return wrap(
            {   // de-activate selected observers
                self.selectedObservers.forEach { $0.active.set(false) }
        },
            { o in
                // de-select current selected VC
                if let vc = self.getSelectedVC() {
                    vc.selected.set(false)
                }
                
                if i == self.selectedIndex.get()
                {   // double selection
                    self.selectedIndex.set(-1)
                }
                else
                {   // select new VC
                    self.selectedIndex.set(i)
                    buttonVC.selected.set(true)
                }
        },
            {   // re-activate selected observers
                self.selectedObservers.forEach { $0.active.set(true) }
        })
    }
    
    
    // Find Selected VC
    func getSelectedIndex() -> Int?
    {
        if let i = selectedIndex.get()
        {
            if buttons.indices.contains(i)   { return i }
        }
        return nil
    }
    
    func getSelectedVC() -> ButtonVC?
    {
        if let i = getSelectedIndex()       { return buttons[i] }
        return nil
    }
    
    func deselectAll()
    {
        if let vc = getSelectedVC()     { vc.selected.set(false) }
    }
}


