//
//  MeasurementsOverlayView.swift
//  sizeit
//
//  Created by Emiel Lensink on 07/12/2018.
//  Copyright © 2018 Emiel Lensink. All rights reserved.
//

import UIKit

class MeasurementsOverlayView: UIView {

    private var safeAreaHorizontalCenterView: MeasureDisplayView!
    private var safeAreaHorizontalLeftView: MeasureDisplayView!
    private var safeAreaHorizontalRightView: MeasureDisplayView!

    private var safeAreaVerticalCenterView: MeasureDisplayView!
    private var safeAreaVerticalTopView: MeasureDisplayView!
    private var safeAreaVerticalTopBarView: MeasureDisplayView!
    private var safeAreaVerticalBottomView: MeasureDisplayView!
    private var safeAreaVerticalBottomBarView: MeasureDisplayView!

    private var readableAreaHorizontalCenterView: MeasureDisplayView!
    private var readableAreaHorizontalLeftView: MeasureDisplayView!
    private var readableAreaHorizontalRightView: MeasureDisplayView!

    private var layoutMarginHorizontalCenterView: MeasureDisplayView!
    private var layoutMarginHorizontalLeftView: MeasureDisplayView!
    private var layoutMarginHorizontalRightView: MeasureDisplayView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        completeInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        completeInit()
    }

    private func completeInit() {
        addSafeAreaViews()
        addReadableAreaViews()
        addLayoutMarginViews()

        subviews.compactMap({ $0 as? MeasureDisplayView }).forEach {
            $0.arrowColor = UIColor(named: "AccentColor")
            $0.textColor = UIColor(named: "AccentColor")
        }
    }

    var safeArea: CGRect = .zero {
        didSet { setNeedsLayout(); setNeedsDisplay() }
    }

    var readableArea: CGRect = .zero {
        didSet { setNeedsLayout(); setNeedsDisplay() }
    }

    var layoutArea: CGRect = .zero {
        didSet { setNeedsLayout(); setNeedsDisplay() }
    }

    var mySafeArea: CGRect {
        guard let superview = superview else { fatalError() }
        return superview.safeAreaLayoutGuide.layoutFrame
    }

    var myReadableArea: CGRect {
        guard let superview = superview else { fatalError() }
        return superview.readableContentGuide.layoutFrame
    }

    var myLayoutArea: CGRect {
        guard let superview = superview else { fatalError() }
        let layoutMargins = superview.layoutMargins
        return bounds.inset(by: layoutMargins)
    }

    private func addSafeAreaViews() {
        safeAreaHorizontalCenterView = MeasureDisplayView(frame: .zero)
        safeAreaHorizontalLeftView = MeasureDisplayView(frame: .zero)
        safeAreaHorizontalRightView = MeasureDisplayView(frame: .zero)

        safeAreaHorizontalCenterView.prefix = "safeAreaLayoutGuide: "
        safeAreaHorizontalCenterView.suffix = " pt"

        safeAreaVerticalCenterView = MeasureDisplayView(frame: .zero)
        safeAreaVerticalTopView = MeasureDisplayView(frame: .zero)
        safeAreaVerticalBottomView = MeasureDisplayView(frame: .zero)
        safeAreaVerticalTopBarView = MeasureDisplayView(frame: .zero)
        safeAreaVerticalBottomBarView = MeasureDisplayView(frame: .zero)

        safeAreaVerticalCenterView.isVertical = true
        safeAreaVerticalTopView.isVertical = true
        safeAreaVerticalBottomView.isVertical = true
        safeAreaVerticalTopBarView.isVertical = true
        safeAreaVerticalBottomBarView.isVertical = true

        safeAreaVerticalCenterView.prefix = "all: "
        safeAreaVerticalCenterView.suffix = " pt"

        addSubview(safeAreaHorizontalCenterView)
        addSubview(safeAreaHorizontalLeftView)
        addSubview(safeAreaHorizontalRightView)

        addSubview(safeAreaVerticalCenterView)
        addSubview(safeAreaVerticalTopView)
        addSubview(safeAreaVerticalBottomView)
        addSubview(safeAreaVerticalTopBarView)
        addSubview(safeAreaVerticalBottomBarView)
    }

    private func addReadableAreaViews() {
        readableAreaHorizontalCenterView = MeasureDisplayView(frame: .zero)
        readableAreaHorizontalLeftView = MeasureDisplayView(frame: .zero)
        readableAreaHorizontalRightView = MeasureDisplayView(frame: .zero)

        readableAreaHorizontalCenterView.prefix = "readableContentGuide: "
        readableAreaHorizontalCenterView.suffix = " pt"

        addSubview(readableAreaHorizontalCenterView)
        addSubview(readableAreaHorizontalLeftView)
        addSubview(readableAreaHorizontalRightView)
    }

    private func addLayoutMarginViews() {
        layoutMarginHorizontalCenterView = MeasureDisplayView(frame: .zero)
        layoutMarginHorizontalLeftView = MeasureDisplayView(frame: .zero)
        layoutMarginHorizontalRightView = MeasureDisplayView(frame: .zero)

        layoutMarginHorizontalCenterView.prefix = "layoutMargins: "
        layoutMarginHorizontalCenterView.suffix = " pt"

        addSubview(layoutMarginHorizontalCenterView)
        addSubview(layoutMarginHorizontalLeftView)
        addSubview(layoutMarginHorizontalRightView)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        UIColor(named: "FrameBorderGray")?.set()

        let mySafePath = UIBezierPath(rect: mySafeArea)
        mySafePath.stroke()

        let safePath = UIBezierPath(rect: safeArea)
        safePath.stroke()

        let readablePath = UIBezierPath(rect: readableArea)
        readablePath.stroke()

        let layoutPath = UIBezierPath(rect: layoutArea)
        layoutPath.stroke()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layoutSafeAreaViews()
        layoutReadableAreaViews()
        layoutLayoutMarginViews()

        setNeedsDisplay()
    }

    private func layoutSafeAreaViews() {
        let x = readableArea.maxX - 40
        let y = readableArea.maxY - 40
        let height = CGFloat(24.0)
        let width = CGFloat(24.0)

        safeAreaHorizontalCenterView.frame = CGRect(x: safeArea.minX,
                                                    y: y,
                                                    width: safeArea.width,
                                                    height: height)

        safeAreaHorizontalLeftView.frame = CGRect(x: 0,
                                                  y: y,
                                                  width: safeArea.minX,
                                                  height: height)

        safeAreaHorizontalRightView.frame = CGRect(x: safeArea.maxX,
                                                   y: y,
                                                   width: bounds.width - safeArea.maxX,
                                                   height: height)

        safeAreaVerticalCenterView.frame = CGRect(x: x,
                                                  y: safeArea.minY,
                                                  width: width,
                                                  height: safeArea.height)

        safeAreaVerticalTopView.frame = CGRect(x: x,
                                               y: 0,
                                               width: width,
                                               height: mySafeArea.minY)

        safeAreaVerticalTopBarView.frame = CGRect(x: x,
                                                  y: mySafeArea.minY,
                                                  width: width,
                                                  height: safeArea.minY - mySafeArea.minY)

        safeAreaVerticalBottomView.frame = CGRect(x: x,
                                                  y: mySafeArea.maxY,
                                                  width: width,
                                                  height: bounds.height - mySafeArea.maxY)

        safeAreaVerticalBottomBarView.frame = CGRect(x: x,
                                                     y: safeArea.maxY,
                                                     width: width,
                                                     height: mySafeArea.maxY - safeArea.maxY)
    }

    private func layoutReadableAreaViews() {
        let y = readableArea.maxY - 70
        let height = CGFloat(24.0)

        readableAreaHorizontalCenterView.frame = CGRect(x: readableArea.minX,
                                                        y: y,
                                                        width: readableArea.width,
                                                        height: height)

        readableAreaHorizontalLeftView.frame = CGRect(x: 0,
                                                      y: y,
                                                      width: readableArea.minX,
                                                      height: height)

        readableAreaHorizontalRightView.frame = CGRect(x: readableArea.maxX,
                                                       y: y,
                                                       width: bounds.width - readableArea.maxX,
                                                       height: height)
    }

    private func layoutLayoutMarginViews() {
        let y = readableArea.maxY - 100
        let height = CGFloat(24.0)

        layoutMarginHorizontalCenterView.frame = CGRect(x: layoutArea.minX,
                                                        y: y,
                                                        width: layoutArea.width,
                                                        height: height)

        layoutMarginHorizontalLeftView.frame = CGRect(x: 0,
                                                      y: y,
                                                      width: layoutArea.minX,
                                                      height: height)

        layoutMarginHorizontalRightView.frame = CGRect(x: layoutArea.maxX,
                                                       y: y,
                                                       width: bounds.width - layoutArea.maxX,
                                                       height: height)
    }
}
