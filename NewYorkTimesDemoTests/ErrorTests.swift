//
//  ErrorTests.swift
//  NewYorkTimesDemoTests
//
//  Created by Zhaoyang Li on 11/2/20.
//

import XCTest
@testable import NewYorkTimesDemo

class ErrorTests: XCTestCase {
    var error: AppError!
    
    func testErrors() {
        self.error = .invalidUrl
        XCTAssertFalse(self.error.localizedDescription.isEmpty)
    }
}
