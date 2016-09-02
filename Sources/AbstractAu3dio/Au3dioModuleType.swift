//
//  Au3dioModuleType.swift
//  Au3dio
//
//  Created by Valentin Knabel on 08.08.16.
//
//

import RxSwift
import EasyInject
import DependencyAdditions

/// The configuration of `Au3dioModuleType`s.
/// It may be configured by mutation, but will be immutable when in use.
public struct Au3dioConfiguration {
    /// Generates an empty `Au3dioConfiguration`.
    ///
    /// - Parameter behaviors: Any injector that contains all behaviors.
    /// - Parameter importers: Any injector that contains all importers.
    /// - Parameter pipelines: Any injector that contains all pipelines.
    /// - Parameter pipelineForPath: Contains pipeline overriding points for the node tree.
    public init(
        behaviors: AnyInjector<BehaviorKey> = StrictInjector().erase(),
        importers: AnyInjector<ExportedKey> = StrictInjector().erase(),
        pipelines: AnyInjector<PipelineKey> = StrictInjector().erase(),
        pipelineForPath: [ImportableKeyPath: Pipeline] = [:])
    {
        self.behaviors = behaviors
        self.importers = importers
        self.pipelines = pipelines
        self.pipelineForPath = pipelineForPath
    }

    /// This shall contain all behaviors that shall be attached to the `Au3dioModuleType`.
    /// Usually the behaviors are of type `Provider<BehaviorKey, RootBehaviorSubscriber>`,
    /// but it is possible to declare differen behavior types, 
    /// whereas it requires a RootBehaviorSubscriber, that bootstraps the custom behavior. 
    public var behaviors: AnyInjector<BehaviorKey>
    public var importers: AnyInjector<ExportedKey>
    public var pipelines: AnyInjector<PipelineKey>

    /// Declared paths that shall be overridden to use a specific `Pipeline`. 
    /// A default (or root) `Pipeline` is required. 
    /// If there is no override given for a specific path, it will be derived from the root.
    ///
    /// Setting pipelineForPath to
    /// ```
    /// ["": JsonPipeline, "b": RealmPipeline]
    /// ```
    /// will result in following association of `Au3dioModuleType.rootSubject` values `Pipeline`s of `Au3dioConfiguration.pipelines`:
    /// ~~~
    ///   root               JsonPipeline
    ///    / \      =>          / \
    ///   a   b     JsonPipeline   RealmPipeline
    /// ~~~
    public var pipelineForPath: [ImportableKeyPath: Pipeline]
}

/// The central context. All plugins need to be develop against this API.
public protocol Au3dioModuleType {
    init(configuration: Au3dioConfiguration)

    /// A `RxSwift.BehaviorSubject` that contains the root node.
    var rootSubject: BehaviorSubject<RootNode?> { get }
    /// A immutable copy of the configuration.
    var configuration: Au3dioConfiguration { get }
}

public extension Au3dioModuleType {
    /// Contains all behaviors that are attached to the `Au3dioModuleType`.
    /// - See: `Au3dioConfiguration.behaviors`
    public var behaviors: AnyInjector<BehaviorKey> {
        return configuration.behaviors
    }
    /// Contains all importers that are attached to the `Au3dioModuleType`.
    /// - See: `Au3dioConfiguration.importers`
    public var importers: AnyInjector<ExportedKey> {
        return configuration.importers
    }
    /// Contains all pipelines that are used by the `Au3dioModuleType`.
    /// - See: `Au3dioConfiguration.pipelines`
    public var pipelines: AnyInjector<PipelineKey> {
        return configuration.pipelines
    }
    /// Declares overriding point for `ExportedPath`s' `Pipeline`s.
    /// - See: `Au3dioConfiguration.pipelineForPath`
    public var pipelineForPath: [ImportableKeyPath: Pipeline] {
        return configuration.pipelineForPath
    }

    public init(configure: (inout Au3dioConfiguration) -> Void) {
        var conf = Au3dioConfiguration()
        configure(&conf)
        self.init(configuration: conf)
    }
}

public extension Au3dioModuleType {
    public func lensedSubject<P>(lens: Lens<RootNode?, P?>) throws -> LensSubject<RootNode?, P?> {
        return try LensSubject(subject: rootSubject, lens: lens)
    }

    public func pipeline(forPath path: ImportedKeyPath) -> Pipeline {
        return pipeline(forParsed: path.map({ imported in
            imported.parsed
        }))
    }

    private func pipeline(forParsed path: ParsedImportablePath) -> Pipeline {
        if let pipeline = pipelineForPath[path.reduce("/", combine: { (exportedPath: ExportedKeyPath, parsed: ParsedImportable) in
            return exportedPath + parsed.exported
        })] {
            return pipeline
        } else if path.count > 0 {
            var segs = path
            _ = segs.popLast()
            return pipeline(forParsed: segs)
        } else {
            fatalError("No Pipeline provided for \"/\"")
        }
    }

    public func createPipedNode(forPath path: ImportedKeyPath) -> PipedNode {
        let parsedPath = path.map({ $0.parsed })
        let pipeline = self.pipeline(forParsed: parsedPath)
        return pipeline.createPipedNode(forParsed: parsedPath)
    }

    public func createPipedNode(forParsed path: ParsedImportablePath) -> PipedNode {
        let pipeline = self.pipeline(forParsed: path)
        return pipeline.createPipedNode(forParsed: path)
    }
}
