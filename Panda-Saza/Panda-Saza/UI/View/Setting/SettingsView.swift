//
//  SettingView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/28.
//

import SwiftUI

struct SettingPicker<T>: View where T: Hashable {
        
    let title: LocalizedStringKey
    let pickerWidth: CGFloat
    let value: Binding<T>
    let values: [T]
    let valueTitle: (T) -> String
    
    var body: some View {
        HStack {
            Spacer(minLength: 8)
            SwiftUI.Picker("", selection: value.onChange({ _ in
                Haptic.toggleFeedback()
            })) {
                ForEach(values, id: \.self) { value in
                    Text(self.valueTitle(value))
                }
            }.pickerStyle(SegmentedPickerStyle())
            .frame(maxWidth: pickerWidth, alignment: .trailing)
        }
    }
}

// MARK: - Haptic
struct Haptic {
    
    static func successFeedback() {
        #if !os(macOS)
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        #endif
    }
    
    static func errorFeedback() {
        #if !os(macOS)
        UINotificationFeedbackGenerator().notificationOccurred(.error)
        #endif
    }
    
    static func toggleFeedback() {
        #if !os(macOS)
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        #endif
    }
}

// MARK: - Bindings
extension Binding {
    
    func map<T>(toValue: @escaping (Value) -> T,
                fromValue: @escaping (T) -> Value) -> Binding<T> {
        return .init(get: {
            toValue(self.wrappedValue)
        }, set: { value in
            self.wrappedValue = fromValue(value)
        })
    }
    
    func onChange(_ perform: @escaping (Value) -> Void) -> Binding<Value> {
        return .init(get: {
            self.wrappedValue
        }, set: { value in
            self.wrappedValue = value
            perform(value)
        })
    }
}
