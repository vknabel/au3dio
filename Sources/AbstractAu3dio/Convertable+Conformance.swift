//
//  Convertable+Conformance.swift
//  Au3dio
//
//  Created by Valentin Knabel on 03.09.16.
//
//

import Foundation

extension UnparsedKey: TypedKeyConvertable, ParsedKeyConvertable {

    public func parsed() throws -> ParsedKey {
        let comps = (self as NSString).componentsSeparatedByString(ParsedKey.separator)
        guard let parsedType = comps.first, let property = comps.dropFirst().first else {
            throw Au3dioError.invalidUnparsed(self)
        }
        return ParsedKey(parsedType: parsedType, property: property, parameter: comps.dropFirst(2).first)
    }

    public func typed<I : TypedKey>() throws -> I? {
        guard let parsed = try? parsed() else { return nil }
        return I(parsed: parsed)
    }
}

extension ParsedKeyPathConvertable {

}
