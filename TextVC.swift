//
//  TextVC.swift
//  pinknoise
//
//  Created by Adam Tait on 2/20/18.
//  Copyright © 2018 Sisterical Inc. All rights reserved.
//

import UIKit
import AsyncDisplayKit



struct TextProperties
{
    let text    : MutableProperty<String>
    let font    : UIFont
    let color   : UIColor
}


class TextVC : ASViewController<ASEditableTextNode>
{
    let tp              : TextProperties
    let pp              : TextProperties?
    let multiline       : Bool
    let heightDelta     = MutableProperty<CGFloat>(0.0)
    let editingState    = MutableProperty<Bool>(false)
    
    
    
    
    // initializers
    init(text           : TextProperties,
         placeholder    : TextProperties? = nil,
         multiline      : Bool = false
         )
    {
        self.tp         = text
        self.pp         = placeholder
        self.multiline  = multiline
        
        let node = ASEditableTextNode()
        super.init(node: node)
        node.delegate = self
        
        layout()
        set(text: text)
        if let p = placeholder   { set(placeholder: p) }
        
        _ = self.tp.text.addObserver(textChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    // observers
    func textChanged(_ o: Observable)   { set(text: self.tp) }
    
    
    // layout
    func layout()
    {
        self.node.scrollEnabled = false
        if !self.multiline      { self.node.maximumLinesToDisplay = 1 }
    }
    
    func set(placeholder props: TextProperties)
    {
        self.node.attributedPlaceholderText = attrStr(from: props)
    }
    
    func set(text props: TextProperties)
    {
        self.node.attributedText = attrStr(from: props)
    }
    
    func attrStr(from props: TextProperties) -> NSAttributedString
    {
        let baseAttrs = [NSAttributedStringKey.font                : props.font as Any,
                         NSAttributedStringKey.foregroundColor     : props.color as Any]
        return NSAttributedString(string: props.text.get()!,
                                  attributes: baseAttrs)
    }
}




extension TextVC : ASEditableTextNodeDelegate
{
    func editableTextNodeDidBeginEditing(_ editableTextNode: ASEditableTextNode)
    {
        self.editingState.set(true)
    }
    
    
    
    func editableTextNode(_ editableTextNode: ASEditableTextNode,
                          shouldChangeTextIn range: NSRange,
                          replacementText text: String) -> Bool
    {
        if multiline
        {
            let extraSpace = self.tp.font.pointSize * 1.8
            let h = editableTextNode.textView.contentSize.height - CGFloat(extraSpace)
            
            // check for newline characters to make changes less jumpy
            if text.rangeOfCharacter(from: .newlines) != nil        // added newline
            {
                self.heightDelta.set(h)
            }
            else if range.length == 1                                    // deleted a character
            {
                let t = NSString(string: editableTextNode.textView.text)
                let tr = t.substring(with: range)
                
                if tr.rangeOfCharacter(from: .newlines) != nil      // deleted a newline
                {
                    self.heightDelta.set(h - CGFloat(self.tp.font.pointSize))
                }
            }
            
            return true
        }
        
        // !multiline -> don't allow whitespace characters or multiple lines
        return text.rangeOfCharacter(from: .newlines) == nil
    }
    
    
    
    func editableTextNodeDidUpdateText(_ editableTextNode: ASEditableTextNode)
    {
        // update MutableProperty
        tp.text.set(editableTextNode.attributedText?.string ?? "")
    }
    
    
    
    func editableTextNodeDidFinishEditing(_ editableTextNode: ASEditableTextNode)
    {
        self.editingState.set(false)
    }
}






