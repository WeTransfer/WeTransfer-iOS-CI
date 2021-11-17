//
//  PRLinterViewModel.swift
//  PRLinterApp
//
//  Created by Antoine van der Lee on 22/10/2021.
//

import Foundation

struct PRLinterViewModel {
    let name = "Antoine"
    let age = 30

    func printDescription() -> String {
        guard age > 20 else {
            return "To young"
        }

        return name + " and age: \(30)"
    }
}
