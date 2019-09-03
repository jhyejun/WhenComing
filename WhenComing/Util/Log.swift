//
//  Utility.swift
//  MilitaryTO
//
//  Created by 장혜준 on 20/02/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation
import os

enum LogCategory: String {
    // Default Category
    case Debug
    case Error
}

func debugLog(_ msg: Any, category: LogCategory = .Debug, file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
    let fileName: String.SubSequence = file.split(separator: "/").last ?? "FileName is None"
    let functionName: String.SubSequence = function.split(separator: "(").first ?? "FunctionName is None"
    let logString: String = "👻 [\(fileName)] \(functionName)(\(line)) : \(msg)"
    
    if #available(iOS 10.0, *) {
        os_log("%@",
               log: OSLog(subsystem: Bundle.main.bundleIdentifier ?? "Unknown SubSystem",
                          category: category.rawValue),
               type: .info, logString)
    } else {
        NSLog("%@", logString)
    }
    #endif
}

func errorLog(_ msg: Any, category: LogCategory = .Error, file: String = #file, function: String = #function, line: Int = #line) {
    let fileName: String.SubSequence = file.split(separator: "/").last ?? "FileName is None"
    let functionName: String.SubSequence = function.split(separator: "(").first ?? "FunctionName is None"
    let logString: String = "😡 [\(fileName)] \(functionName)(\(line)) : \(msg)"
    
    if #available(iOS 10.0, *) {
        os_log("%@",
               log: OSLog(subsystem: Bundle.main.bundleIdentifier ?? "Unknown SubSystem",
                          category: category.rawValue),
               type: .error, logString)
    } else {
        NSLog("%@", logString)
    }
}
