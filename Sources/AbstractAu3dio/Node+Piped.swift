//
//  Node+Piped.swift
//  Au3dio
//
//  Created by Valentin Knabel on 06.09.16.
//
//

/// Declares a PipedNode that will be provided by the DataManager.
public protocol PipedNode {
    var ownKey: ParsedKey { get }
    var properties: [ParsedKey] { get }

    func value<V>(for for: ParsedKey) -> V
}

