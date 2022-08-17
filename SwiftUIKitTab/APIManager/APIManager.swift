//
//  APIManager.swift
//  SwiftUIKitTab
//
//  Created by Justus Aype Jose on 16/08/22.
//

import Foundation
import Combine

class APIManager {
    
    static let shared: APIManager = APIManager()
    
    private init() {}
    
    func fetchData(completion: @escaping ([String]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(["Two", "Three", "Four"])
        }
    }
    
    func fetchDataCombine() -> Future<[String], Error> {
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                promise(.success(["Fifty", "Sixty", "Seventy", "Eighty"]))
                
            }
        }
    }
    
    func fetchDataAsyncAwait() async throws -> [String] {
        
        try await Task.sleep(nanoseconds: 3_000_000_000)

        //sleep(3)
        //DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            return ["Apple", "Oranges", "Mangoes"]
        //}
    }
    
}
