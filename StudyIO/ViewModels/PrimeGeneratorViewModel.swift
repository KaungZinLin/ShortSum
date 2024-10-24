//
//  GeneratorViewModel.swift
//  Primeo
//
//  Created by Kaung Zin Lin on 08/03/2024.
//

import Foundation

class PrimeGeneratorViewModel   : ObservableObject {
    var startRange = ""
    var endRange = ""
    
    func calculatePrimes(start: Int, end: Int) -> String {
        var primesString = ""

        if end > 1000000 || start <= 0 {
            return primesString
        } else {
            for num in start...end {
                if num > 1 {
                    var isPrime = true
                    for i in 2..<num {
                        if num % i == 0 {
                            isPrime = false
                            break
                        }
                    }
                    if isPrime {
                        primesString += "\(num), "
                    }
                }
            }
            // Remove the trailing comma and space
            if primesString.hasSuffix(", ") {
                primesString.removeLast(2)
            }
            return primesString
        }
    }
    
    func calculateNonPrimes(start: Int, end: Int) -> String {
        var nonPrimesString = ""

        for num in start..<end {
            for i in 2..<num {
                if num % i == 0 {
                    nonPrimesString += "\(num), "
                    break
                }
            }
        }

        // Remove the trailing comma and space
        if nonPrimesString.hasSuffix(", ") {
            nonPrimesString.removeLast(2)
        }

        return nonPrimesString
    }
}
