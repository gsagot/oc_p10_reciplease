//
//  Presentable.swift
//  Reciplease
//
//  Created by Gilles Sagot on 31/08/2021.
//

import Foundation

protocol Presentable {
    var label: String {get set}
    var image: String {get set}
    var url: String {get set}
    var yield: Double {get set}
    var ingredientLines:[String] {get set}
    var totalTime: Double {get set}
}


