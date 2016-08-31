//
//  RootNodeKey.swift
//  Au3dio
//
//  Created by Valentin Knabel on 31.08.16.
//
//

/// A key used to inject properties of `RootNode`s.
///
/// Declaration:
/// ~~~
/// extension Provider where Key == RootKey {
///     static var example: Provider<RootKey, MyRootProperty> {
///         return .derive()
///     }
/// }
/// ~~~
public struct RootKey: DefaultExportableKey {
    public static let prefix = "RootKey"
    public let key: String

    public init(key: String) {
        self.key = key
    }
}
