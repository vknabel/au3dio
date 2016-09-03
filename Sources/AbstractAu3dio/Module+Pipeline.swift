//
//  Module+Pipeline.swift
//  Au3dio
//
//  Created by Valentin Knabel on 03.09.16.
//
//

import DependencyAdditions

public extension Au3dioModuleType {
    public func lensedSubject<P>(lens: Lens<RootNode?, P?>) throws -> LensSubject<RootNode?, P?> {
        return try LensSubject(subject: rootSubject, lens: lens)
    }

    public func pipeline(forPath path: TypedKeyPath) throws -> Pipeline {
        return try pipeline(forParsed: try path.map({ imported in
            try imported.parsed()
        }))
    }

    private func pipeline(forParsed path: ParsedKeyPath) throws -> Pipeline {
        if let pipeline = try pipelineForPath[try path.reduce("/", combine: { (exportedPath: UnparsedKeyPath, parsed: ParsedKey) in
            return try exportedPath + parsed.unparsed()
        })] {
            return pipeline
        } else if path.count > 0 {
            var segs = path
            _ = segs.popLast()
            return try pipeline(forParsed: segs)
        } else {
            fatalError("No Pipeline provided for \"/\"")
        }
    }

    public func createPipedNode(for path: ParsedKeyPathConvertable) throws -> PipedNode {
        return try createPipedNode(forParsed: try path.parsedPath())
    }

    public func createPipedNode(forParsed path: ParsedKeyPath) throws -> PipedNode {
        let pipeline = try self.pipeline(forParsed: path)
        return try pipeline.createPipedNode(for: path)
    }
}
