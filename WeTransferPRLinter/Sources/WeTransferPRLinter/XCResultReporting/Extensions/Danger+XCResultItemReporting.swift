//
//  File.swift
//  
//
//  Created by Antoine van der Lee on 21/10/2021.
//

import Foundation
import Danger

extension DangerDSL {
    func report(_ resultItem: XCResultItem) {
        if let file = resultItem.file, let line = resultItem.line {
            switch resultItem.category {
            case .message:
                message(message: resultItem.message, file: file, line: line)
            case .error:
                fail(message: resultItem.message, file: file, line: line)
            case .warning:
                warn(message: resultItem.message, file: file, line: line)
            }
        } else {
            switch resultItem.category {
            case .message:
                message(resultItem.message)
            case .error:
                fail(resultItem.message)
            case .warning:
                warn(resultItem.message)
            }
        }
    }
}
