//
//  BuilderPattern.swift
//  Design Patterns
//
//  Created by aleksandre on 10.06.22.
//



/* • The builder pattern is great for creating complex objects in a step-by-step fashion. It involves three objects: the director, product and builder.
   • The director accepts inputs and coordinates with the builder; the product is the complex object that’s created; and the builder takes step-by-step inputs and creates the product. */


import Foundation

// MARK: -- Product
public struct Hamburger {
    public let meat: Meat
    public let sauce: Sauces
    public let toppings: Toppings
    
}

extension Hamburger: CustomStringConvertible {
    public var description: String {
        return meat.rawValue + " burget"
    }
}


public enum Meat: String {
    case beef
    case chicken
    case dog
    case pork
}

public struct Sauces: OptionSet {
    public static let mayo = Sauces(rawValue: 1 << 0)
    public static let mustard = Sauces(rawValue: 1 << 1)
    public static let ketchup = Sauces(rawValue: 1 << 2)
    public static let secret = Sauces(rawValue: 1 << 3)
    
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public struct Toppings: OptionSet {
    public static let cheese = Toppings(rawValue: 1 << 0)
    public static let lettuce = Toppings(rawValue: 1 << 1)
    public static let pickles = Toppings(rawValue: 1 << 2)
    public static let tomatoes = Toppings(rawValue: 1 << 3)
    
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

// MARK: -- Builder
public class HamburgerBuilder {
    
    public enum Error: Swift.Error {
        case soldOut
    }
    
    public private(set) var meat: Meat = .beef
    public private(set) var sauces: Sauces = []
    public private(set) var toppings: Toppings = []
    
    private var soldOutMeats: [Meat] = [.dog]
    
    
    public func addSauces(_ sauce: Sauces) {
        sauces.insert(sauce)
    }
    
    public func removeSauces(_ sauce: Sauces) {
        sauces.remove(sauce)
    }
    
    public func addToppings(_ topping: Toppings) {
        toppings.insert(topping)
    }
    
    public func removeToppings(_ topping: Toppings) {
        toppings.remove(topping)
    }
    
    public func setMeat(_ meat: Meat) throws {
        guard isAvailable(meat) else { throw Error.soldOut }
        self.meat = meat
    }
    
    public func isAvailable(_ meat: Meat) -> Bool {
        return !soldOutMeats.contains(meat)
    }
    
    public func build() -> Hamburger {
        return(Hamburger(meat: meat, sauce: sauces, toppings: toppings))
    }
}

// MARK: -- Director
public class Employee {
    
    public func createCombo1() throws -> Hamburger {
        let builder = HamburgerBuilder()
        try builder.setMeat(.beef)
        builder.addSauces(.secret)
        builder.addToppings([.cheese, .lettuce])
        return builder.build()
    }
    
    public func createDogSpecial() throws -> Hamburger {
        let builder = HamburgerBuilder()
        try builder.setMeat(.dog)
        builder.addSauces(.mayo)
        builder.addToppings([.pickles, .tomatoes])
        return builder.build()
    }
}


// MARK: -- Usage Example
public class Example {
    let burgerFlipper = Employee()
    
    func createBurgers() {
        if let combo1 = try? burgerFlipper.createCombo1() {
            print("\(combo1.description) is ready")
        }
    }
}
