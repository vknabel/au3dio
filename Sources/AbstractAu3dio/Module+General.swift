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
