//
//  PinFieldView.swift
//  AMSI
//
//  Created by Anton Petrov on 24.10.2023.
//

import UIKit

protocol PinLabel: UIView {
    var active: Bool { get set }
    var text: String? { get set }
    var textColor: UIColor! { get set }
    var font: UIFont! { get set }
    func updateState()
}

class PinField<Label: PinLabel>: UITextField, UITextFieldDelegate {

    var numberOfDigits: Int = 4 {
        didSet { redraw() }
    }

    var spacing: Int = 8 {
        didSet { redraw() }
    }

    var labels: [Label] {
        return stackView.arrangedSubviews.compactMap({ $0 as? Label })
    }

    open override var text: String? {
        didSet {
            self.changeText(oldValue: oldValue, newValue: text)
        }
    }

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: self.bounds)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.isUserInteractionEnabled = false
        stackView.spacing = CGFloat(spacing)
        return stackView
    }()

    private var _textColor: UIColor?
    open override var textColor: UIColor? {
        didSet {
            if _textColor == nil {
                _textColor = oldValue
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        textColor = .clear
        keyboardType = .numberPad
        borderStyle = .none

        if #available(iOS 12.0, *) {
            textContentType = .oneTimeCode
        }

        delegate = self
        addTarget(self, action: #selector(textChanged), for: .editingChanged)

        addSubview(stackView)
    }

    open override func setNeedsLayout() {
        super.setNeedsLayout()
        stackView.frame = bounds
    }

    open func redraw() {
        stackView.spacing = CGFloat(spacing)

        stackView.arrangedSubviews.forEach { (view) in
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        for _ in 0 ..< self.numberOfDigits {
            let label = Label(frame: .zero)
            label.font = font
            label.isUserInteractionEnabled = false
            self.stackView.addArrangedSubview(label)
        }
    }

    private func updateFocus() {
        let focusIndex = text?.count ?? 0
        labels.enumerated().forEach { (index, label) in
            label.active = index == focusIndex
        }
    }

    private func removeFocus() {
        let focusIndex = text?.count ?? 0
        guard focusIndex < numberOfDigits else {
            return
        }
        labels[focusIndex].active = false
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard var text = self.text else {
            return false
        }

        if string.isEmpty, text.isEmpty == false {
            labels[text.count - 1].text = nil
            text.removeLast()
            self.text = text
            updateFocus()
            return false
        }

        return text.count < numberOfDigits
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateFocus()
    }

    @objc private func textChanged() {
        guard let text = text, text.count <= numberOfDigits else { return }

        labels.enumerated().forEach({ (index, label) in

            if index < text.count {
                let index = text.index(text.startIndex, offsetBy: index)
                let char = isSecureTextEntry ? "●" : String(text[index])
                label.text = char
            }
        })
        updateFocus()
    }

    private func changeText(oldValue: String?, newValue: String?) {
        guard let text = text, text.count <= numberOfDigits else { return }

        labels.enumerated().forEach({ (index, label) in

            if index < text.count {
                let index = text.index(text.startIndex, offsetBy: index)
                let char = isSecureTextEntry ? "●" : String(text[index])
                label.text = char
                label.updateState()
            }
        })
        if self.isFirstResponder {
            updateFocus()
        }
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        removeFocus()
    }

    open override func caretRect(for position: UITextPosition) -> CGRect {
        let index = self.text?.count ?? 0
        guard index < stackView.arrangedSubviews.count else {
            return .zero
        }

        let viewFrame = self.stackView.arrangedSubviews[index].frame
        let caretHeight = self.font?.pointSize ?? ceil(self.frame.height * 0.6)
        return CGRect(x: viewFrame.midX - 1, y: ceil((self.frame.height - caretHeight) / 2), width: 2, height: caretHeight)
    }
}

final class PinFieldTwo: PinField<PinFieldTwoLabel> {

    override var numberOfDigits: Int { didSet { redraw() } }

    override var spacing: Int { didSet { redraw() } }

    var boxBackgroundColor: UIColor = .white {
        didSet { redraw() }
    }

    var activeBoxBackgroundColor: UIColor = .white {
        didSet { redraw() }
    }

    var filledBoxBackgroundColor: UIColor = .white {
        didSet { redraw() }
    }

    var borderColor: UIColor = .lightGray {
        didSet { redraw() }
    }

    var activeBorderColor: UIColor? {
        didSet { redraw() }
    }

    var filledBorderColor: UIColor? {
        didSet { redraw() }
    }

    var cornerRadius: CGFloat = 0 {
        didSet { redraw() }
    }

    var boxPlaceholder: String? {
        didSet { redraw() }
    }

    var boxPlaceholderColor: UIColor? = .lightGray {
        didSet { redraw() }
    }

    override func redraw() {
        super.redraw()
        labels.forEach { (label) in
            label.backgroundColor = boxBackgroundColor
            label.activeBackgroundColor = activeBoxBackgroundColor
            label.filledBackgroundColor = filledBoxBackgroundColor
            label.activeBorderColor = activeBorderColor
            label.borderColor = borderColor
            label.cornerRadius = cornerRadius
            label.filledBorderColor = filledBorderColor
            label.placeholder = boxPlaceholder
            label.placeholderColor = boxPlaceholderColor
        }
    }
}

final class PinFieldTwoLabel: UIView, PinLabel {
    var text: String? {
        didSet { label.text = text }
    }

    var font: UIFont! {
        didSet { label.font = font }
    }

    var active = false {
        didSet {
            updateActive(oldValue: oldValue, newValue: active)
        }
    }

    var borderColor: UIColor? {
        didSet { redraw() }
    }

    var cornerRadius: CGFloat = 0 {
        didSet { redraw() }
    }

    var placeholder: String? {
        didSet { redraw() }
    }

    var placeholderColor: UIColor? {
        didSet { redraw() }
    }

    var textColor: UIColor! {
        didSet {
            self.label.textColor = textColor
        }
    }

    override var backgroundColor: UIColor? {
        get { return _backgroundColor }
        set {
            _backgroundColor = newValue
            self.layer.backgroundColor = newValue?.cgColor
        }
    }

    var activeBackgroundColor = UIColor.white
    var filledBackgroundColor = UIColor.white

    var activeBorderColor: UIColor?
    var filledBorderColor: UIColor?

    private var animator = UIViewPropertyAnimator()
    private let label: UILabel
    private var _backgroundColor: UIColor?

    private var hasText: Bool {
        return self.text?.isEmpty == false
    }

    override init(frame: CGRect) {
        self.label = UILabel(frame: frame)
        super.init(frame: frame)
        self.addSubview(label)
        label.alpha = 0
        self.label.textAlignment = .center
        self.clipsToBounds = false
    }

    func updateState() {
        self.stopAnimation()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.frame = self.bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateActive(oldValue: Bool, newValue: Bool) {
        guard oldValue != newValue else { return }

        if newValue == true {
            self.startAnimation()
        } else {
            self.stopAnimation()
        }
    }

    private func redraw() {
        self.layer.borderColor = self.borderColor?.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = self.cornerRadius
        if let placeholder = placeholder {
            self.label.textColor = placeholderColor
            self.label.text = placeholder
            self.label.alpha = 1
        }
    }

    private func startAnimation() {
        animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.9, animations: {
            self.layer.borderColor = self.activeBorderColor?.cgColor ?? self.borderColor?.cgColor
            self.layer.backgroundColor = self.activeBackgroundColor.cgColor
            self.label.alpha = 0
        })
        animator.startAnimation()
    }

    private func stopAnimation() {
        animator.addAnimations {
            self.layer.borderColor = self.hasText ? (self.filledBorderColor?.cgColor ?? self.borderColor?.cgColor) : self.borderColor?.cgColor
            self.layer.backgroundColor = self.hasText ? self.filledBackgroundColor.cgColor : self._backgroundColor?.cgColor
            self.label.textColor = self.hasText ? self.textColor : self.placeholderColor
            self.label.text = self.text ?? self.placeholder
            self.label.alpha = 1
        }
        animator.startAnimation()
    }
}
