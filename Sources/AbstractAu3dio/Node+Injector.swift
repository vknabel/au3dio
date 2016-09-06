//
//  Node+Injector.swift
//  Au3dio
//
//  Created by Valentin Knabel on 06.09.16.
//
//

import EasyInject

public typealias TypedProvidableKey = protocol<TypedKey, ProvidableKey>

public struct InjectorNode<K: TypedProvidableKey> {
    public var injector: LazyInjector<K>
    public var piped: PipedNode

    public init(piped node: PipedNode) {
        let properties: [(ParsedKey, K)] = node.properties.flatMap({ raw in
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
