//
//  ExportedKey.swift
//  Au3dio
//
//  Created by Valentin Knabel on 08.08.16.
//
//

import EasyInject
import Foundation

public typealias ExportedKey = String
public protocol ExportableKey {
    init?(exported: ExportedKey)
    var exported: ExportedKey { get }
}

/// - TODO:
///     - Take legacy IdPath and refactor it IdPath<ExportedKey>
public typealias ExportablePath = ExportableKey
public typealias ExportedPath = ExportedKey

public extension ExportedPath {
    public static var pathSeparator: String {
        return "/"
    }

    public var segments: [ExportedKey] {
        return componentsSeparatedByString(ExportedPath.pathSeparator)
    }
}

// MARK: Convenience
public protocol DefaultExportableKey: ExportableKey, ProvidableKey {
    static var prefix: String { get }
    var key: String { get }
    init(key: String)
}
public extension DefaultExportableKey {
    init?(exported: ExportedKey) {
        return nil
    }
    var exported: ExportedKey {
        return "\(Self.prefix).\(key)"
    }

    var hashValue: Int {
        return key.hashValue
    }
}
public func ==<E: DefaultExportableKey>(lhs: E, rhs: E) -> Bool {
    return lhs.key == rhs.key
}

public extension DefaultExportableKey {
    public static func derive(function: String = #function) -> Self {
        return Self(key: "\(function)(...) -> \(self)")
    }
}
