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
public struct RootNodeKey: DefaultImportedKey {
    public static let importerKey = "RootNodeKey"
    public let property: ImportableProperty
    public let parameter: ImportableParameter?

    public init(property: ImportableProperty, parameter: ImportableParameter?) {
        self.property = property
        self.parameter = parameter
    }
}
