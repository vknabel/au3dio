//
//  PipedInjector.swift
//  Au3dio
//
//  Created by Valentin Knabel on 31.08.16.
//
//

import EasyInject

/// Declares a PipedNode that will be provided by the DataManager.
public protocol PipedNode {
    var ownKey: ParsedImportable { get }
    var properties: [ParsedImportable] { get }

    func value<V>(for for: ParsedImportable) -> V
}

public typealias ProvidableExportableKey = protocol<ExportableKey, ProvidableKey>

public struct PipedInjector<K: protocol<ExportableKey, ProvidableKey>> {
    public var injector: LazyInjector<K>
    public var piped: PipedNode

    public init(piped node: PipedNode) {
        let properties: [(ParsedImportable, K)] = node.properties.flatMap({ raw in
            guard let k = K(parsed: raw) else { return nil }
            return (raw, k)
        })
        injector = properties.reduce(LazyInjector<K>()) { injector, prop in
            return injector.providing(key: prop.1, usingFactory: { _ in
                return node.value(for: prop.0)
            })
        }
        self.piped = node
    }
}
