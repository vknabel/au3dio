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
public struct BehaviorKey: DefaultExportableKey {
    public static let prefix = "BehaviorKey"
    public let key: String

    public init(key: String) {
        self.key = key
    }
}
