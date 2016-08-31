//
//  Au3dioModule.swift
//  Au3dio
//
//  Created by Valentin Knabel on 08.08.16.
//
//

import RxSwift
import EasyInject
import AbstractAu3dio

public final class Au3dioModule: Au3dioModuleType {
    public init(configuration: Au3dioConfiguration) {
        self.configuration = configuration
    }

    public var rootSubject: BehaviorSubject<RootNode?> = BehaviorSubject(value: nil)
    public var configuration: Au3dioConfiguration
}
