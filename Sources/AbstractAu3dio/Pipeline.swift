//
//  Pipeline.swift
//  Au3dio
//
//  Created by Valentin Knabel on 08.08.16.
//
//

import RxSwift
import DependencyAdditions

/// A key used to injector data managers.
///
/// Declaration:
/// ~~~
/// extension Provider where Key == PipelineKey {
///     static var example: Provider<PipelineKey, Pipeline> {
///         return .derive()
///     }
/// }
/// ~~~
public struct PipelineKey: DefaultExportableKey {
    public static let prefix = "PipelineKey"
    public let key: String

    public init(key: String) {
        self.key = key
    }
}


/// - TODO:
///     - Create new `PipedNode`
///     - Copy `PipedNode` from existing (via Extension?)
public protocol Pipeline: class {
    func createPipedNode(forPath: ExportedPath) -> PipedNode
}
