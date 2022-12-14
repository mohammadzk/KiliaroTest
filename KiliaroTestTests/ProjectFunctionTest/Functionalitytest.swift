//
//  Functionalitytest.swift
//  KiliaroTestTests
//
//  Created by Mohammad khazaee on 12/13/22.
//

import XCTest

@testable import KiliaroTest

final class Functionalitytest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDateFormater()throws {
        
        let dateStr = "2021-06-18T10:07:25Z"
        
        let dateFormater = DateFormatter()
        
        dateFormater.locale = Locale(identifier: "en_US_POSIX")
        
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let date = dateFormater.date(from: dateStr)
        
        XCTAssertNotNil(date)
      
        let secondFormater = DateFormatter()
        
        secondFormater.locale = Locale(identifier: "en_US_POSIX")
        
        secondFormater.dateFormat = "yyyy-MM-dd-HH:mm"
        
        secondFormater.timeZone = .current
        
        let finalStr = secondFormater.string(from: date!)
        
       XCTAssertNotNil(finalStr)
        
        
        
    }
    
    func testStringToDateString()throws {
        
        let dateStr = "2021-06-18T10:07:25Z"
        
        XCTAssertNotNil( dateStr.projectDateString())
    }
    
    func testWrongDateFormat()throws {
        let dateStr = "2021-06-18 10:07:25Z"
        
        XCTAssertNil(dateStr.projectDateString())
    }

    func testFileSizetoMegabyte()throws {
        
        let size:Int = 983178
      
        let mbStr = size.toMegabytes()
        
        print(mbStr)
        
        XCTAssertEqual(mbStr, "0.94 MB")
        
        
    }
 

}
