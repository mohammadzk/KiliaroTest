//
//  RequestBuilderTest.swift
//  KiliaroTestTests
//
//  Created by Mohammad khazaee on 12/10/22.
//

import XCTest

@testable import KiliaroTest

final class RequestBuilderTest: XCTestCase {
    var sut:RequestBuilder!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try   super.setUpWithError()
        sut = RequestBuilder("https://api1.kiliaro.com", path: "/shared/").addPathItems(parameters: ["djlCbGusTJamg_ca4axEVw","media"]).setMethod(method: .get)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      try  super.tearDownWithError()
        sut = nil
    }

    func testAddPathParmeters()throws {
       let expectedUrl = "https://api1.kiliaro.com/shared/djlCbGusTJamg_ca4axEVw/media"
        
        XCTAssertNotNil(sut)
        
        XCTAssertEqual(expectedUrl, sut.request.url?.absoluteString,"this is the url string \(String(describing: sut.request.url?.absoluteString))")
        
        XCTAssertTrue(sut.request.httpMethod == "GET")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
