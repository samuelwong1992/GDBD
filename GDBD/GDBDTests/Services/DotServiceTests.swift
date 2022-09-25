//
//  DotServiceTest.swift
//  GDBDTests
//
//  Created by Samuel Wong on 25/8/2022.
//

import XCTest
@testable import GDBD

class DotServiceTests: XCTestCase {

    var persistanceController: PersistenceController!
    var mockDotService: DotCoreDataService!
    
    override func setUp() {
        super.setUp()
        persistanceController = PersistenceController(inMemory: true)
        mockDotService = DotCoreDataService(persistenceController: persistanceController)
    }

    func test_createDotForCoreData() throws {
        let test_isGood = true
        let test_text = "some text"
        let test_date = Date()
        
        mockDotService.fetchDotsBetweenDate(startDate: Date().addingMonths(numMonths: -12), endDate: Date().addingMonths(numMonths: 12)) { dots, error in
            XCTAssert(dots.isEmpty)
        }
        
        mockDotService.createDot(isGood: test_isGood, withText: test_text, atDate: test_date, category: nil) { dot, error in
            do {
                let testDot = try XCTUnwrap(dot)
                XCTAssert(testDot.isGood == test_isGood)
                XCTAssert(testDot.text == test_text)
                XCTAssert(testDot.dateTimeCreated == test_date)
                
                self.mockDotService.fetchDotsBetweenDate(startDate: Date().addingMonths(numMonths: -12), endDate: Date().addingMonths(numMonths: 12)) { dots, error in
                    XCTAssert(dots.count == 1)
                    XCTAssert(dots[0].isGood == test_isGood)
                    XCTAssert(dots[0].text == test_text)
                    XCTAssert(dots[0].dateTimeCreated == test_date)
                }
            } catch {
                XCTFail("dot created was nil")
            }
        }
    }
    
    func test_fetchDotsBetweenDateForCoreData() throws {
        mockDotService.fetchDotsBetweenDate(startDate: Date().addingMonths(numMonths: -12), endDate: Date().addingMonths(numMonths: 12)) { dots, error in
            XCTAssert(dots.isEmpty)
        }
        
        let test_isGood = true
        let test_text = "some text"
        
        mockDotService.createDot(isGood: test_isGood, withText: test_text, atDate: Date(), category: nil) { dot, error in
            do {
                let _ = try XCTUnwrap(dot)
            } catch {
                XCTFail("dot created was nil")
            }
        }
        
        mockDotService.createDot(isGood: test_isGood, withText: test_text, atDate: Date().addingMonths(numMonths: 2), category: nil) { dot, error in
            do {
                let _ = try XCTUnwrap(dot)
            } catch {
                XCTFail("dot created was nil")
            }
        }
        
        mockDotService.createDot(isGood: test_isGood, withText: test_text, atDate: Date().addingMonths(numMonths: -2), category: nil) { dot, error in
            do {
                let _ = try XCTUnwrap(dot)
            } catch {
                XCTFail("dot created was nil")
            }
        }
        
        mockDotService.createDot(isGood: test_isGood, withText: test_text, atDate: Date().addingDays(numDays: 1), category: nil) { dot, error in
            do {
                let _ = try XCTUnwrap(dot)
            } catch {
                XCTFail("dot created was nil")
            }
        }
        
        self.mockDotService.fetchDotsBetweenDate(startDate: Date().addingMonths(numMonths: -1), endDate: Date().addingMonths(numMonths: 1)) { dots, error in
            XCTAssert(dots.count == 2)
        }
    }
    
    func test_earliestDot() throws {
        let test_isGood = true
        let test_text = "some text"
        
        let date = Date()
        let earlierDate = Date().addingDays(numDays: -1)
        
        mockDotService.fetchEarliestDot { dot, error in
            XCTAssertNil(dot)
        }
        
        mockDotService.createDot(isGood: test_isGood, withText: test_text, atDate: date, category: nil) { dot, error in
            XCTAssertNotNil(dot)
        }
        
        mockDotService.fetchEarliestDot { dot, error in
            do {
                let dot = try XCTUnwrap(dot)
                XCTAssertEqual(dot.dateTimeCreated.compare(date), .orderedSame)
            } catch {
                XCTFail("dot created was nil")
            }
        }
        
        mockDotService.createDot(isGood: test_isGood, withText: test_text, atDate: earlierDate, category: nil) { dot, error in
            XCTAssertNotNil(dot)
        }
        
        mockDotService.fetchEarliestDot { dot, error in
            do {
                let dot = try XCTUnwrap(dot)
                XCTAssertEqual(dot.dateTimeCreated.compare(earlierDate), .orderedSame)
            } catch {
                XCTFail("dot created was nil")
            }
        }
    }
}
