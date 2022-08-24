//
//  DotServiceTest.swift
//  GDBDTests
//
//  Created by Samuel Wong on 25/8/2022.
//

import XCTest
@testable import GDBD

class DotServiceTests: XCTestCase {

    let persistanceController = PersistenceController(inMemory: true)
    lazy var mockDotService: DotCoreDataService = {
       return DotCoreDataService(persistenceController: persistanceController)
    }()

    func test_createDotForCoreData() throws {
        let test_isGood = true
        let test_text = "some text"
        let test_date = Date()
        
        mockDotService.fetchDots { dots, error in
            XCTAssert(dots.isEmpty)
        }
        
        mockDotService.createDot(isGood: test_isGood, withText: test_text, atDate: test_date) { dot, error in
            do {
                let testDot = try XCTUnwrap(dot)
                XCTAssert(testDot.is_good == test_isGood)
                XCTAssert(testDot.text == test_text)
                XCTAssert(testDot.date_time_created == test_date)
                
                self.mockDotService.fetchDots { dots, error in
                    XCTAssert(dots.count == 1)
                    XCTAssert(dots[0].is_good == test_isGood)
                    XCTAssert(dots[0].text == test_text)
                    XCTAssert(dots[0].date_time_created == test_date)
                }
            } catch {
                XCTFail("dot created was nil")
            }
        }
    }
}
