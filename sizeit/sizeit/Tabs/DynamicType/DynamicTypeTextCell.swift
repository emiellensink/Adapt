//
//  DynamicTypeTextCell.swift
//  sizeit
//
//  Created by Emiel Lensink on 10/12/2018.
//  Copyright © 2018 Emiel Lensink. All rights reserved.
//

import UIKit

class DynamicTypeTextCell: UITableViewCell {

    @IBOutlet private weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with object: String) {
        label.text = object
    }
}
