//
//  Lens.swift
//  Au3dio
//
//  Created by Valentin Knabel on 08.08.16.
//
//

/// Enables read and copy-on-write acces for an entity's property in a datastructure.
///
/// Some examples can be found in this [blog post](http://chris.eidhof.nl/post/lenses-in-swift/).
public struct Lens<A, B> {
    public let from: (A) -> B
    public let to: (B, A) -> A

    public init(from: (A) -> B, to: (B, A) -> A) {
        self.from = from
        self.to = to
    }
}


import RxSwift

/// Applies a given Lens to a subject.
public final class LensSubject<A, B>: SubjectType {
    public typealias E = B

    private var value: A
    private let lens: Lens<A, B>
    private let source: Observable<A>
    private let target: AnyObserver<A>
    /// Used in order to avoid multiple conversions and updated when having many subscribers.
    /// Uses unowned in order to break reference cycles.
    /// This code shall never be executed when not subscribed.
    private lazy var output: Observable<B> = self.source
        .doOnNext({ [unowned self] in self.value = $0 })
        .map({ [unowned self] in self.lens.from($0) })

    public init<S: ObservableType, O: ObserverType where S.E == A, O.E == A>(initial: A, source: S, target: O, lens: Lens<A, B>) {
        self.value = initial
        self.lens = lens
        self.target = AnyObserver(target.asObserver())
        self.source = source.asObservable()
    }

    public func asObserver() -> AnyObserver<B> {
        return AnyObserver { event in
            switch event {
            case .Next(let b):
                self.target.onNext(self.lens.to(b, self.value))
            case .Error(let error):
                self.target.onError(error)
            case .Completed:
                self.target.onCompleted()
            }
        }
    }

    @warn_unused_result(message="http://git.io/rxs.ud")
    public func subscribe<O: ObserverType where O.E == B>(observer: O) -> Disposable {
        return asObservable().subscribe(observer)
    }

    public func asObservable() -> Observable<B> {
        return output
    }
}

public extension LensSubject {
    public convenience init<S: SubjectType where S.SubjectObserverType.E == A, S.E == A>(initial: A, subject: S, lens: Lens<A, B>) {
        self.init(initial: initial, source: subject.asObservable(), target: AnyObserver(subject.asObserver()), lens: lens)
    }

    public convenience init(subject: BehaviorSubject<A>, lens: Lens<A, B>) throws {
        try self.init(initial: subject.value(), source: subject.asObservable(), target: AnyObserver(subject.asObserver()), lens: lens)
    }
}
