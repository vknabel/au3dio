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
public struct PipelineKey: DefaultImportedKey {
    public static let importerKey = "PipelineKey"
    public let property: ImportableProperty
    public let parameter: ImportableParameter?

    public init(property: ImportableProperty, parameter: ImportableParameter?) {
        self.property = property
        self.parameter = parameter
    }
}



/// - TODO:
///     - Create new `PipedNode`
///     - Copy `PipedNode` from existing (via Extension?)
public protocol Pipeline: class {
    func createPipedNode(forPath path: ImportableKeyPath) -> PipedNode
}

public extension Pipeline {
    func createPipedNode(forParsed path: ParsedImportablePath) -> PipedNode {
        return createPipedNode(forPath: String(parsedPath: path))
    }
}
