//
//  Pipeline+Node.swift
//  Au3dio
//
//  Created by Valentin Knabel on 03.09.16.
//
//

/// A key used to injector data managers.
///
/// Declaration:
/// ~~~
/// extension Provider where Key == PipelineKey {
///     static var example: Provider<PipelineKey, Pipeline> {
///         return .derive()
///     }
/// }
/// ~~~
public struct PipelineKey: DefaultTypedKey {
    public static let parsedType = "PipelineKey"
    public let property: ParsedProperty
    public let parameter: ParsedParameter?

    public init(property: ParsedProperty, parameter: ParsedParameter?) {
        self.property = property
        self.parameter = parameter
    }
}
