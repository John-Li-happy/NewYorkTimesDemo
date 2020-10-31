//
//  ReuseableCellProtocol.swift
//  NewYorkTimesDemo
//
//  Created by Zhaoyang Li on 10/31/20.
//

import Foundation

protocol ReusableCellProtocol {
    static var reuseIdentifier: String { get }
}

extension ReusableCellProtocol {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
