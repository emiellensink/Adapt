//
//  MeasureDisplayView.swift
//  sizeit
//
//  Created by Emiel Lensink on 09/12/2018.
//  Copyright © 2018 Emiel Lensink. All rights reserved.
//

import UIKit

@IBDesignable
class MeasureDisplayView: UIView {
    enum Direction {
        case horizontal
        case vertical
    }

    enum TextAlignment {
        case left
        case center
        case right
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
    }

    var direction: Direction = .horizontal {
        didSet { setNeedsDisplay() }
    }

    var textAlignment: TextAlignment = .center {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var font = UIFont.systemFont(ofSize: 12, weight: .light) {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var prefix: String? {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var suffix: String? {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var offset: CGFloat = 0.0 {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var isHorizontal: Bool {
        get { return direction == .horizontal }
        set { direction = .horizontal; setNeedsDisplay() }
    }

    @IBInspectable var isVertical: Bool {
        get { return direction == .vertical }
        set { direction = .vertical; setNeedsDisplay() }
    }

    @IBInspectable var isLeftAligned: Bool {
        get { return textAlignment == .left }
        set { textAlignment = .left; setNeedsDisplay() }
    }

    @IBInspectable var isCenterAligned: Bool {
        get { return textAlignment == .center }
        set { textAlignment = .center; setNeedsDisplay() }
    }

    @IBInspectable var isRightAligned: Bool {
        get { return textAlignment == .right }
        set { textAlignment = .right; setNeedsDisplay() }
    }

    @IBInspectable var arrowColor: UIColor? = .black {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var textColor: UIColor? = .red {
        didSet { setNeedsDisplay() }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard rect.width != 0 && rect.height != 0 else { return }

        let size: CGFloat

        switch direction {
        case .horizontal:
            size = rect.width + offset
        case .vertical:
            size = rect.height + offset
        }

        let prefix = self.prefix ?? ""
        let suffix = self.suffix ?? ""
        let formattedSize = String(format: "%.0f", size)
        let text = "\(prefix)\(formattedSize)\(suffix)"
        let nsText = text as NSString

        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor ?? .black, NSAttributedString.Key.backgroundColor: backgroundColor ?? .clear]

        let textSize = (nsText as NSString).size(withAttributes: attributes)
        let projectedRect: CGRect

        switch direction {
        case .horizontal:
            projectedRect = CGRect(x: bounds.minX,
                                   y: bounds.minY,
                                   width: bounds.width,
                                   height: bounds.height)
        case .vertical:
            projectedRect = CGRect(x: bounds.minY,
                                   y: bounds.minX,
                                   width: bounds.height,
                                   height: bounds.width)
        }

        let context = UIGraphicsGetCurrentContext()

        context?.saveGState()
        if direction == .vertical {
            context?.rotate(by: -CGFloat.pi / 2.0)
            context?.translateBy(x: -projectedRect.width, y: 0)
        }

        let textRect: CGRect

        switch textAlignment {
        case .left:
            textRect = CGRect(x: 16,
                              y: (projectedRect.height / 2.0) - (textSize.height / 2.0),
                              width: textSize.width, height: textSize.height)
        case .center:
            textRect = CGRect(x: (projectedRect.width / 2.0) - (textSize.width / 2.0),
                              y: (projectedRect.height / 2.0) - (textSize.height / 2.0),
                              width: textSize.width, height: textSize.height)
        case .right:
            textRect = CGRect(x: projectedRect.width - textSize.width - 16,
                              y: (projectedRect.height / 2.0) - (textSize.height / 2.0),
                              width: textSize.width, height: textSize.height)
        }

        let slightlyBiggerTextRect = CGRect(origin: textRect.origin, size: CGSize(width: textRect.width + 5, height: textRect.height))
        
        nsText.draw(in: slightlyBiggerTextRect, withAttributes: attributes)

        if textRect.minX > 8 && projectedRect.width - textRect.maxX > 8 {
            arrowColor?.set()

            let centerY = projectedRect.height / 2.0 + 1

            let leftLine = UIBezierPath()
            leftLine.move(to: CGPoint(x: 1, y: centerY))
            leftLine.addLine(to: CGPoint(x: textRect.minX - 4, y: centerY))

            let rightLine = UIBezierPath()
            leftLine.move(to: CGPoint(x: textRect.maxX + 4, y: centerY))
            leftLine.addLine(to: CGPoint(x: projectedRect.width - 1, y: centerY))

            let leftTip = UIBezierPath()
            leftTip.move(to: CGPoint(x: 4, y: centerY - 3))
            leftTip.addLine(to: CGPoint(x: 1, y: centerY))
            leftTip.addLine(to: CGPoint(x: 4, y: centerY + 3))

            let rightTip = UIBezierPath()
            rightTip.move(to: CGPoint(x: projectedRect.width - 4, y: centerY - 3))
            rightTip.addLine(to: CGPoint(x: projectedRect.width - 1, y: centerY))
            rightTip.addLine(to: CGPoint(x: projectedRect.width - 4, y: centerY + 3))

            leftLine.stroke()
            leftTip.stroke()

            rightLine.stroke()
            rightTip.stroke()
        }
        context?.restoreGState()
    }
}
