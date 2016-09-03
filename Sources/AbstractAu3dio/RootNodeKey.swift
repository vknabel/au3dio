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
public struct RootNodeKey: DefaultTypedKey {
    public static let parsedType = "RootNodeKey"
    public let property: ParsedProperty
    public let parameter: ParsedParameter?

    public init(property: ParsedProperty, parameter: ParsedParameter?) {
        self.property = property
        self.parameter = parameter
    }
}
