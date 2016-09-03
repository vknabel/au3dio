//
//  Import+Default.swift
//  Au3dio
//
//  Created by Valentin Knabel on 03.09.16.
//
//

import EasyInject

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
