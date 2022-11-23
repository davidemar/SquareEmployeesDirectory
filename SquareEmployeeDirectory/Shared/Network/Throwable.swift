//
//  Throwable.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/23/22.
//
public struct Throwable<T: Decodable>: Decodable {
    
    public let result: Result<T, Error>

    public init(from decoder: Decoder) throws {
        let catching = { try T(from: decoder) }
        result = Result(catching: catching )
    }
}
