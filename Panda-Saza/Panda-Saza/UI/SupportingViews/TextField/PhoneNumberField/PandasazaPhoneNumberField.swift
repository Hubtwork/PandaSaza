//
//  PhoneNumberField.swift
//  Panda-Saza
//
//  Created by 허재 on 2021/05/10.
//

import SwiftUI
import PhoneNumberKit

struct PandasazaPhoneNumberField: UIViewRepresentable {
    
    /// Real Input Text in TextField
    @Binding public var text: String
    /// Formated Text for User
    @State private var displayedText: String
    /// External isEditing
    private var externalResponder: Binding<Bool>?
    /// else, use Internal isEditing
    @State private var internalResponder: Bool = false
    
    private var isEditing: Bool {
        get { externalResponder?.wrappedValue ?? internalResponder }
        set {
            if externalResponder != nil {
                externalResponder!.wrappedValue = newValue
            } else {
                internalResponder = newValue
            }
        }
    }
    
    /// The maximum number of digits the phone number field allows. 🔢
    internal var maxDigitLength: Int
    /// The placeholder
    private let placeholder: String
    
    internal var textColor: UIColor
    internal var accentColor: UIColor
    /// The visual style of the phone number field. 🎀
    /// For now, this uses `UITextField.BorderStyle`. Updates on this modifier to come.
    internal var borderStyle: UITextField.BorderStyle = .none
    
    /// When set to `true`, the binding displays exactly what is in the text field.
    internal var formatted: Bool = true
    
    /// An action to perform when editing on the phone number field begins. ▶️
    /// The closure requires a `PhoneNumberTextField` parameter, which is the underlying `UIView`, that you can change each time this is called, if desired.
    internal var onBeginEditingHandler = { (view: PhoneNumberTextField) in }

    /// An action to perform when any characters in the phone number field are changed. 💬
    /// The closure requires a `PhoneNumberTextField` parameter, which is the underlying `UIView`, that you can change each time this is called, if desired.
    internal var onEditingChangeHandler = { (view: PhoneNumberTextField) in }
    
    /// An action to perform when editing on the phone number field ends. ⏹
    /// The closure requires a `PhoneNumberTextField` parameter, which is the underlying `UIView`, that you can change each time this is called, if desired.
    internal var onEndEditingHandler = { (view: PhoneNumberTextField) in }
    
    /// An action to perform when the phone number field is cleared. ❌
    /// The closure requires a `PhoneNumberTextField` parameter, which is the underlying `UIView`, that you can change each time this is called, if desired.
    internal var onClearHandler = { (view: PhoneNumberTextField) in }
    
    /// An action to perform when the return key on the phone number field is pressed. ↪️
    /// The closure requires a `PhoneNumberTextField` parameter, which is the underlying `UIView`, that you can change each time this is called, if desired.
    internal var onReturnHandler = { (view: PhoneNumberTextField) in }
    
    /// A closure that requires a `PhoneNumberTextField` object to be configured in the body. ⚙️
    public var configuration = { (view: PhoneNumberTextField) in }
    
    public init(_ title: String,
                text: Binding<String>,
                isEditing: Binding<Bool>,
                formatted: Bool = true,
                configuration: @escaping (UIViewType) -> () = { _ in } ) {
        self.placeholder = title
        self.externalResponder = isEditing
        self.formatted = formatted
        self._text = text
        self.configuration = configuration
    }
    
    public func makeUIView(context: UIViewRepresentableContext<Self>) -> PhoneNumberTextField {
            let uiView = UIViewType()
            
            uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
            uiView.addTarget(context.coordinator,
                             action: #selector(Coordinator.textViewDidChange),
                             for: .editingChanged)
            uiView.delegate = context.coordinator
            uiView.withExamplePlaceholder = placeholder == nil
            if let defaultRegion = defaultRegion {
                uiView.partialFormatter.defaultRegion = defaultRegion
            }
            
            return uiView
    }
    
