//
//  ImageButtonVC.swift
//  pinknoise
//
//  Created by Adam Tait on 2/20/18.
//  Copyright © 2018 Sisterical Inc. All rights reserved.
//

import Foundation
import AsyncDisplayKit



class ImageButtonVC : ButtonVC
{
    static let defaultImageStyle : Style = [StyleType.imageName : "AppIcon"]
    
    
    // initializers
    static func newImageNode(style: Style) -> ASImageNode
    {
        let n = ASImageNode()
        let imageName = style[.imageName] as! String
        n.image = UIImage(named: imageName)!.resizableImage(withCapInsets: .zero, resizingMode: .stretch)
        n.contentMode = .center
        n.clipsToBounds = true
        return n
    }
    
    override init(node: ASControlNode,
                  style: Style = [:])
    {
        let s = ASDisplayNode.cascade(styles: [ImageButtonVC.defaultImageStyle, style])
        super.init(node: node, style: s)
    }
    
    convenience init(style: Style)
    {
        let s = ASDisplayNode.cascade(styles: [ImageButtonVC.defaultImageStyle, style])
        let n = Layout.node(imageNode: ImageButtonVC.newImageNode(style: s), style: s)
        self.init(node: n, style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// layout
extension ImageButtonVC
{
    enum Layout
    {
        static func node(imageNode  : ASImageNode,
                         style      : Style)
            -> ASControlNode
        {
            let n = ASControlNode()
            n.automaticallyManagesSubnodes = true
            n.layoutSpecBlock = { node, size in
                let insets = style[.insets] as! UIEdgeInsets
                return ASInsetLayoutSpec(insets: insets, child: imageNode)
            }
            return n
        }
    }
}
