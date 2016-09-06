//
//  Import.swift
//  Au3dio
//
//  Created by Valentin Knabel on 03.09.16.
//
//

// UnparsedKey -> ParsedKey -> TypedKey

public typealias UnparsedKey = String

public typealias ParsedType = String
public typealias ParsedProperty = String
public typealias ParsedParameter = String
public struct ParsedKey: UnparsedKeyConvertable, TypedKeyConvertable {
    public var parsedType: ParsedType // RootKey
    public var property: ParsedProperty // scenarios
    public var parameter: ParsedParameter? // 0

    public init(parsedType: ParsedType, property: ParsedProperty, parameter: ParsedParameter? = nil) {
        self.parsedType = parsedType
        self.property = property
        self.parameter = parameter
    }
}

public protocol TypedKey: ParsedKeyConvertable {
    init?(parsed: ParsedKey)
}
