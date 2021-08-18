//
//  Ingredient.swift
//  Reciplease
//
//  Created by Gilles Sagot on 18/08/2021.
//

import Foundation
import CoreData


public class Ingredient: NSManagedObject {
    
}

extension Ingredient {
    override public func awakeFromInsert() {
        setPrimitiveValue(NSDate(), forKey: "createdAt")
    }

}


