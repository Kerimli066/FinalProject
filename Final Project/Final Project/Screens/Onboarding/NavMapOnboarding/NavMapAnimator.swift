//
//  NavMapAnimator.swift
//  Final Project
//
//  Created by SabinaKarimli on 07.03.26.
//


import UIKit

final class NavMapAnimator {

    func runEntranceAnimation(cards: [UIView], startButton: UIView) {
        for (i, card) in cards.enumerated() {
            UIView.animate(
                withDuration: 0.55,
                delay: Double(i) * 0.07 + 0.05,
                usingSpringWithDamping: 0.76,
                initialSpringVelocity: 0.4,
                options: .allowUserInteraction
            ) {
                card.alpha = 1
                card.transform = .identity
            }
        }

        UIView.animate(
            withDuration: 0.58,
            delay: Double(cards.count) * 0.07 + 0.08,
            usingSpringWithDamping: 0.78,
            initialSpringVelocity: 0.3,
            options: .allowUserInteraction
        ) {
            startButton.alpha = 1
            startButton.transform = .identity
        }
    }
}