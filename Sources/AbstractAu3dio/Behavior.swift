//
//  Behavior.swift
//  Au3dio
//
//  Created by Valentin Knabel on 03.09.16.
//
//

import RxSwift

public typealias RootBehavior = (Observable<RootNode>) -> Disposable
