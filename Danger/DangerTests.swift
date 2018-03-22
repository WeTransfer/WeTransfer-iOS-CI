//
//  DangerTests.swift
//  Rabbit
//
//  Created by Antoine van der Lee on 23/03/2017.
//  Copyright © 2017 WeTransfer. All rights reserved.
//

import Foundation

// This class contains several issues which will be tracked by Danger

// This will trigger a non final warning
class NonFiinalClass : NSObject {
    
    // Class inside comments should not trigger a Danger warning
    
    /*
    Class inside comment blocks should not trigger a Danger warning
    */
    
    // This is a SwiftLint warning
    var mySwiftLintProperty : String = "Trigger a warning for Colon Violation"
    
    func testUnownedSelf() {
        let myCustomBlock = { [unowned self] () -> Void in
            print("This log should warn our custom SwiftLint rule about logging \(self.mySwiftLintProperty)")
        }
        myCustomBlock()
    }
    
    /// This should trigger a warning for only calling super inside a method
    override func copy() -> Any {
        return super.copy()
    }
    
}

public final class UndocumentedClass {
    
    public var myUndocumentedVariable: String = ""
    
    public func myUndocumentedMethod() {
    }
}

public struct UndocumentedStruct {
    
}































































































































































// We've extended the file range to 200 lines, to test for the existance of MARK
