//
//  Model.swift
//  SimpleDiary_C
//
//  Created by 홍경표 on 2021/02/27.
//

import Foundation

struct Model {
    var year: Int
    var month: Int
    var day: Int
    var checkList: Set<String> = {
        return Set((1...Int.random(in: 2...6)).map { _ in
            let str = String([Character](repeating: "ABCEDF".randomElement()!, count: 10))
            return str
        })
    }()
}
