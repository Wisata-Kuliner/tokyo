//
//  CountNode.swift
//  ChannelExample
//
//  Created by Robin Malhotra on 22/04/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//
//import AsyncDisplayKit
//
//class CountNode: ASDisplayNode {
//    let countLabel = ASTextNode()
//
//    let horizontalPadding: CGFloat = 13.0
//    let verticalPadding: CGFloat = 2.0
//
//    init(count: Int) {
//        super.init()
//
//        self.countLabel.attributedText = NSAttributedString.init(string: "\(count)", attributes: Styles.Text.pillText)
//
//        self.automaticallyManagesSubnodes = true
//    }
//
//    override func didLoad() {
//        super.didLoad()
//        self.backgroundColor = Styles.Colors.pillBackground
//        self.view.clipsToBounds = true
//    }
//
//    override func layoutDidFinish() {
//        super.layoutDidFinish()
//        self.layer.cornerRadius = self.frame.height / 2
//    }
//
//    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
//        return ASInsetLayoutSpec(insets: UIEdgeInsets.init(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding), child: countLabel)
//    }
//
//}
