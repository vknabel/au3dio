//
//  InjectionValidator.swift
//  Au3dio
//
//  Created by Valentin Knabel on 31.08.16.
//
//

import ValidatedExtension

/// Initially creates an `PipedInjector` from the `PipedNode`.
/// Thereafter the `PipedInjector` will be Validated.
/// The `Validator` type will come from the `Importer`.
public typealias Importer = (PipedNode) throws -> ValidatedType

public protocol InjectionValidator: Validator {
    associatedtype Key: TypedProvidableKey
}
public extension InjectionValidator where Self.WrappedType == InjectorNode<Self.Key> {
    /// Creates an `Importer` from the `Validator` with a conversion given.
    ///
    /// - Parameter convert: A converter that provides all neccessary and returny a `InjectorNode`.
    /// - Returns: The `Importer` that wraps the `PipedInjector` into a `Validated`.
    public func importer(withConversion convert: (PipedNode) -> InjectorNode<Key>) -> Importer {
        return { node in
            let pipedInjector = convert(node)
            return try Validated(pipedInjector) as Validated<Self>
        }
    }
}

/// Enables a computed property to create an importer.
public protocol ImporterFromInjectionValidator: InjectionValidator {
    /// Creates a `InjectorNode` from a given `PipedNode` with self as `Validator`.
    ///
    /// - Parameter node: The node, an `Injector` shall be built off.
    /// - Returns: A `InjectorNode` containing the node.
    func injecting(piped node: PipedNode) -> InjectorNode<Key>
}

public extension ImporterFromInjectionValidator where Self.WrappedType == InjectorNode<Self.Key> {
    /// Creates an `Importer` by using `ImporterFromInjectionValidator.injecting(piped:)` and self as `Validator`.
    /// - Returns: The created `Importer`.
    public var importer: Importer {
        return importer(withConversion: self.injecting)
    }
}
