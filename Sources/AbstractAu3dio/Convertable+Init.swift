//
//  Convertable+Init.swift
//  Au3dio
//
//  Created by Valentin Knabel on 03.09.16.
//
//

public extension UnparsedKey {
    public init?(unparsedConvertable convertable: UnparsedKeyConvertable) {
        guard let unparsed = try? convertable.unparsed() else { return nil }
        self = unparsed
    }
}

public extension ParsedKey {
    public init?(parsedConvertable convertable: ParsedKeyConvertable) {
        guard let parsed = try? convertable.parsed() else { return nil }
        self = parsed
    }
}

public extension TypedKey {
    // `TypedKey.init(parsed:)` is part of the protocol
}

// MARK: Paths
public extension UnparsedKeyPath {
    public init?(unparsedPathConvertable pathConvertable: UnparsedKeyPathConvertable) {
        guard let unparsedPath = try? pathConvertable.unparsedPath() else { return nil }
        self = unparsedPath
    }
}

// No `ParsedKeyPath.init(convertablePath:)` possible because of type restrictions.
// No `TypedKeyPath.init(convertablePath:)` possible because of type restrictions.
