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

#if swift(>=3.0)
public typealias Node<v: InjectionValidator, t: TypedKey> = Validated<v, InjectorNode<t>>
#endif
