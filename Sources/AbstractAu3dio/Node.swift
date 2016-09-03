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

#if !swift(>=3.0)
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
public typealias RootNodeValidator = TruthyValidator<PipedInjector<RootNodeKey>>
public typealias RootNode = Validated<RootNodeValidator>
#else
public typealias Node<v: InjectionValidator> = Validated<v>
public typealias RootNodeValidator = TruthyValidator<PipedInjector<RootNodeKey>>
public typealias RootNode = Validated<RootNodeValidator>
#endif
