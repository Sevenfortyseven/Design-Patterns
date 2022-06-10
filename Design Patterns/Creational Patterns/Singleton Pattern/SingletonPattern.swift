//
//  Singleton Pattern.swift
//  Design Patterns
//
//  Created by aleksandre on 10.06.22.
//


/* • The singleton pattern restricts a class to only one instance.
   • The singleton plus pattern provides a “default” shared instance but also allows other instances to be created too. */



import UIKit

// MARK: -- Pure Singleton --
public class AppSettingsSingleton {
    public static let shared = AppSettingsSingleton()
    
    private init() { }
}


public class GenericViewController: UIViewController {
    
    public let settings = AppSettingsSingleton.shared
}


// MARK: -- Singleton Plus --
public class AppSettingsSingletonPlus {
    public static let shared = AppSettingsSingletonPlus()
    
    public init() { }
}

public class AnotherGenericViewController: UIViewController {
    
    public let settings = AppSettingsSingletonPlus.shared
    public let customSettings = AppSettingsSingletonPlus()
}

