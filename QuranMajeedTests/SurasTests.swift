//
//  SurasTests.swift
//  QuranMajeedTests
//
//  Created by Takasur Azeem on 15/09/2023.
//

import XCTest
@testable import QuranKit
@testable import QuranTextKit

final class SurasTests: XCTestCase {

    override func setUpWithError() throws {
        XCTAssertNotNil(sut)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSurasLoading() throws {
        let suras = sut.suras
        XCTAssertEqual(suras.count, 114)
    }

    let sut: Quran = Quran.madani
}
