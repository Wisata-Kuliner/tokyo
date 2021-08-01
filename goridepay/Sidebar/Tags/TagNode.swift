//
//  TagNode.swift
//  ChannelExample
//
//  Created by Robin Malhotra on 24/04/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//
//import AsyncDisplayKit
//
//class TagNode: ASCellNode {
//    let titleNode = ASTextNode()
//
//    init(title: String) {
//        super.init()
//
//        self.automaticallyManagesSubnodes = true
//        self.titleNode.attributedText = NSAttributedString(string: title, attributes: Styles.Text.tag)
//    }
//
//    override func didLoad() {
//        super.didLoad()
//        self.layer.cornerRadius = 4.0
//        self.clipsToBounds = true
//        self.layer.borderColor = UIColor(red:0.75, green:0.77, blue:0.78, alpha:1.00).cgColor
//        self.layer.borderWidth = 1.0
//    }
//
//    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
//        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 4, left: 9, bottom: 4, right: 9), child: titleNode)
//    }
//}
