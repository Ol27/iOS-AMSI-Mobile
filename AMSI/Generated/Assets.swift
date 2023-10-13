// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Assets {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal enum Colors {
    internal enum Shared {
      internal static let filledButtonText = ColorAsset(name: "FilledButtonText")
      internal static let mainAccent = ColorAsset(name: "MainAccent")
      internal static let mainText = ColorAsset(name: "MainText")
      internal static let screenBackground = ColorAsset(name: "ScreenBackground")
      internal static let secondaryText = ColorAsset(name: "SecondaryText")
      internal static let separator = ColorAsset(name: "Separator")
      internal static let textFieldBackground = ColorAsset(name: "TextFieldBackground")
    }
    internal static let splashScreen = ColorAsset(name: "SplashScreen")
  }
  internal enum Images {
    internal enum Authorization {
      internal static let amsiLogo = ImageAsset(name: "AmsiLogo")
      internal static let authorizationImage = ImageAsset(name: "AuthorizationImage")
      internal static let googleLogo = ImageAsset(name: "googleLogo")
    }
    internal enum FillData {
      internal static let addPhotoIcon = ImageAsset(name: "addPhotoIcon")
      internal static let addPhotoPlaceholder = ImageAsset(name: "addPhotoPlaceholder")
      internal static let addressIcon = ImageAsset(name: "addressIcon")
      internal static let contactInfoIcon = ImageAsset(name: "contactInfoIcon")
      internal static let nextButton = ImageAsset(name: "nextButton")
      internal static let pageOne = ImageAsset(name: "pageOne")
      internal static let pageThree = ImageAsset(name: "pageThree")
      internal static let pageTwo = ImageAsset(name: "pageTwo")
      internal static let usaFlag = ImageAsset(name: "usaFlag")
    }
    internal enum ForgotPassword {
      internal static let forgotPassword = ImageAsset(name: "ForgotPassword")
    }
    internal enum Home {
      internal static let homeScreen = ImageAsset(name: "HomeScreen")
    }
    internal enum Login {
      internal static let loginImage = ImageAsset(name: "LoginImage")
    }
    internal enum Onboarding {
      internal static let onboardingBackground = ImageAsset(name: "OnboardingBackground")
      internal static let onboardingButtonFirst = ImageAsset(name: "OnboardingButtonFirst")
      internal static let onboardingButtonSecond = ImageAsset(name: "OnboardingButtonSecond")
      internal static let onboardingButtonThird = ImageAsset(name: "OnboardingButtonThird")
      internal static let onboardingPictureFirst = ImageAsset(name: "OnboardingPictureFirst")
      internal static let onboardingPictureSecond = ImageAsset(name: "OnboardingPictureSecond")
      internal static let onboardingPictureThird = ImageAsset(name: "OnboardingPictureThird")
    }
    internal enum Shared {
      internal static let backButton = ImageAsset(name: "BackButton")
      internal static let orSeparator = ImageAsset(name: "OrSeparator")
      internal static let pickArrow = ImageAsset(name: "pickArrow")
      internal static let selectedArrow = ImageAsset(name: "selectedArrow")
    }
    internal enum SignUp {
      internal static let emailIcon = ImageAsset(name: "EmailIcon")
      internal static let fullNameIcon = ImageAsset(name: "FullNameIcon")
      internal static let hidePasswordButton = ImageAsset(name: "HidePasswordButton")
      internal static let paswordIcon = ImageAsset(name: "PaswordIcon")
      internal static let showPasswordButton = ImageAsset(name: "ShowPasswordButton")
    }
    internal enum Splash {
      internal static let splashLogo = ImageAsset(name: "SplashLogo")
    }
    internal enum Success {
      internal static let crossBackButton = ImageAsset(name: "CrossBackButton")
      internal static let successImage = ImageAsset(name: "SuccessImage")
    }
    internal enum Verification {
      internal static let verificationImage = ImageAsset(name: "VerificationImage")
    }
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
