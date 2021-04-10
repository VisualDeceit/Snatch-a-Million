//
//  Observable.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 08.04.2021.
//

import Foundation

public struct ObservableOptions: OptionSet, CustomStringConvertible {

    public static let initial = ObservableOptions(rawValue: 1 << 0)
    public static let old = ObservableOptions(rawValue: 1 << 1)
    public static let new = ObservableOptions(rawValue: 1 << 2)

    public var rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public var description: String {
        switch self {
        case .initial:
            return "initial"
        case .old:
            return "old"
        case .new:
            return "new"
        default:
            return "ObservableOptions(rawValue: \(rawValue))"
        }
    }
}

@propertyWrapper
public struct Observable<Type> {

    // MARK: - Properties
    
    public var wrappedValue: Type {
        didSet {
            self.projectedValue.removeNilObserverCallbacks()
            self.projectedValue.notifyCallbacks(value: oldValue, option: .old)
            self.projectedValue.notifyCallbacks(value: self.wrappedValue, option: .new)
        }
    }
    
    public let projectedValue: ObserverHandler

    // MARK: - Object Lifecycle
    public init(wrappedValue: Type) {
        self.wrappedValue = wrappedValue
        self.projectedValue = ObserverHandler(initialValue: wrappedValue)
    }
    
    public class ObserverHandler {
        
        private let initialValue: Type
        
        fileprivate init(initialValue: Type) {
            self.initialValue = initialValue
        }
        
        // MARK: - Managing Observers
        private var callbacks: [Callback] = []

        public func addObserver(_ observer: AnyObject,
                                removeIfExists: Bool = true,
                                options: [ObservableOptions] = [.new],
                                closure: @escaping (Type, ObservableOptions) -> Void) {
            if removeIfExists {
                removeObserver(observer)
            }

            let callback = Callback(observer: observer,
                                    options: options,
                                    closure: closure)
            callbacks.append(callback)

            if options.contains(.initial) {
                closure(self.initialValue, .initial)
            }
        }

        public func removeObserver(_ observer: AnyObject) {
            callbacks = callbacks.filter { $0.observer !== observer }
        }

        // MARK: - Private

        /// Удаляет все обзерверы которые деалоцировались
        fileprivate func removeNilObserverCallbacks() {
            callbacks = callbacks.filter { $0.observer != nil }
        }
        
        /// Оповещает слушателей об измененияз
        fileprivate func notifyCallbacks(value: Type,
                                     option: ObservableOptions) {
            let callbacksToNotify = callbacks.filter {
                $0.options.contains(option)
            }
            callbacksToNotify.forEach { $0.closure(value, option) }
        }
    }
    
    fileprivate class Callback {
        fileprivate weak var observer: AnyObject?
        fileprivate let options: [ObservableOptions]
        fileprivate let closure: (Type, ObservableOptions) -> Void

        fileprivate init(observer: AnyObject,
                         options: [ObservableOptions],
                         closure: @escaping (Type, ObservableOptions) -> Void) {
            self.observer = observer
            self.options = options
            self.closure = closure
        }
    }
}
