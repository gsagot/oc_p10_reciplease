//
//  RecipleaseUITests.swift
//  RecipleaseUITests
//
//  Created by Gilles Sagot on 01/09/2021.
//

import XCTest

class RecipleaseUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    /*
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
     */
    
    func testNavigation (){
        
        let app = XCUIApplication()
        let addStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Add"]/*[[".buttons[\"Add\"].staticTexts[\"Add\"]",".staticTexts[\"Add\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        addStaticText.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Clear"]/*[[".buttons[\"Clear\"].staticTexts[\"Clear\"]",".staticTexts[\"Clear\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        addStaticText.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Search for recipes"]/*[[".buttons[\"Search for recipes\"].staticTexts[\"Search for recipes\"]",".staticTexts[\"Search for recipes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tabBars["Tab Bar"].buttons["Favorite"].tap()
        
                
        
                        
    }
}
