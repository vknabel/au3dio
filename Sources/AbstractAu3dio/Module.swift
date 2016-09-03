//
//  Module.swift
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
