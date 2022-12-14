//
//  PhotoResponseTest.swift
//  KiliaroTestTests
//
//  Created by Mohammad khazaee on 12/9/22.
//

import XCTest

@testable import KiliaroTest

final class PhotoResponseTest: XCTestCase {
    
    var sut:[PhotoModel]!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
      try  super.setUpWithError()
        let fakeBuilder = fakeJsonBuilder()
        sut = try JSONDecoder().decode([PhotoModel].self, from:fakeBuilder.datafromJsonFile(fileName: "List"))
        
      
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try  super.tearDownWithError()
    }

    func testSutHasValue()throws {
        XCTAssertNotNil(sut)
    
    }
    func testSutdataisCotrrect(){
        XCTAssertEqual(sut.first?.fileId, "60cc705d0025904750ee22d300020eb4")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
