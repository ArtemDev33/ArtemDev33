//
//  AlertItem.swift
//  TestApp
//
//  Created by Артем Гавриленко on 16.06.2022.
//

import SwiftUI

extension AlertInfo {
    enum AlertUseCase {
        case paid, unavailable
    }
}

struct AlertInfo {
    var title: String
    var message: String
    var useCase: AlertUseCase
}
