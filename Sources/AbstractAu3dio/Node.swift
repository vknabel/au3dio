//
//  Node.swift
//  Au3dio
//
//  Created by Valentin Knabel on 08.08.16.
//
//

import RxSwift
import ValidatedExtension
import DependencyAdditions
import EasyInject

/// Declares a PipedNode that will be provided by the DataManager.
public protocol PipedNode {
    var exportedKey: ExportedKey { get }

    func value<V>(for: ExportedKey) -> V
}

public typealias PipedInjector = (injector: Injector, node: PipedNode)
/// A Node is a validated DataNode.
/// Extensions may add computed properties to it.
///
/// ~~~
/// extension ValidatedType where ValidatorType == MyCustomValidator {
///    var myProperty: MyPropertyType? {
///         return try? value.injector.resolve(from: .myProperty)
///     }
/// }
/// ~~~
public typealias Node = Validated<TruthyValidator<PipedInjector>>
public typealias RootNode = Validated<TruthyValidator<PipedInjector>>
public typealias RootBehaviorSubscriber = (Observable<RootNode>) -> Disposable

/// Initially creates an `PipedInjector` from the `PipedNode`.
/// Thereafter the `PipedInjector` will be Validated.
/// The `Validator` type will come from the `Importer`.
public typealias Importer = (PipedNode) throws -> ValidatedType

public extension Validator where Self.WrappedType == PipedInjector {
    /// Creates an `Importer` from the `Validator` with a conversion given.
    ///
    /// - Parameter convert: A converter that provides all neccessary and returny a `PipedInjector`.
    /// - Returns: The `Importer` that wraps the `PipedInjector` into a `Validated`.
    public func importer(withConversion convert: (PipedNode) -> PipedInjector) -> Importer {
        return { node in
            let pipedInjector = convert(node)
            return try Validated(pipedInjector) as Validated<Self>
        }
    }
}

/// Enables a computed property to create an importer.
public protocol ImporterFromInjectionValidator: Validator {
    /// Creates a `PipedInjector` from a given `PipedNode` with self as `Validator`.
    ///
    /// - Parameter node: The node, an `Injector` shall be built off.
    /// - Returns: A `PipedInjector` containing the node.
    func injecting(piped node: PipedNode) -> PipedInjector
}

public extension ImporterFromInjectionValidator where Self.WrappedType == PipedInjector {
    /// Creates an `Importer` by using `ImporterFromInjectionValidator.injecting(piped:)` and self as `Validator`.
    /// - Returns: The created `Importer`.
    public var importer: Importer {
        return importer(withConversion: self.injecting)
    }
}
