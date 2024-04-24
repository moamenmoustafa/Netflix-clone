//
//  Extentions.swift
//  Netflix Clone
//
//  Created by Moamen on 07/04/2024.
//

import Foundation

extension String {
    func capitalizeLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
