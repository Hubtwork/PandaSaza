//
//  NetworkHelper.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/18.
//

import SwiftUI
import Combine
import Foundation


// MARK: - Publisher Helper

extension Publisher {
    
    func extractUnderlyingError() -> Publishers.MapError<Self, Failure> {
        mapError {
            ($0.underlyingError as? Failure) ?? $0
        }
    }
}

// MARK: - Underlying Error Helper

private extension Error {
    var underlyingError: Error? {
        let nsError = self as NSError
        if nsError.domain == NSURLErrorDomain && nsError.code == -1009 {
            // "The Internet connection appears to be offline."
            return self
        }
        return nsError.userInfo[NSUnderlyingErrorKey] as? Error
    }
}
