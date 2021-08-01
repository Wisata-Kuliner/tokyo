//
//  ChannelCell.swift
//  ChannelExample
//
//  Created by Robin Malhotra on 23/04/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//
//import AsyncDisplayKit
//
//class ChannelCell: ASCellNode {
//
//    let poundNode = ASTextNode()
//    let countNode: CountNode
//    let titleNode = ASTextNode()
//
//    init(name: String, count: Int) {
//        self.countNode = CountNode(count: count)
//        super.init()
//
//        self.titleNode.maximumNumberOfLines = 1
//        self.titleNode.attributedText = NSAttributedString(string: name, attributes: Styles.Text.channelTitle)
//        self.poundNode.attributedText = NSAttributedString(string: "#", attributes: Styles.Text.pound)
//        self.automaticallyManagesSubnodes = true
//    }
//
//    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
//        let nameStack = ASStackLayoutSpec(direction: .horizontal, spacing: 4.0, justifyContent: .start, alignItems: .center, children: [poundNode, titleNode])
//        titleNode.style.flexShrink = 0.1
//        nameStack.style.flexShrink = 0.1
//        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 8.0, justifyContent: .spaceBetween, alignItems: .center, children: [nameStack, countNode])
//        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 6.0, left: 17.0, bottom: 6.0, right: 12.0), child: stack)
//    }
//}
