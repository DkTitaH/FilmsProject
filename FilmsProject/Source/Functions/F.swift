//
//  F.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import Foundation

func toString(_ class: AnyClass) -> String {
    return String(describing: `class`)
}

public func cast<Value, Result>(_ value: Value) -> Result? {
    return value as? Result
}

public func when<Result>(_ condition: Bool, execute: () -> Result?) -> Result? {
    return condition ? execute() : nil
}
