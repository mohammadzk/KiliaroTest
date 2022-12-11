//
//  AlamoFireRequestTest.swift
//  KiliaroTestTests
//
//  Created by Mohammad khazaee on 12/11/22.
//

import XCTest


@testable import Alamofire

final class AlamoFireRequestTest: XCTestCase {
    
    var sut:Session!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try  super.setUpWithError()
        
        let configration = URLSessionConfiguration.af.default
        
        configration.protocolClasses = [MockURLProtocol.self] + (configration.protocolClasses ?? [])
        
        sut = Session(configuration: configration)
        
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try  super.tearDownWithError()
        sut = nil
    }
    
    func testsuccesfullRequest ()throws {
        
        MockURLProtocol.responseWithSuccesWith(statusCode: 200, url: URL(string: "https://api1.kiliaro.com")!)
        
        let request =   URLRequest(url: URL(string: "https://api1.kiliaro.com")!)
        
        let expectation = XCTestExpectation(description: "perform a succesfull get request")
        
        sut.request(request)
            .response(queue: DispatchQueue.main) { result in
                XCTAssertEqual(result.response?.statusCode, 200)
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 3)
        
    }
    
    func testCompletedWithError(){
        
        MockURLProtocol.responseWithError()
        
        let request =   URLRequest(url: URL(string: "https://api1.kiliaro.com")!)
        
        let expectation = XCTestExpectation(description: "gets error")
        
        sut.request(request)
            .response(queue: DispatchQueue.main) { result in
                XCTAssertNotNil(result.error)
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 3)
        
        
    }
    
}
