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

    public init?(parsedPath path: ParsedKeyPath) {
        do {
            self = try path.map({ try $0.unparsed() }).joinWithSeparator(UnparsedKeyPath.pathSeparator)
        } catch {
            return nil
        }
    }

    public var parsedPath: ParsedKeyPath {
        return componentsSeparatedByString(UnparsedKeyPath.pathSeparator)
            .map({ ParsedKey(unparsed: $0)! })
    }
}
