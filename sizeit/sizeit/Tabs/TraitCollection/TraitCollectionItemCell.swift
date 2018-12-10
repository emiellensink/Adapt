//
//  TraitCollectionItemCell.swift
//  sizeit
//
//  Created by Emiel Lensink on 10/12/2018.
//  Copyright © 2018 Emiel Lensink. All rights reserved.
//

import UIKit

class TraitCollectionItemCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(withTitle title: String, content: String) {
        titleLabel.text = title
        contentLabel.text = content
    }
}
