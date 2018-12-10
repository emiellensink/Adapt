//
//  DynamicTypeItemCell.swift
//  sizeit
//
//  Created by Emiel Lensink on 10/12/2018.
//  Copyright © 2018 Emiel Lensink. All rights reserved.
//

import UIKit

class DynamicTypeItemCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(withTitle title: String, content: String, style: UIFont.TextStyle) {
        titleLabel.text = title
        contentLabel.font = UIFont.preferredFont(forTextStyle: style)
        contentLabel.adjustsFontForContentSizeCategory = true
        contentLabel.text = content
    }

}
