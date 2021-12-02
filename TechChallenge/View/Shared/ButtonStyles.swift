//
//  ButtonStyles.swift
//  TechChallenge
//
//  Created by Srinidhi on 12/1/21.
//

import SwiftUI

struct FilterButtonStyle: ButtonStyle {
    typealias Body = AnyView
    
    let color: Color
    func makeBody(configuration: Self.Configuration) -> Self.Body {
        AnyView(configuration.label
                    .foregroundColor(.white)
                    .font(.bold(.title2)())
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background(color)
            .clipShape(Capsule()))
    }
}
