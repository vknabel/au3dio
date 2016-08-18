//
//  TruthyValidator.swift
//  Au3dio
//
//  Created by Valentin Knabel on 08.08.16.
//
//

import ValidatedExtension

/// A generic Validator that always passes.
public struct TruthyValidator<W>: Validator {
    public static func validate(value: W) throws -> Bool {
        return true
    }
}
