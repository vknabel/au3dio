//
//  BehaviorKey.swift
//  Au3dio
//
//  Created by Valentin Knabel on 08.08.16.
//
//

/// A key used to injector behaviors.
///
/// Declaration:
/// ~~~
/// extension Provider where Key == BehaviorKey {
///     static var example: Provider<BehaviorKey, RootBehaviorSubscriber> {
///         return .derive()
///     }
/// }
/// ~~~
public struct BehaviorKey: DefaultTypedKey {
    public static let parsedType = "BehaviorKey"
    public let property: ParsedProperty
    public let parameter: ParsedParameter?

    public init(property: ParsedProperty, parameter: ParsedParameter?) {
        self.property = property
        self.parameter = parameter
    }
}
