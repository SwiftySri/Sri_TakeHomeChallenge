//
//  ButtonStyles.swift
//  TechChallenge
//
//  Created by Srinidhi on 12/1/21.
//

import SwiftUI

/// Button style for applying to Button view which needs to be styled as Filter tokens
struct FilterButtonStyle: ButtonStyle {
    let color: Color
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .font(.bold(.title2)())
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background(color, in: Capsule())
            .opacity(configuration.isPressed ? 0.5 : 1.0)
    }
}
