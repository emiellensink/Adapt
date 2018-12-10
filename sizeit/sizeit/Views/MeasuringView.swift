//
//  MeasuringView.swift
//  sizeit
//
//  Created by Emiel Lensink on 09/12/2018.
//  Copyright © 2018 Emiel Lensink. All rights reserved.
//

import UIKit

protocol MeasuringViewDelegate: class {
    func measuringViewDidLayoutSubviews(view: MeasuringView)
}

class MeasuringView: UIView {
    weak var delegate: MeasuringViewDelegate?

    var safeArea: CGRect {
        guard let superview = superview else { fatalError() }
        return superview.safeAreaLayoutGuide.layoutFrame
    }

    var readableArea: CGRect {
        guard let superview = superview else { fatalError() }
        return superview.readableContentGuide.layoutFrame
    }

    var layoutArea: CGRect {
        guard let superview = superview else { fatalError() }
        let layoutMargins = superview.layoutMargins
        return bounds.inset(by: layoutMargins)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        delegate?.measuringViewDidLayoutSubviews(view: self)
    }
}
