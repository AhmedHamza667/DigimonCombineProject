//
//  DigimonViewManagerTests.swift
//  CombineAPITests
//
//  Created by Ahmed Hamza on 3/4/25.
//

import XCTest
@testable import CombineAPI
final class DigimonViewManagerTests: XCTestCase {
    var digimonViewModel: DigimonViewModel!
    var fakeDigimonService: FakeAPIServiceManager!

    override func setUpWithError() throws {
        // given
        fakeDigimonService = FakeAPIServiceManager()
        digimonViewModel = DigimonViewModel(apiManager: fakeDigimonService, coreDataManager: CoreDataManager())
    }

    override func tearDownWithError() throws {
        digimonViewModel = nil
        fakeDigimonService = nil
    }

    func testGetDigimonExpectingCorrectData() throws {
        let expectation = expectation(description: "ExpectingCorrectData")
        // when
        fakeDigimonService.testPath = "ValidDigimonList"
        digimonViewModel.getDigimon()
        DispatchQueue.main.async{
            XCTAssertNotNil(self.digimonViewModel)
            XCTAssertEqual(self.digimonViewModel.digimonList.count, 209)
            let firstDigimon = self.digimonViewModel.digimonList.first!
            XCTAssertEqual(firstDigimon.name, "Koromon")
            XCTAssertEqual(firstDigimon.level, "In Training")

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        
    }
    
    func testGetDigimonExpectingInCorrectData() throws {
        let expectation = expectation(description: "ExpectingInCorrectData")
        // when
        fakeDigimonService.testPath = "NotValidDigimonList"
        digimonViewModel.getDigimon()
        DispatchQueue.main.async{
            XCTAssertNotNil(self.digimonViewModel)
            XCTAssertEqual(self.digimonViewModel.digimonList.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        
    }
    
    func testSearchDigimonExpectingCorrectResult() throws {
        let expectation = expectation(description: "ExpectingCorrectResult")
        // when
        fakeDigimonService.testPath = "ValidDigimonList"
        digimonViewModel.getDigimon()
        DispatchQueue.main.async{
            XCTAssertNotNil(self.digimonViewModel)
            XCTAssertEqual(self.digimonViewModel.digimonList.count, 209)
            self.digimonViewModel.filterDigimon(filterText: "Koromon")
            let firstDigimon = self.digimonViewModel.digimonList.first!
            XCTAssertEqual(self.digimonViewModel.digimonList.count, 1)
            XCTAssertEqual(firstDigimon.name, "Koromon")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        
    }
    
    func testFilterDigimonExpectingCorrectResult() throws {
        let expectation = expectation(description: "ExpectingCorrectResult")
        // when
        fakeDigimonService.testPath = "ValidDigimonList"
        digimonViewModel.getDigimon()
        DispatchQueue.main.async{
            XCTAssertNotNil(self.digimonViewModel)
            XCTAssertEqual(self.digimonViewModel.digimonList.count, 209)
            self.digimonViewModel.filterDigimonByLevel(level: "Ultimate")
            XCTAssertEqual(self.digimonViewModel.digimonList.count, 46)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        
    }

    func testToggleFavExpectingCorrectResult() throws {
        let expectation = expectation(description: "ExpectingCorrectResult")
        // when
        fakeDigimonService.testPath = "ValidDigimonList"
        digimonViewModel.getDigimon()
        DispatchQueue.main.async{
            XCTAssertNotNil(self.digimonViewModel)
            XCTAssertEqual(self.digimonViewModel.digimonList.count, 209)
            let firstDigimon = self.digimonViewModel.digimonList.first!
            let lastDigimon = self.digimonViewModel.digimonList.last!
            self.digimonViewModel.toggleFav(firstDigimon)
            self.digimonViewModel.toggleFav(lastDigimon)
            XCTAssertEqual(self.digimonViewModel.favs.count, 2)
            XCTAssertEqual(firstDigimon.name, "Koromon")
            XCTAssertEqual(lastDigimon.name, "Omnimon")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
