//
//  Import+Convert.swift
//  Au3dio
//
//  Created by Valentin Knabel on 03.09.16.
//
//

public protocol UnparsedKeyConvertable {
    func unparsed() throws -> UnparsedKey
}

public protocol ParsedKeyConvertable {
    func parsed() throws -> ParsedKey
}

public protocol TypedKeyConvertable {
    func typed<I: TypedKey>() throws -> I?
}

// MARK: Paths
public protocol UnparsedKeyPathConvertable {
    func unparsedPath() throws -> UnparsedKeyPath
}

public protocol ParsedKeyPathConvertable {
    func parsedPath() throws -> ParsedKeyPath
}

public protocol TypedKeyPathConvertable {
    func typedPath<I: TypedKey>() -> [I?]
}
