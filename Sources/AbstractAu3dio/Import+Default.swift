//
//  Import+Default.swift
//  Au3dio
//
//  Created by Valentin Knabel on 03.09.16.
//
//

import EasyInject

public protocol DefaultTypedKey: TypedKey, ProvidableKey {
    static var parsedType: ParsedType { get }
    var property: ParsedProperty { get }
    var parameter: ParsedParameter? { get }
    init(property: ParsedProperty, parameter: ParsedParameter?)
}
public typealias DefaultExportableKey = DefaultTypedKey

public extension DefaultTypedKey {
    public init(property: ParsedProperty) {
        self.init(property: property, parameter: nil)
    }

    public init?(parsed: ParsedKey) {
        guard parsed.parsedType == Self.parsedType else { return nil }
        self.init(property: parsed.property, parameter: parsed.parameter)
    }

    public func parsed() throws -> ParsedKey {
        return try ParsedKey(parsedType: Self.parsedType, property: property, parameter: parameter)
    }

    public var hashValue: Int {
        return property.hashValue + (parameter?.hashValue ?? 0)
    }
}
public func ==<E: DefaultTypedKey>(lhs: E, rhs: E) -> Bool {
    return lhs.property == rhs.property && lhs.parameter == rhs.parameter
}

public extension DefaultTypedKey {
    public static func derive(function: String = #function) -> Self {
        return Self(property: "\(function)(...) -> \(self)")
    }
}
