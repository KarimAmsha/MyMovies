//
//  ActivityIndicator.swift
//  MyMovies
//
//  Created by Karim Amsha on 17.06.2023.
//

import Foundation
import RxSwift

class ActivityIndicator {
    private let lock = NSRecursiveLock()
    private var _counter: Int = 0
    private(set) var isLoading: Bool = false
    
    private(set) lazy var loading: Observable<Bool> = {
        return self.loadingSubject.asObservable()
    }()
    
    private let loadingSubject = BehaviorSubject<Bool>(value: false)
    
    func trackActivity<T>(_ source: Observable<T>) -> Observable<T> {
        return Observable.using({ () -> AnyDisposable in
            self.increment()
            return AnyDisposable { [weak self] in
                self?.decrement()
            }
        }, observableFactory: { _ in
            return source
        })
    }

    private func increment() {
        lock.lock()
        _counter += 1
        updateLoadingStatusIfNeeded()
        lock.unlock()
    }
    
    private func decrement() {
        lock.lock()
        _counter -= 1
        updateLoadingStatusIfNeeded()
        lock.unlock()
    }
    
    private func updateLoadingStatusIfNeeded() {
        let isLoading = _counter > 0
        if self.isLoading != isLoading {
            self.isLoading = isLoading
            loadingSubject.onNext(isLoading)
        }
    }
}

private class AnyDisposable: Disposable {
    private let disposeAction: () -> Void
    
    init(_ disposeAction: @escaping () -> Void) {
        self.disposeAction = disposeAction
    }
    
    func dispose() {
        disposeAction()
    }
}
