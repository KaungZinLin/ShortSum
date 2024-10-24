//
//  CPFFViewModel.swift
//  Primeo
//
//  Created by Kaung Zin Lin on 02.03.2024.
//

import Foundation

class CPFFViewModel: ObservableObject {
    
    func isPrime(_ n: Int) -> Bool {
        if n < 2 {
            return false
        } else {
            for i in 2..<Int(sqrt(Double(n))) + 1 {
                if n % i == 0 {
                    return false
                }
            }
            
            return true
        }
    }
    
    func calculateFactors(of n: Int) -> [String] {
        var factors: [String] = []
        for i in 1...n {
            if n % i == 0 {
                factors.append(String(i))
            }
        }
        return factors
    }
}
