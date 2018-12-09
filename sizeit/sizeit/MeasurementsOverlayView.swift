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
    private var safeAreaVerticalBottomView: MeasureDisplayView!
    private var safeAreaVerticalTopView: MeasureDisplayView!

    private var readableAreaHorizontalCenterView: MeasureDisplayView!
    private var readableAreaHorizontalLeftView: MeasureDisplayView!
    private var readableAreaHorizontalRightView: MeasureDisplayView!

    private var readableAreaVerticalCenterView: MeasureDisplayView!
    private var readableAreaVerticalBottomView: MeasureDisplayView!
    private var readableAreaVerticalTopView: MeasureDisplayView!

    private var layoutMarginHorizontalCenterView: MeasureDisplayView!
    private var layoutMarginHorizontalLeftView: MeasureDisplayView!
    private var layoutMarginHorizontalRightView: MeasureDisplayView!

    private var layoutMarginVerticalCenterView: MeasureDisplayView!
    private var layoutMarginVerticalBottomView: MeasureDisplayView!
    private var layoutMarginVerticalTopView: MeasureDisplayView!

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
            $0.arrowColor = UIColor(named: "TextDarkGray")
            $0.textColor = UIColor(named: "TextDarkGray")
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

    private func addSafeAreaViews() {
        safeAreaHorizontalCenterView = MeasureDisplayView(frame: .zero)
        safeAreaHorizontalLeftView = MeasureDisplayView(frame: .zero)
        safeAreaHorizontalRightView = MeasureDisplayView(frame: .zero)

        safeAreaHorizontalCenterView.prefix = "safe area: "
        safeAreaHorizontalCenterView.suffix = " pt"

        safeAreaVerticalCenterView = MeasureDisplayView(frame: .zero)
        safeAreaVerticalTopView = MeasureDisplayView(frame: .zero)
        safeAreaVerticalBottomView = MeasureDisplayView(frame: .zero)

        safeAreaVerticalCenterView.isVertical = true
        safeAreaVerticalTopView.isVertical = true
        safeAreaVerticalBottomView.isVertical = true

        safeAreaVerticalCenterView.prefix = "safe area: "
        safeAreaVerticalCenterView.suffix = " pt"

        addSubview(safeAreaHorizontalCenterView)
        addSubview(safeAreaHorizontalLeftView)
        addSubview(safeAreaHorizontalRightView)

        addSubview(safeAreaVerticalCenterView)
        addSubview(safeAreaVerticalTopView)
        addSubview(safeAreaVerticalBottomView)
    }

    private func addReadableAreaViews() {
        readableAreaHorizontalCenterView = MeasureDisplayView(frame: .zero)
        readableAreaHorizontalLeftView = MeasureDisplayView(frame: .zero)
        readableAreaHorizontalRightView = MeasureDisplayView(frame: .zero)

        readableAreaHorizontalCenterView.prefix = "readable area: "
        readableAreaHorizontalCenterView.suffix = " pt"

        readableAreaVerticalCenterView = MeasureDisplayView(frame: .zero)
        readableAreaVerticalTopView = MeasureDisplayView(frame: .zero)
        readableAreaVerticalBottomView = MeasureDisplayView(frame: .zero)

        readableAreaVerticalCenterView.isVertical = true
        readableAreaVerticalTopView.isVertical = true
        readableAreaVerticalBottomView.isVertical = true

        readableAreaVerticalCenterView.prefix = "readable area: "
        readableAreaVerticalCenterView.suffix = " pt"

        addSubview(readableAreaHorizontalCenterView)
        addSubview(readableAreaHorizontalLeftView)
        addSubview(readableAreaHorizontalRightView)

        addSubview(readableAreaVerticalCenterView)
        addSubview(readableAreaVerticalTopView)
        addSubview(readableAreaVerticalBottomView)
    }

    private func addLayoutMarginViews() {
        layoutMarginHorizontalCenterView = MeasureDisplayView(frame: .zero)
        layoutMarginHorizontalLeftView = MeasureDisplayView(frame: .zero)
        layoutMarginHorizontalRightView = MeasureDisplayView(frame: .zero)

        layoutMarginHorizontalCenterView.prefix = "layout margins: "
        layoutMarginHorizontalCenterView.suffix = " pt"

        layoutMarginVerticalCenterView = MeasureDisplayView(frame: .zero)
        layoutMarginVerticalTopView = MeasureDisplayView(frame: .zero)
        layoutMarginVerticalBottomView = MeasureDisplayView(frame: .zero)

        layoutMarginVerticalCenterView.isVertical = true
        layoutMarginVerticalTopView.isVertical = true
        layoutMarginVerticalBottomView.isVertical = true

        layoutMarginVerticalCenterView.prefix = "layout margins: "
        layoutMarginVerticalCenterView.suffix = " pt"

        addSubview(layoutMarginHorizontalCenterView)
        addSubview(layoutMarginHorizontalLeftView)
        addSubview(layoutMarginHorizontalRightView)

        addSubview(layoutMarginVerticalCenterView)
        addSubview(layoutMarginVerticalTopView)
        addSubview(layoutMarginVerticalBottomView)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let safePath = UIBezierPath(rect: safeArea)
        UIColor(named: "FrameBorderGray")?.set()
        safePath.stroke()

        let readablePath = UIBezierPath(rect: readableArea)
        readablePath.stroke()

        let layoutPath = UIBezierPath(rect: layoutArea)
        layoutPath.stroke()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let hideReadable = safeArea.height == readableArea.height
        readableAreaVerticalCenterView.isHidden = hideReadable
        readableAreaVerticalTopView.isHidden = hideReadable
        readableAreaVerticalBottomView.isHidden = hideReadable

        let hideLayoutMargin = safeArea.height == layoutArea.height
        layoutMarginVerticalCenterView.isHidden = hideLayoutMargin
        layoutMarginVerticalTopView.isHidden = hideLayoutMargin
        layoutMarginVerticalBottomView.isHidden = hideLayoutMargin

        var safeText = "safe area:"

        if hideReadable && hideLayoutMargin {
            safeText = "all: "
        } else {
            if hideReadable { safeText = "readable area, " + safeText }
            if hideLayoutMargin { safeText = "layout margins, " + safeText }
        }

        safeAreaVerticalCenterView.prefix = safeText

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
                                               height: safeArea.minY)

        safeAreaVerticalBottomView.frame = CGRect(x: x,
                                                  y: safeArea.maxY,
                                                  width: width,
                                                  height: bounds.height - safeArea.maxY)
    }

    private func layoutReadableAreaViews() {
        let x = readableArea.maxX - 70
        let y = readableArea.maxY - 70
        let height = CGFloat(24.0)
        let width = CGFloat(24.0)

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

        readableAreaVerticalCenterView.frame = CGRect(x: x,
                                                      y: readableArea.minY,
                                                      width: width,
                                                      height: readableArea.height)

        readableAreaVerticalTopView.frame = CGRect(x: x,
                                                   y: 0,
                                                   width: width,
                                                   height: readableArea.minY)

        readableAreaVerticalBottomView.frame = CGRect(x: x,
                                                      y: readableArea.maxY,
                                                      width: width,
                                                      height: bounds.height - readableArea.maxY)
    }

    private func layoutLayoutMarginViews() {
        let x = readableArea.maxX - 100
        let y = readableArea.maxY - 100
        let height = CGFloat(24.0)
        let width = CGFloat(24.0)

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

        layoutMarginVerticalCenterView.frame = CGRect(x: x,
                                                      y: layoutArea.minY,
                                                      width: width,
                                                      height: layoutArea.height)

        layoutMarginVerticalTopView.frame = CGRect(x: x,
                                                   y: 0,
                                                   width: width,
                                                   height: layoutArea.minY)

        layoutMarginVerticalBottomView.frame = CGRect(x: x,
                                                      y: layoutArea.maxY,
                                                      width: width,
                                                      height: bounds.height - layoutArea.maxY)
    }
}
