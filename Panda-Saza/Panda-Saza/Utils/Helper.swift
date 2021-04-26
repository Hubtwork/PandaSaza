//
//  Helper.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/28.
//

import SwiftUI
import Combine

// MARK:- Custom Font Moudlize

extension Font {
    func nanum(size: Int) -> Font {
        return Font.custom("NanumGothic", size: CGFloat(size))
    }
    
    func nunumBolud(size: Int) -> Font {
        return Font.custom("NanumGothicBold", size: CGFloat(size))
    }
}

extension String {
    func localized(_ locale: Locale) -> String {
        let localeId = String(locale.identifier.prefix(2))
        guard let path = Bundle.main.path(forResource: localeId, ofType: "lproj"),
            let bundle = Bundle(path: path) else {
            return NSLocalizedString(self, comment: "")
        }
        return bundle.localizedString(forKey: self, value: nil, table: nil)
    }
}


// MARK:- Localization Related

extension EnvironmentValues {
    
    static var suppertedLocales: [Locale] = {
        return Bundle.main.localizations.map { Locale(identifier: $0) }
    }()
    
    static var currentLocale: Locale? {
        let current = Locale.current
        let fullId = current.identifier
        let shortId = String(fullId.prefix(2))
        return suppertedLocales.locale(withId: fullId) ??
            suppertedLocales.locale(withId: shortId)
    }
}

private extension Array where Element == Locale {
    func locale(withId identifier: String) -> Element? {
        first(where: { $0.identifier.hasPrefix(identifier) })
    }
}

extension Result {
    var isSuccess: Bool {
        switch self {
        case .success: return true
        case .failure: return false
        }
    }
}
