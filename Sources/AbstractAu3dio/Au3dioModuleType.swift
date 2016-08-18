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

public struct Au3dioConfiguration {
    public init() { }

    public var behaviors: AnyInjector<BehaviorKey> = StrictInjector().erase()
    public var importers: AnyInjector<ExportedKey> = StrictInjector().erase()
    public var pipelines: AnyInjector<PipelineKey> = StrictInjector().erase()

    public var pipelineForPath: [ExportedPath: Pipeline] = [:]
}

public protocol Au3dioModuleType {
    init(configuration: Au3dioConfiguration)

    var rootSubject: BehaviorSubject<RootNode?> { get }
    var configuration: Au3dioConfiguration { get }
}

/// - TODO:
///     - func pipeline(forPath: ExportablePath) -> Pipeline?
public extension Au3dioModuleType {
    public var behaviors: AnyInjector<BehaviorKey> {
        return configuration.behaviors
    }
    public var importers: AnyInjector<ExportedKey> {
        return configuration.importers
    }
    public var pipelines: AnyInjector<PipelineKey> {
        return configuration.pipelines
    }
    public var pipelineForPath: [ExportedPath: Pipeline] {
        return configuration.pipelineForPath
    }

    public init(configure: (inout Au3dioConfiguration) -> Void) {
        var conf = Au3dioConfiguration()
        configure(&conf)
        self.init(configuration: conf)
    }

    public func lensedSubject<P>(lens: Lens<RootNode?, P?>) throws -> LensSubject<RootNode?, P?> {
        return try LensSubject(subject: rootSubject, lens: lens)
    }

    public func pipeline(forPath path: ExportablePath) -> Pipeline {
        let segments = path.exported.segments
        return pipeline(forSegments: segments)
    }

    private func pipeline(forSegments segments: [ExportedKey]) -> Pipeline {
        if let pipeline = pipelineForPath[segments.reduce("/", combine: +)] {
            return pipeline
        } else if segments.count > 0 {
            var segs = segments
            _ = segs.popLast()
            return pipeline(forSegments: segs)
        } else {
            fatalError("No Pipeline provided for \"/\"")
        }
    }

    public func createPipedNode(forPath path: ExportablePath) -> PipedNode {
        let pipeline = self.pipeline(forPath: path)
        return pipeline.createPipedNode(path.exported)
    }
}
