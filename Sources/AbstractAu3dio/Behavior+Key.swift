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
public struct BehaviorKey: DefaultImportedKey {
    public static let importerKey = "BehaviorKey"
    public let property: ImportableProperty
    public let parameter: ImportableParameter?

    public init(property: ImportableProperty, parameter: ImportableParameter?) {
        self.property = property
        self.parameter = parameter
    }
}
