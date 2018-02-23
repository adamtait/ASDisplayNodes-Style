//
//  RadioButtons.swift
//  pinknoise
//
//  Created by Adam Tait on 2/21/18.
//  Copyright © 2018 Sisterical Inc. All rights reserved.
//

import Foundation


class RadioButtons : Observable
    // a collection of mutually exclusively selected/highlighted ButtonVC
    // mutually exclusive => only one button is selected at a time
{
    let buttons : [ButtonVC]
    
    init(_ btns : [ButtonVC])
    {
        self.buttons = btns
        super.init()
        btns.forEach { bvc in
            let o = newTouchesObserver(buttonVC: bvc)
            _ = bvc.touches.addObserver(o)
        }
    }
    
    
    // Observers
    func newTouchesObserver(buttonVC : ButtonVC) -> (_ o: Observable) -> Void
    {
        return { o in
            if let vc = self.getSelectedVC()
            {
                vc.selected.set(false)
            }
            buttonVC.selected.set(true)
            self.notify()
        }
    }
    
    
    // Find Selected VC
    func getSelectedIndex() -> Int?
    {
        for i in 0 ..< buttons.count {
            if buttons[i].selected.get()! {
                return i
            }
        }
        return nil
    }
    
    func getSelectedVC() -> ButtonVC?
    {
        return buttons.first(where: { $0.selected.get()! })
    }
    
    func deselectAll()
    {
        let vc = getSelectedVC()
        vc?.selected.set(false)
    }
}


