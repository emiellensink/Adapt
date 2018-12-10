//
//  TraitCollectionViewController.swift
//  sizeit
//
//  Created by Emiel Lensink on 10/12/2018.
//  Copyright © 2018 Emiel Lensink. All rights reserved.
//

import UIKit

class TraitCollectionViewController: UIViewController {
    enum TraitClass: String {
        case sizeClass = "Size Class"
        case display = "Display"
        case interface = "User Interface"
        case contentSize = "Content Size"
    }

    enum TraitItem: String {
        case horizontalSizeClass = "Horizontal size class"
        case verticalSizeClass = "Vertical size class"

        case displayScale = "Display scale"
        case displayGamut = "Display gamut"

        case userInterfaceIdiom = "User interface idiom"
        case forceTouchCapability = "Force touch capability"
        case layoutDirection = "Layout direction"

        case preferredContentSizeCategory = "Preferred content size category"
    }

    let sourceSections: [TraitClass] = [
        .sizeClass,
        .display,
        .interface,
        .contentSize
    ]

    let sourceData: [TraitClass: [TraitItem]] = [
        .sizeClass: [.horizontalSizeClass, .verticalSizeClass],
        .display: [.displayScale, .displayGamut],
        .interface: [.userInterfaceIdiom, .forceTouchCapability, .layoutDirection],
        .contentSize: [.preferredContentSizeCategory]
    ]

    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        tableView.reloadData()
    }

    private func formattedString(for traitItem: TraitItem) -> String {
        switch traitItem {

        case .horizontalSizeClass: return traitCollection.horizontalSizeClass.friendlyName
        case .verticalSizeClass: return traitCollection.verticalSizeClass.friendlyName

        case .displayScale:
            let formatted = String(format: "%.0f", traitCollection.displayScale)
            return "this is a \(formatted)x device"
        case .displayGamut: return traitCollection.displayGamut.friendlyName

        case .userInterfaceIdiom: return traitCollection.userInterfaceIdiom.friendlyName
        case .forceTouchCapability: return "force touch is \(traitCollection.forceTouchCapability.friendlyName) on this device"
        case .layoutDirection: return traitCollection.layoutDirection.friendlyName

        case .preferredContentSizeCategory: return traitCollection.preferredContentSizeCategory.friendlyName
        }
    }
}

extension TraitCollectionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sourceSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTrait = sourceSections[section]
        if let data = sourceData[sectionTrait] {
            return 1 + data.count
        }

        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell

        switch indexPath.row {
        case 0: cell = tableView.dequeueReusableCell(withIdentifier: "traitCollectionHeaderCell", for: indexPath)
        default: cell = tableView.dequeueReusableCell(withIdentifier: "traitCollectionItemCell", for: indexPath)
        }

        switch cell {
        case let cell as TraitCollectionHeaderCell:
            let text = sourceSections[indexPath.section].rawValue
            cell.configure(with: text)
        case let cell as TraitCollectionItemCell:
            let sectionTrait = sourceSections[indexPath.section]
            if let data = sourceData[sectionTrait] {
                let item = data[indexPath.row - 1]
                let title = item.rawValue
                let content = formattedString(for: item)
                cell.configure(withTitle: title, content: content)
            }
        default:
            break
        }

        return cell
    }
}
