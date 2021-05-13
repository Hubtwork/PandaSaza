//
//  SchoolSearch.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/10.
//

import SwiftUI
import Combine
import Foundation

extension SchoolValidationView {
    
    struct SchoolSearch {
        
        var searchText: String = "" {
            didSet { filterSchools() }
        }
        
        var allSchools: Loadable<[School]> = .notRequested {
            didSet { filterSchools() }
        }
        
        private(set) var filtered: Loadable<[School]> = .notRequested
        
        var keyboardHeight: CGFloat = 0
        
        private mutating func filterSchools() {
            if searchText.count == 0 {
                filtered = allSchools
            } else {
                filtered = allSchools.map { schools in
                    schools.filter {
                        $0.name.range(of: searchText,
                                      options: .caseInsensitive,
                                      range: nil,
                                      locale: nil) != nil
                    }
                    
                }
            }
        }
    }
}
