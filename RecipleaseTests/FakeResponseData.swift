//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Gilles Sagot on 10/08/2021.
//

import Foundation

class FakeResponseData {
    // MARK: - Data
    static var recipeCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Edamam", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static let recipeIncorrectData = "erreur".data(using: .utf8)!


    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!


    // MARK: - Error
    class RecipeError: Error {}
    static let recipeError = RecipeError()
    
    
}
