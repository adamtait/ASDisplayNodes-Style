//
//  StatefulImageButtonVC.swift
//  ASDisplayNodes+Style
//
//  Created by Adam Tait on 2/21/18.
//  Copyright © 2018 Sisterical Inc. All rights reserved.
//

import Foundation
import AsyncDisplayKit



class StatefulImageButtonVC : ImageButtonVC
{
    let selectedImageNode : ASImageNode
    
    
    // initializers
    init(style          : Style,
         selectedStyle  : Style)
    {
        let imageNode           = ImageButtonVC.newImageNode(style: style)
        self.selectedImageNode  = ImageButtonVC.newImageNode(style: selectedStyle)
        
        super.init(node: ASControlNode(), style: style)
        Layout.mutate(node              : self.node,
                      imageNode         : imageNode,
                      style             : style,
                      selectedImageNode : self.selectedImageNode,
                      selectedStyle     : selectedStyle,
                      selected          : selected)
        
        _ = self.selected.addObserver(selectedChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    // Observers
    func selectedChanged(_: Observable)
    {
        
        self.node.transitionLayout(withAnimation: true,
                                   shouldMeasureAsync: true,
                                   measurementCompletion: nil)
    }
}




// layout
extension StatefulImageButtonVC
{
    enum Layout
    {
        static func mutate(node n               : ASControlNode,
                           imageNode            : ASImageNode,
                           style                : Style,
                           selectedImageNode    : ASImageNode,
                           selectedStyle        : Style,
                           selected             : MutableProperty<Bool>)
        {
            n.automaticallyManagesSubnodes = true
            n.layoutSpecBlock = { node, size in
                
                let activeNode  = selected.get()! ? selectedImageNode : imageNode
                let activeStyle = selected.get()! ? selectedStyle : style
                
                n.styleset.set(activeStyle)
                let insets = activeStyle[.insets] as! UIEdgeInsets
                return ASInsetLayoutSpec(insets: insets,
                                         child: activeNode)
            }
        }
    }
}
