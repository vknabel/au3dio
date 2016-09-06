//
//  ProtocolInheritance.swift
//  Au3dio
//
//  Created by Valentin Knabel on 18.08.16.
//
//

import EasyInject
import DependencyAdditions

extension UnparsedKey: ParsedKeyConvertable, TypedKeyConvertable { }

extension AnyInjector: Reducable { }
extension GlobalInjector: Reducable { }
extension StrictInjector: Reducable { }
extension LazyInjector: Reducable { }
extension ComposedInjector: Reducable { }

extension Array: Reducable { }
extension Dictionary: Reducable { }
extension String: Reducable {
    public func reduce<T>(initial: T, @noescape combine: (T, Character) throws -> T) rethrows -> T {
        return try characters.reduce(initial, combine: combine)
    }
}
