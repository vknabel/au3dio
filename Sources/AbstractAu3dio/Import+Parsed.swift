//
//  Import+Parsed.swift
//  Au3dio
//
//  Created by Valentin Knabel on 03.09.16.
//
//

import Foundation

public extension ParsedKey {
    public static var separator: String {
        return ":"
    }

    public init?(unparsed: UnparsedKey) {
        guard let parsed = try? unparsed.parsed() else { return nil }
        self = parsed
    }

    public func unparsed() throws -> UnparsedKey {
        let key = parsedType + ParsedKey.separator + property
        if let parameter = parameter {
            return key + ParsedKey.separator + parameter
        }
        return key
    }

    public func typed<I: TypedKey>() throws -> I? {
        return try unparsed().typed()
    }
}
