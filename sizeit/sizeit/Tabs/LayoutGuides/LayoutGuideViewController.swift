//
//  LayoutGuideViewController.swift
//  sizeit
//
//  Created by Emiel Lensink on 07/12/2018.
//  Copyright © 2018 Emiel Lensink. All rights reserved.
//

import UIKit

class LayoutGuideViewController: UIViewController {

    @IBOutlet private weak var horizontalSizeClassLabel: UILabel!
    @IBOutlet private weak var verticalSizeClassLabel: UILabel!

    private var measuringView: MeasuringView!
    private var externalMeasurementsOverlayView: MeasurementsOverlayView!

    var layoutMarginsConstraints: [NSLayoutConstraint] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        if let rootController = navigationController?.tabBarController {
            externalMeasurementsOverlayView = MeasurementsOverlayView(frame: rootController.view.bounds)
            externalMeasurementsOverlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            externalMeasurementsOverlayView.backgroundColor = .clear
            externalMeasurementsOverlayView.isUserInteractionEnabled = false
            rootController.view.addSubview(externalMeasurementsOverlayView)
        }

        measuringView = MeasuringView(frame: view.bounds)
        measuringView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        measuringView.backgroundColor = .clear
        measuringView.delegate = self
        measuringView.isUserInteractionEnabled = false
        view.addSubview(measuringView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let rootController = navigationController?.tabBarController {
            externalMeasurementsOverlayView.frame = rootController.view.bounds
            rootController.view.addSubview(externalMeasurementsOverlayView)
        }

        updateSizeClassLabels()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        externalMeasurementsOverlayView.removeFromSuperview()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        updateSizeClassLabels()
    }

    @IBAction func segmentedNavigationBarControlDidChangeValue(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:     // None
            navigationController?.setNavigationBarHidden(true, animated: true)
        case 1:     // Default
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationController?.setNavigationBarHidden(false, animated: true)
        case 2:     // Large
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.setNavigationBarHidden(false, animated: true)
        default:
            break
        }
    }

    private func updateSizeClassLabels() {
        horizontalSizeClassLabel.text = traitCollection.horizontalSizeClass.friendlyName
        verticalSizeClassLabel.text = traitCollection.verticalSizeClass.friendlyName
    }
}

extension LayoutGuideViewController: MeasuringViewDelegate {
    func measuringViewDidLayoutSubviews(view: MeasuringView) {
        externalMeasurementsOverlayView.safeArea = view.safeArea
        externalMeasurementsOverlayView.readableArea = view.readableArea
        externalMeasurementsOverlayView.layoutArea = view.layoutArea
    }
}