    public func updateUIView(_ uiView: PhoneNumberTextField, context: UIViewRepresentableContext<Self>) {
            configuration(uiView)
            
            uiView.text = displayedText
            uiView.font = font
            uiView.maxDigits = maxDigits
            uiView.clearButtonMode = clearButtonMode
            uiView.placeholder = placeholder
            uiView.borderStyle = borderStyle
            uiView.textColor = textColor
            uiView.withFlag = showFlag
            uiView.withDefaultPickerUI = selectableFlag
            uiView.withPrefix = previewPrefix

            if placeholder != nil {
                uiView.placeholder = placeholder
            } else {
                uiView.withExamplePlaceholder = autofillPrefix
            }

            if autofillPrefix { uiView.resignFirstResponder() } // Workaround touch autofill issue
            uiView.tintColor = accentColor
            
            if let defaultRegion = defaultRegion {
                uiView.partialFormatter.defaultRegion = defaultRegion
            }
            if let numberPlaceholderColor = numberPlaceholderColor {
                uiView.numberPlaceholderColor = numberPlaceholderColor
            }
            if let countryCodePlaceholderColor = countryCodePlaceholderColor {
                uiView.countryCodePlaceholderColor = countryCodePlaceholderColor
            }
            if let textAlignment = textAlignment {
                uiView.textAlignment = textAlignment
            }

            if isFirstResponder {
                uiView.becomeFirstResponder()
            } else {
                uiView.resignFirstResponder()
            }
        }

        public func makeCoordinator() -> Coordinator {
            Coordinator(
                text: $text,
                        displayedText: $displayedText,
                        isFirstResponder: externalIsFirstResponder ?? $internalIsFirstResponder,
                        formatted: formatted,
                        onBeginEditing: onBeginEditingHandler,
                        onEditingChange: onEditingChangeHandler,
                        onPhoneNumberChange: onPhoneNumberChangeHandler,
                        onEndEditing: onEndEditingHandler,
                        onClear: onClearHandler,
                        onReturn: onReturnHandler)
        }

        public class Coordinator: NSObject, UITextFieldDelegate {
            internal init(
                text: Binding<String>,
                displayedText: Binding<String>,
                isFirstResponder: Binding<Bool>,
                formatted: Bool,
                onBeginEditing: @escaping (PhoneNumberTextField) -> () = { (view: PhoneNumberTextField) in },
                onEditingChange: @escaping (PhoneNumberTextField) -> () = { (view: PhoneNumberTextField) in },
                onPhoneNumberChange: @escaping (PhoneNumber?) -> () = { (view: PhoneNumber?) in },
                onEndEditing: @escaping (PhoneNumberTextField) -> () = { (view: PhoneNumberTextField) in },
                onClear: @escaping (PhoneNumberTextField) -> () = { (view: PhoneNumberTextField) in },
                onReturn: @escaping (PhoneNumberTextField) -> () = { (view: PhoneNumberTextField) in } )
            {
                self.text = text
                self.displayedText = displayedText
                self.isFirstResponder = isFirstResponder
                self.formatted = formatted
                self.onBeginEditing = onBeginEditing
                self.onEditingChange = onEditingChange
                self.onPhoneNumberChange = onPhoneNumberChange
                self.onEndEditing = onEndEditing
                self.onClear = onClear
                self.onReturn = onReturn
            }

            var text: Binding<String>
            var displayedText: Binding<String>
            var isFirstResponder: Binding<Bool>
            var formatted: Bool

            var onBeginEditing = { (view: PhoneNumberTextField) in }
            var onEditingChange = { (view: PhoneNumberTextField) in }
            var onPhoneNumberChange = { (phoneNumber: PhoneNumber?) in }
            var onEndEditing = { (view: PhoneNumberTextField) in }
            var onClear = { (view: PhoneNumberTextField) in }
            var onReturn = { (view: PhoneNumberTextField) in }

            @objc public func textViewDidChange(_ textField: UITextField) {
                guard let textField = textField as? PhoneNumberTextField else {
                    return assertionFailure("Undefined state")
                }
                
                // Updating the binding
                if formatted {
                    // Display the text exactly if unformatted
                    text.wrappedValue = textField.text ?? ""
                } else {
                    if let number = textField.phoneNumber {
                        // If we have a valid number, update the binding
                        let country = String(number.countryCode)
                        let nationalNumber = String(number.nationalNumber)
                        text.wrappedValue = "+" + country + nationalNumber
                    } else {
                        // Otherwise, maintain an empty string
                        text.wrappedValue = ""
                    }
                }
                
                displayedText.wrappedValue = textField.text ?? ""
                onEditingChange(textField)
                onPhoneNumberChange(textField.phoneNumber)
            }

            public func textFieldDidBeginEditing(_ textField: UITextField) {
                isFirstResponder.wrappedValue = true
                onBeginEditing(textField as! PhoneNumberTextField)
            }

            public func textFieldDidEndEditing(_ textField: UITextField) {
                isFirstResponder.wrappedValue = false
                onEndEditing(textField as! PhoneNumberTextField)
            }
            
            public func textFieldShouldClear(_ textField: UITextField) -> Bool {
                displayedText.wrappedValue = ""
                onClear(textField as! PhoneNumberTextField)
                return true
            }
            
            public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                onReturn(textField as! PhoneNumberTextField)
                return true
            }
        }
    
}
