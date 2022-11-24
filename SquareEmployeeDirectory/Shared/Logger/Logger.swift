//
//  Logger.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/23/22.
//

import Foundation

class Logger {
    
    static let shared = Logger()
    
    func logError(error: Error) {
        #if DEBUG
        print("An error ocurred: \(error)")
        #endif
    }
    
    func logEvent(name: String, surface: String? = nil) {
        #if DEBUG
        var stringEvent = "Event logged: \(name)"
        if let surface = surface {
            stringEvent = stringEvent + " Surface \(surface)"
        }
        print(stringEvent)
        #endif
    }
}
