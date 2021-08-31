//
//  ImageServiceTests.swift
//  RecipleaseTests
//
//  Created by Gilles Sagot on 30/08/2021.
//

import XCTest

@testable import Reciplease
@testable import Alamofire

class ImageServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        ImageService.shared.start()
        
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //MARK: - TESTS GET IMAGES
    
    func testGetImageShouldPostFailedIfError() {
        URLProtocol.registerClass(FakeURLProtocol.self)
        // Given
        FakeURLProtocol.request = { request in
            let data: Data? = nil
            let response: HTTPURLResponse? = nil
            let error: Error? = FakeResponseData.recipeError
            return (data, response, error)
        }
        let sessionTest:Session = {
            let configuration = URLSessionConfiguration.default
            configuration.protocolClasses = [FakeURLProtocol.self]
            return Session(configuration: configuration)
        }()
        let imageService = ImageService(session: sessionTest)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        imageService.getImage (url: "https://openclassrooms.com", completionHandler:{ (success, error, current) in
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == "Session task failed, Please check connection")
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }
    
    func testGetImageShouldPostFailedIfNoData() {
        URLProtocol.registerClass(FakeURLProtocol.self)
        // Given
        FakeURLProtocol.request = { request in
            let data: Data? = nil
            let response: HTTPURLResponse? = nil
            let error: Error? = nil
            return (data, response, error)
        }
        let sessionTest:Session = {
            let configuration = URLSessionConfiguration.default
            configuration.protocolClasses = [FakeURLProtocol.self]
            return Session(configuration: configuration)
        }()
        let imageService = ImageService(session: sessionTest)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        imageService.getImage (url: "https://openclassrooms.com",completionHandler:{ (success, error, current) in
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == "Session task failed, Please check connection")
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }
    
    func testGetImageShouldPostSuccessIfCorrectResponseWithData() {
        URLProtocol.registerClass(FakeURLProtocol.self)
        // Given
        FakeURLProtocol.request = { request in
            let data: Data? = FakeResponseData.recipeCorrectData
            let response: HTTPURLResponse? = FakeResponseData.responseOK
            let error: Error? = nil
            return (data, response, error)
        }
        let sessionTest:Session = {
            let configuration = URLSessionConfiguration.default
            configuration.protocolClasses = [FakeURLProtocol.self]
            return Session(configuration: configuration)
        }()
        let imageService = ImageService(session: sessionTest)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        imageService.getImage (url: "https://openclassrooms.com",completionHandler:{ (success, error, current) in
        // Then
            XCTAssertTrue(success)
            XCTAssertNil(error)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }

}
