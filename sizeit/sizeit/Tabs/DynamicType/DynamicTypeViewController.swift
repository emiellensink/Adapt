//
//  DynamicTypeViewController.swift
//  sizeit
//
//  Created by Emiel Lensink on 10/12/2018.
//  Copyright © 2018 Emiel Lensink. All rights reserved.
//

import UIKit

class DynamicTypeViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!

    let fonts: [(String, UIFont.TextStyle)] = [
        ("Body", .body),
        ("Callout", .callout),
        ("Caption 1", .caption1),
        ("Caption 2", .caption2),
        ("Footnote", .footnote),
        ("Headline", .headline),
        ("Subhead", .subheadline),
        ("Large title", .largeTitle),
        ("Title 1", .title1),
        ("Title 2", .title2),
        ("Title 3", .title3)
    ]

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

    }
}

extension DynamicTypeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 + fonts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dynamicTypeHeaderCell", for: indexPath)
            if let cell = cell as? DynamicTypeHeaderCell {
                cell.configure(with: "Explanation")
            }
            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dynamicTypeTextCell", for: indexPath)
            if let cell = cell as? DynamicTypeTextCell {
                cell.configure(with: "This screen shows samples of all system font styles. You can change their size in settings, general, accessibility. The samples here update automatically.")
            }
            return cell

        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dynamicTypeHeaderCell", for: indexPath)
            if let cell = cell as? DynamicTypeHeaderCell {
                cell.configure(with: "Samples")
            }
            return cell

        case 3..<fonts.count + 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dynamicTypeItemCell", for: indexPath)
            if let cell = cell as? DynamicTypeItemCell {
                let data = fonts[indexPath.row - 3]
                cell.configure(withTitle: data.0, content: "The quick brown fox jumped over the lazy dog", style: data.1)
            }
            return cell


        default:
            return UITableViewCell()
        }
    }
}
