// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum LocalizedStrings {
  /// You have successfully 
  /// changed your password
  internal static let changePasswordSuccess = LocalizedStrings.tr("Localizable", "ChangePasswordSuccess", fallback: "You have successfully \nchanged your password")
  /// Continue with Google
  internal static let continuteWithGoogleButton = LocalizedStrings.tr("Localizable", "ContinuteWithGoogleButton", fallback: "Continue with Google")
  /// Create an account
  internal static let createAccount = LocalizedStrings.tr("Localizable", "CreateAccount", fallback: "Create an account")
  /// Don’t have an account?
  internal static let dontHaveAccountText = LocalizedStrings.tr("Localizable", "DontHaveAccountText", fallback: "Don’t have an account?")
  /// Email
  internal static let email = LocalizedStrings.tr("Localizable", "Email", fallback: "Email")
  /// Continue with Email
  internal static let emailButton = LocalizedStrings.tr("Localizable", "EmailButton", fallback: "Continue with Email")
  /// To do this, fill out our 
  /// convenient form
  internal static let firtstOnboardingText = LocalizedStrings.tr("Localizable", "FirtstOnboardingText", fallback: "To do this, fill out our \nconvenient form")
  /// Localizable.strings
  ///   AMSI
  /// 
  ///   Created by Anton Petrov on 09.10.2023.
  internal static let firtstOnboardingTitle = LocalizedStrings.tr("Localizable", "FirtstOnboardingTitle", fallback: "Upload your resume")
  /// Forgot Password?
  internal static let forgotPassword = LocalizedStrings.tr("Localizable", "ForgotPassword", fallback: "Forgot Password?")
  /// Your full name
  internal static let fullName = LocalizedStrings.tr("Localizable", "FullName", fallback: "Your full name")
  /// Login
  internal static let loginButton = LocalizedStrings.tr("Localizable", "LoginButton", fallback: "Login")
  /// Login
  internal static let loginTitle = LocalizedStrings.tr("Localizable", "LoginTitle", fallback: "Login")
  /// Or
  internal static let orSeparator = LocalizedStrings.tr("Localizable", "OrSeparator", fallback: "Or")
  /// Password
  internal static let password = LocalizedStrings.tr("Localizable", "Password", fallback: "Password")
  /// Resend code
  internal static let resendCode = LocalizedStrings.tr("Localizable", "ResendCode", fallback: "Resend code")
  /// Search and find your dream job 
  /// easily and quickly
  internal static let secondOnboardingText = LocalizedStrings.tr("Localizable", "SecondOnboardingText", fallback: "Search and find your dream job \neasily and quickly")
  /// Find Your Dream Job
  internal static let secondOnboardingTitle = LocalizedStrings.tr("Localizable", "SecondOnboardingTitle", fallback: "Find Your Dream Job")
  /// We have to send the verification to your email
  internal static let sendVerificationToEmail = LocalizedStrings.tr("Localizable", "SendVerificationToEmail", fallback: "We have to send the verification to your email")
  /// Sign In
  internal static let signInButton = LocalizedStrings.tr("Localizable", "SignInButton", fallback: "Sign In")
  /// Sign In with Google
  internal static let signInWithGoogle = LocalizedStrings.tr("Localizable", "SignInWithGoogle", fallback: "Sign In with Google")
  ///  Sign Up
  internal static let signUpButton = LocalizedStrings.tr("Localizable", "SignUpButton", fallback: " Sign Up")
  /// Skip
  internal static let skipButton = LocalizedStrings.tr("Localizable", "SkipButton", fallback: "Skip")
  /// Get your dream job & start working 
  /// in a new company
  internal static let thirdOnboardingText = LocalizedStrings.tr("Localizable", "ThirdOnboardingText", fallback: "Get your dream job & start working \nin a new company")
  /// Get your dream job
  internal static let thirdOnboardingTitle = LocalizedStrings.tr("Localizable", "ThirdOnboardingTitle", fallback: "Get your dream job")
  /// Verification Code
  internal static let verificationCode = LocalizedStrings.tr("Localizable", "VerificationCode", fallback: "Verification Code")
  /// Verify
  internal static let verifyButton = LocalizedStrings.tr("Localizable", "VerifyButton", fallback: "Verify")
  /// You have successfully 
  /// verified your account
  internal static let verifySuccess = LocalizedStrings.tr("Localizable", "VerifySuccess", fallback: "You have successfully \nverified your account")
  /// Welcome  to Amsi find job 
  /// your dream
  internal static let welcomeText = LocalizedStrings.tr("Localizable", "WelcomeText", fallback: "Welcome  to Amsi find job \nyour dream")
  /// Let’s Get Started
  internal static let welcomeTitle = LocalizedStrings.tr("Localizable", "WelcomeTitle", fallback: "Let’s Get Started")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension LocalizedStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

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
