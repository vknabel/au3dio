//
//  Module+Extension.swift
//  Au3dio
//
//  Created by Valentin Knabel on 03.09.16.
//
//

import EasyInject
import DependencyAdditions

public extension Au3dioModuleType {
    /// Contains all behaviors that are attached to the `Au3dioModuleType`.
    /// - See: `Au3dioConfiguration.behaviors`
    public var behaviors: AnyInjector<BehaviorKey> {
        return configuration.behaviors
    }
    /// Contains all importers that are attached to the `Au3dioModuleType`.
    /// - See: `Au3dioConfiguration.importers`
    public var importers: AnyInjector<UnparsedKey> {
        return configuration.importers
    }
    /// Contains all pipelines that are used by the `Au3dioModuleType`.
    /// - See: `Au3dioConfiguration.pipelines`
    public var pipelines: AnyInjector<PipelineKey> {
        return configuration.pipelines
    }
    /// Declares overriding point for `ExportedPath`s' `Pipeline`s.
    /// - See: `Au3dioConfiguration.pipelineForPath`
    public var pipelineForPath: [UnparsedKeyPath: Pipeline] {
        return configuration.pipelineForPath
    }

    public init(configure: (inout Au3dioConfiguration) -> Void) {
        var conf = Au3dioConfiguration()
        configure(&conf)
        self.init(configuration: conf)
    }
}
