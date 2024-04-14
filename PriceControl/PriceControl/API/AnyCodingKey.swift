//
//  AnyCodingKey.swift
//  PriceControl
//
//  Created by Матвей Кузнецов on 12.04.2024.
//

import Foundation

public struct AnyCodingKey: CodingKey {
    public var stringValue: String
    
    public init(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }
    
    public var intValue: Int?
    
    public init(intValue: Int) {
        self.intValue = intValue
        self.stringValue = "\(intValue)"
    }
}
