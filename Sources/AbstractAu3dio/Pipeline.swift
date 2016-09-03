//
//  Pipeline.swift
//  Au3dio
//
//  Created by Valentin Knabel on 08.08.16.
//
//

import RxSwift
import DependencyAdditions

/// - TODO:
///     - Create new `PipedNode`
///     - Copy `PipedNode` from existing (via Extension?)
public protocol Pipeline: class {
    func createPipedNode(forPath path: UnparsedKeyPath) -> PipedNode
}
