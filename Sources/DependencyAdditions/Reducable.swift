//
//  Reducable.swift
//  Au3dio
//
//  Created by Valentin Knabel on 18.08.16.
//
//

/// Adds the capability to use `reduce` a specific type.
///
/// All `SequenceType`s are `Reducable` by default, but require an extension like:
/// ~~~
/// extension Array: Reducable { }
/// ~~~
///
/// Furthermore each `Injector` may be declared as `Reducable`.
public protocol Reducable {
    associatedtype Element

    /// - See `Swift.SequenceType.reduce(_:combine:)`
    @warn_unused_result
    func reduce<T>(initial: T, @noescape combine: (T, Element) throws -> T) rethrows -> T
}

import EasyInject

extension Injector {
    /// Adds all `Injector`s the capability to be reduced.
    /// When resolving `InjectionError`s will be ignored.
    /// This may be useful for mostly homogenous `Injector`s.
    ///
    /// - See `Swift.SequenceType.reduce(_:combine:)`
    @warn_unused_result
    public func reduce<T>(initial: T, @noescape combine: (T, (Key, Providable)) throws -> T) rethrows -> T {
        return try self.providedKeys.reduce(initial) { (t, key) -> T in
            guard let value = try? self.resolving(key: key) else { return t }
            return try combine(t, (key, value))
        }
    }
}

public extension ComposedInjector {
    /// Applies reduce to the left and right `Injector`. When resolving `InjectionError`s will be ignored.
    /// - See `Swift.SequenceType.reduce(_:combine:)`
    ///
    /// - Parameter initial: The initial result.
    /// - Parameter combine: Combines the current result with a partial one.
    /// - Throws: What `combine` throws.
    /// - Returns: The combined result.
    @warn_unused_result
    public func reduceBoth<T>(initial: T, @noescape combine: (T, (Key, Providable?, Providable?)) throws -> T) rethrows -> T {
        return try self.providedKeys.reduce(initial) { (t, key) -> T in
            guard let l = try? left.resolving(key: key),
                let r = try? right.resolving(key: key)
                else { return t }
            return try combine(t, (key, l, r))
        }
    }
}
