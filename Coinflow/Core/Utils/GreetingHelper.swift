//
//  GreetingHelper.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 01.02.2026.
//

import Foundation
import SwiftUI

struct GreetingHelper {
    
    static func greeting(for date: Date = Date()) -> LocalizedStringKey {
        
        let hour = Calendar.current.component(.hour, from: date)
        
        switch hour {
        case 5..<12:
            return "Good morning"
            
        case 12..<17:
            return "Good afternoon"
            
        case 17..<22:
            return "Good evening"
            
        default:
            return "Good night"
        }
    }
}
