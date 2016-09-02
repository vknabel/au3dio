//
//  ExportedKey.swift
//  Au3dio
//
//  Created by Valentin Knabel on 08.08.16.
//
//

import EasyInject
import Foundation
// ExportableKey -> ParsedExportable -> ExportedKey
// ImportedKey   <- ParsedImportable <- ImportableKey

public typealias ImportableKey = String

public typealias ImporterKey = String
public typealias ImportableProperty = String
public typealias ImportableParameter = String
public struct ParsedImportable {
    public var importerKey: ImporterKey // RootKey
    public var property: ImportableProperty // scenarios
    public var parameter: ImportableParameter? // 0

    public init(importerKey: ImporterKey, property: ImportableProperty, parameter: ImportableParameter? = nil) {
        self.importerKey = importerKey
        self.property = property
        self.parameter = parameter
    }
}
public typealias ParsedImportablePath = [ParsedImportable]

public protocol ImportedKey {
    init?(parsed: ParsedImportable)
    var parsed: ParsedImportable { get }
}


public typealias ExportableKey = ImportedKey
public typealias ParsedExportable = ParsedImportable
public typealias ExportedKey = ImportableKey


public typealias ExporterKey = ImporterKey
public typealias ExportableProperty = ImportableProperty
public typealias ExportableParameter = ImportableParameter

public extension ParsedImportable {
    public static var separator: String {
        return ":"
    }

    public init?(unparsed: ImportableKey) {
        let comps = unparsed.componentsSeparatedByString(ParsedImportable.separator)
        guard let importerKey = comps.first, let property = comps.dropFirst().first else {
            return nil
        }
        self.importerKey = importerKey
        self.property = property
        self.parameter = comps.dropFirst(2).first
    }

    public var exporterKey: ExporterKey {
        get {
            return self.importerKey
        }
        set {
            self.importerKey = newValue
        }
    }

    public var importable: ImportableKey {
        let key = importerKey + ParsedImportable.separator + property
        if let parameter = parameter {
            return key + ParsedImportable.separator + parameter
        }
        return key
    }

    public var exported: ExportedKey {
        return importable
    }
}

/// - TODO:
///     - "/RootKey:scenarios:0/ScenarioKey:levels:0/LevelKey:"
///     - Take legacy IdPath and refactor it IdPath<ExportedKey>
public typealias ImportableKeyPath = String
public typealias ExportedKeyPath = ImportableKeyPath
public typealias ImportedKeyPath = [ImportedKey]
public typealias ExportableKeyPath = ImportedKeyPath

public extension ImportableKeyPath {
    public static var pathSeparator: String {
        return "/"
    }

    public init(parsedPath: ParsedImportablePath) {
        self = parsedPath.reduce("", combine: { $0 + $1.importable })
    }

    public var parsed: ParsedImportablePath {
        return componentsSeparatedByString(ImportableKeyPath.pathSeparator)
            .map({ ParsedImportable(unparsed: $0)! })
    }
}

// MARK: Convenience
public protocol DefaultImportedKey: ExportableKey, ProvidableKey {
    static var importerKey: ImporterKey { get }
    var property: ImportableProperty { get }
    var parameter: ImportableParameter? { get }
    init(property: ImportableProperty, parameter: ImportableParameter?)
}
public typealias DefaultExportableKey = DefaultImportedKey

public extension DefaultImportedKey {
    public init(property: ImportableProperty) {
        self.init(property: property, parameter: nil)
    }

    public init?(parsed: ParsedImportable) {
        guard parsed.importerKey == Self.importerKey else { return nil }
        self.init(property: parsed.property, parameter: parsed.parameter)
    }

    public var parsed: ParsedImportable {
        return ParsedImportable(importerKey: Self.importerKey, property: property, parameter: parameter)
    }

    public var hashValue: Int {
        return property.hashValue + (parameter?.hashValue ?? 0)
    }
}
public func ==<E: DefaultImportedKey>(lhs: E, rhs: E) -> Bool {
    return lhs.property == rhs.property && lhs.parameter == rhs.parameter
}

public extension DefaultImportedKey {
    public static func derive(function: String = #function) -> Self {
        return Self(property: "\(function)(...) -> \(self)")
    }
}
