//
//  GDBDTests.swift
//  GDBDTests
//
//  Created by Samuel Wong on 12/8/2022.
//

import XCTest
@testable import GDBD

class CreateDotViewStoreTests: XCTestCase {

    func test_createGoodDot_succeedsHitsCompletion() throws {
        let sut = CreateDotViewStore(isGood: true, storageService: DotMockService(succeeds: true))
        
        var completionHits = false
        
        sut.createDot { dot in
            completionHits = true
        }
        
        XCTAssert(completionHits)
    }
    
    func test_createGoodDot_failureThrowsError() throws {
        let sut = CreateDotViewStore(isGood: true, storageService: DotMockService(succeeds: false))
        
        var completionHits = false
        
        XCTAssertNil(sut.error)
        XCTAssertFalse(sut.showAlert)
        sut.createDot { dot in
            completionHits = true
            XCTAssertNotNil(sut.error)
            XCTAssertTrue(sut.showAlert)
            
            sut.dismissError()
            XCTAssertNil(sut.error)
            XCTAssertFalse(sut.showAlert)
        }
        
        XCTAssert(completionHits)
    }
}
