//
//  Logger.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/23/22.
//

import Foundation

class Logger {
    static func logError(error: Error) {
        #if DEBUG
        print(error)
        #endif
    }
}
