//
//  TagCell.swift
//  ChannelExample
//
//  Created by Robin Malhotra on 24/04/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//
//import AsyncDisplayKit
//
//class TagCell: ASCellNode {
//
//    let tagNodes: [TagNode]
//
//    init(_ tags: [String]) {
//        self.tagNodes = tags.map(TagNode.init)
//        super.init()
//        self.automaticallyManagesSubnodes = true
//    }
//
//    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
//        let tagSpecs = tagNodes.map{
//            return ASInsetLayoutSpec(insets: UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 4), child: $0)
//        }
//        return ASStackLayoutSpec(direction: .horizontal, spacing: 4.0, justifyContent: .start, alignItems: .center, flexWrap: .wrap, alignContent: .start, children: tagSpecs)
//    }
//}
