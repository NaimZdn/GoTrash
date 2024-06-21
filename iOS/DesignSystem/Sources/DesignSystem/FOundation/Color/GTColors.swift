//
//  GTColors.swift
//
//
//  Created by Zidouni Naïm on 21/06/2024.
//

import SwiftUI

public typealias GTColor = ColorAsset.Color

// MARK: - Asset Catalogs

public enum Colors {
    public enum PrimaryPalette {
        public static let gtPrimary = ColorAsset(name: "GTPrimary")
        public static let gtBackground = ColorAsset(name: "GTBackground")
        public static let gtCardBackground = ColorAsset(name: "GTCardBackground")
        public static let gtText = ColorAsset(name: "GTText")
        public static let gtYellow = ColorAsset(name: "GTYellow")
    }
}

public final class ColorAsset {
    public fileprivate(set) var name: String
    
    public typealias Color = UIColor
    
    public private(set) lazy var color: Color = {
        guard let color = Color(asset: self) else {
            fatalError("Unable to load color asset named \(name).")
        }
        return color
    }()
    
    public func color(compatibleWith traitCollection: UITraitCollection) -> Color {
        let bundle = BundleToken.bundle
        guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
            fatalError("Unable to load color asset named \(name).")
        }
        return color
    }
    
    public private(set) lazy var swiftUIColor: SwiftUI.Color = {
        SwiftUI.Color(asset: self)
    }()
    
    fileprivate init(name: String) {
        self.name = name
    }
}

public extension ColorAsset.Color {
    convenience init?(asset: ColorAsset) {
        let bundle = BundleToken.bundle
        self.init(named: asset.name, in: bundle, compatibleWith: nil)
    }
}

public extension SwiftUI.Color {
    init(asset: ColorAsset) {
        let bundle = BundleToken.bundle
        self.init(asset.name, bundle: bundle)
    }
}

private final class BundleToken {
    static let bundle: Bundle = Bundle.module
}
