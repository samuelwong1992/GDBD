//
//  CalendarViewStoreTests.swift
//  GDBDTests
//
//  Created by Samuel Wong on 12/9/2022.
//

import XCTest
@testable import GDBD

final class CalendarViewStoreTests: XCTestCase {
    var persistenceController: PersistenceController!
    
    override func setUp() {
        super.setUp()
        
        persistenceController = PersistenceController(inMemory: true)
        
        let dotCDService = DotCoreDataService(persistenceController: persistenceController)
        
        dotCDService.createDot(isGood: true, withText: nil, atDate: Date().firstDateOfMonth(), category: nil) { dot, error in }
        dotCDService.createDot(isGood: true, withText: nil, atDate: Date().firstDateOfMonth().addingDays(numDays: 1), category: nil) { dot, error in }
        dotCDService.createDot(isGood: true, withText: nil, atDate: Date().firstDateOfMonth().addingDays(numDays: 2), category: nil) { dot, error in }
        dotCDService.createDot(isGood: false, withText: nil, atDate: Date().lastDateOfMonth(), category: nil) { dot, error in }
        dotCDService.createDot(isGood: false, withText: nil, atDate: Date().lastDateOfMonth().addingDays(numDays: -1), category: nil) { dot, error in }
        dotCDService.createDot(isGood: false, withText: nil, atDate: Date().lastDateOfMonth().addingDays(numDays: -2), category: nil) { dot, error in }
        
        dotCDService.createDot(isGood: true, withText: nil, atDate: Date().firstDateOfMonth().addingMonths(numMonths: 3), category: nil) { dot, error in }
        dotCDService.createDot(isGood: true, withText: nil, atDate: Date().firstDateOfMonth().addingMonths(numMonths: 2), category: nil) { dot, error in }
        
        dotCDService.createDot(isGood: true, withText: nil, atDate: Date().firstDateOfMonth().addingMonths(numMonths: -3), category: nil) { dot, error in }
        dotCDService.createDot(isGood: true, withText: nil, atDate: Date().firstDateOfMonth().addingMonths(numMonths: -2), category: nil) { dot, error in }
        
    }
    
    func test_Initialize_MockSucceedsNoError() throws {
        let sut = CalendarViewStore(storageService: DotMockService(succeeds: true), date: .constant(Date()))
        
        XCTAssertNil(sut.error)
        XCTAssertFalse(sut.showError)
    }
    
    func test_Initialize_MockFailureThrowsError() throws {
        let sut = CalendarViewStore(storageService: DotMockService(succeeds: false), date: .constant(Date()))
        
        XCTAssertNotNil(sut.error)
        XCTAssertTrue(sut.showError)
        
        sut.dismissError()
        XCTAssertNil(sut.error)
        XCTAssertFalse(sut.showError)
    }
    
    func test_Initialize_SucceedsNoError() throws {
        let sut = CalendarViewStore(storageService: DotCoreDataService(persistenceController: persistenceController), date: .constant(Date()))
        
        XCTAssertNil(sut.error)
        XCTAssertFalse(sut.showError)
        
        XCTAssertEqual(sut.dots.count, 6)
        let dayItems = CalendarComponentViewStore.dayItemsFromSelectedDate(date: sut.selectedDate)
        XCTAssertEqual(dayItems.count, 7*5)
        
        for dayIndex in 0 ..< Date().lastDateOfMonth().get(.day) {
            let day = Date().firstDateOfMonth().addingDays(numDays: dayIndex)
            XCTAssertNotNil(dayItems.first(where: { $0.compare(day) == .orderedSame }))
        }
    }
    
    func test_DotsUpdateWhenDateChanged() throws {
        let sut = CalendarViewStore(storageService: DotCoreDataService(persistenceController: persistenceController), date: .constant(Date()))
        
        XCTAssertNil(sut.error)
        XCTAssertFalse(sut.showError)
        
        XCTAssertEqual(sut.dots.count, 6)
        
        sut.selectedDate = Date().addingMonths(numMonths: 3)
        XCTAssertEqual(sut.dots.count, 1)
    }
}
