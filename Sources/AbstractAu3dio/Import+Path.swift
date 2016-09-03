//
//  Import+Path.swift
//  Au3dio
//
//  Created by Valentin Knabel on 03.09.16.
//
//

/// - TODO:
///     - "/RootKey:scenarios:0/ScenarioKey:levels:0/LevelKey:"
///     - Take legacy IdPath and refactor it IdPath<ExportedKey>
public typealias UnparsedKeyPath = String
public typealias TypedKeyPath = [TypedKey]
public typealias ParsedKeyPath = [ParsedKey]

public extension UnparsedKeyPath {
    public static var pathSeparator: String {
        return "/"
    }

    public init?(parsedPath: ParsedKeyPath) {
        do {
            self = try parsedPath.reduce("", combine: { try $0 + $1.unparsed() })
        } catch {
            return nil
        }
    }

    public var parsedPath: ParsedKeyPath {
        return componentsSeparatedByString(UnparsedKeyPath.pathSeparator)
            .map({ ParsedKey(unparsed: $0)! })
    }
}
