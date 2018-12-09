//
//  ViewController.swift
//  sizeit
//
//  Created by Emiel Lensink on 07/12/2018.
//  Copyright © 2018 Emiel Lensink. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var measuringView: MeasuringView!
    private var externalMeasurementsOverlayView: MeasurementsOverlayView!

    var layoutMarginsConstraints: [NSLayoutConstraint] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "A view controller"

        if let navigationController = navigationController {
            externalMeasurementsOverlayView = MeasurementsOverlayView(frame: navigationController.view.bounds)
            externalMeasurementsOverlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            externalMeasurementsOverlayView.backgroundColor = .clear
            navigationController.view.addSubview(externalMeasurementsOverlayView)
        }

        measuringView = MeasuringView(frame: view.bounds)
        measuringView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        measuringView.backgroundColor = .clear
        measuringView.delegate = self
        measuringView.isUserInteractionEnabled = false
        view.addSubview(measuringView)
    }
}

extension ViewController: MeasuringViewDelegate {
    func measuringViewDidLayoutSubviews(view: MeasuringView) {
        externalMeasurementsOverlayView.safeArea = view.safeArea
        externalMeasurementsOverlayView.readableArea = view.readableArea
        externalMeasurementsOverlayView.layoutArea = view.layoutArea
    }
}
