//
//  GenericsExercise.swift
//  iOSCodingExercise
//
//  Created by Sunny Chan on 10/8/21.
//

import Foundation

struct Stack<T> {
    var items: [T] = []
    
    mutating func push(item: T) {
        items.append(item)
    }
    
    mutating func pop() -> T? {
        guard !items.isEmpty else {
            return nil
        }
        
        return items.removeLast()
    }
}

class GenericsExercise {
    func swapTwoValues<T>(a: inout T, b: inout T) {
        let temp: T = a
        a = b
        b = temp
    }
}

enum CustomOptionalError: Error {
    case nilValueCanNotBeUnwrapped
}

enum CustomOptional<T> {
    case nonNilValue(T)
    case nilValue
    
    func unwrappedValue() throws -> T {
        switch self {
        case .nonNilValue(let value):
            return value
        case .nilValue:
            throw CustomOptionalError.nilValueCanNotBeUnwrapped
        }
    }
    
    static func nilCoalescing(lhs: CustomOptional<T>, rhs: T) -> T {
        switch lhs {
        case .nonNilValue(let value):
            return value
        case .nilValue:
            return rhs
        }
    }
}

let testStrNil: CustomOptional<String> = CustomOptional.nilValue
let testStrSome: CustomOptional<String> = CustomOptional.nonNilValue("some")


