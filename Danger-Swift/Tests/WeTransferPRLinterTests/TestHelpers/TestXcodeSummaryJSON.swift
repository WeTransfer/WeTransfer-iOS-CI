//
//  TestXcodeSummaryJSON.swift
//  WeTransferPRLinterTests
//
//  Created by Antoine van der Lee on 13/01/2020.
//

import Foundation

/// Used for testing the Xcode Summary logic.
public let TestXcodeSummaryJSON = """

{
  "warnings": [

  ],
  "ld_warnings": [
    "ld: linking against a dylib which is not safe for use in application extensions: /Users/antoinevanderlee/Library/Developer/Xcode/DerivedData/Rabbit-ggzydsqyfdvoxobkplrlydytmvsw/Build/Products/Debug-iphonesimulator/Purchases.framework/Purchases"
  ],
  "compile_warnings": [
    {
      "file_name": "SessionDelegate.swift",
      "file_path": "/Users/antoinevanderlee/Documents/GIT-Projects/WeTransfer/Coyote/Submodules/Alamofire/Source/SessionDelegate.swift:554:15",
      "reason": "parameter of 'urlSession(_:dataTask:didReceive:)' has different optionality than expected by protocol 'URLSessionDataDelegate'",
      "line": "    open func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data?) {",
      "cursor": "              ^                                                                                    ~"
    }
  ],
  "errors": [

  ],
  "compile_errors": [

  ],
  "file_missing_errors": [

  ],
  "undefined_symbols_errors": [

  ],
  "duplicate_symbols_errors": [

  ],
  "tests_failures": {
  },
  "tests_summary_messages": [
    "\\t Executed 964 tests, with 0 failures (0 unexpected) in 135.257 (135.775) seconds\\n"
  ]
}

"""
