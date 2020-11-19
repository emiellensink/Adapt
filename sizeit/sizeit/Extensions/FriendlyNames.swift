//
//  FriendlyNames.swift
//  sizeit
//
//  Created by Emiel Lensink on 10/12/2018.
//  Copyright © 2018 Emiel Lensink. All rights reserved.
//

import UIKit

extension UIUserInterfaceSizeClass {
    var friendlyName: String {
        switch self {
        case .compact: return "compact"
        case .regular: return "regular"
        default: return "unspecified"
        }
    }
}

extension UIDisplayGamut {
    var friendlyName: String {
        switch self {
        case .P3: return "Display P3"
        case .SRGB: return "sRGB"
        case .unspecified: return "unspecified"
        @unknown default:
            return "unknown"
        }
    }
}

extension UIUserInterfaceIdiom {
    var friendlyName: String {
        switch self {
        case .carPlay: return "carPlay"
        case .pad: return "pad (iPad)"
        case .phone: return "phone (iPhone)"
        case .tv: return "tv (Apple TV)"
        case .mac: return "Mac"
        case .unspecified: return "unspecified"
        default: return "unknown"
        }
    }
}

extension UIForceTouchCapability {
    var friendlyName: String {
        switch self {
        case .available: return "available"
        case .unavailable: return "not available"
        case .unknown: return "unknown"
        @unknown default:
            return "unknown"
        }
    }
}

extension UITraitEnvironmentLayoutDirection {
    var friendlyName: String {
        switch self {
        case .leftToRight: return "left to right"
        case .rightToLeft: return "right to left"
        case .unspecified: return "unspecified"
        @unknown default:
            return "unknown"
        }
    }
}

extension UIContentSizeCategory {
    var friendlyName: String {
        switch self {
        case .extraSmall: return "extra small"
        case .small: return "small"
        case .medium: return "medium"
        case .large: return "large"
        case .extraLarge: return "extra large"
        case .extraExtraLarge: return "extra extra large"
        case .extraExtraExtraLarge: return "extra extra extra large"
        case .accessibilityMedium: return "accessibility medium"
        case .accessibilityLarge: return "accessibility large"
        case .accessibilityExtraLarge: return "accessibility extra large"
        case .accessibilityExtraExtraLarge:  return "accessibility extra extra large"
        case .accessibilityExtraExtraExtraLarge: return "accessibility extra extra extra large"
        case .unspecified: return "unspecified"

        default:
            return "unknown"
        }
    }
}
