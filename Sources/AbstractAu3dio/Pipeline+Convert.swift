//
//  Pipeline+Convert.swift
//  Au3dio
//
//  Created by Valentin Knabel on 03.09.16.
//
//

public extension Pipeline {
    public func createPipedNode(for path: UnparsedKeyPathConvertable) throws -> PipedNode {
        return try createPipedNode(forPath: try path.unparsedPath())
    }
}
