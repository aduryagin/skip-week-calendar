import XCTest
import OSLog
import Foundation
@testable import SkipWeekCalendar

let logger: Logger = Logger(subsystem: "SkipWeekCalendar", category: "Tests")

@available(macOS 13, *)
final class SkipWeekCalendarTests: XCTestCase {
    func testSkipWeekCalendar() throws {
        logger.log("running testSkipWeekCalendar")
        XCTAssertEqual(1 + 2, 3, "basic test")
        
        // load the TestData.json file from the Resources folder and decode it into a struct
        let resourceURL: URL = try XCTUnwrap(Bundle.module.url(forResource: "TestData", withExtension: "json"))
        let testData = try JSONDecoder().decode(TestData.self, from: Data(contentsOf: resourceURL))
        XCTAssertEqual("SkipWeekCalendar", testData.testModuleName)
    }
}

struct TestData : Codable, Hashable {
    var testModuleName: String
}