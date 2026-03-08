//
//  SplashViewBinder.swift
//  Final Project
//
//  Created by SabinaKarimli on 07.03.26.
//


import UIKit

final class SplashViewBinder {

    @MainActor static func bind(
        vm: SplashViewModel,
        vc: SplashViewController,
        ui: SplashViewUI
    ) {

        vm.onProgress = { progress, text in

            ui.pctLabel.text = text

            ScreenAnimator.splashProgress(
                ui.progressFill,
                width: ui.progressBg.frame.width * CGFloat(min(progress,1)),
                layoutParent: vc.view
            )
        }

        vm.onFinished = {

            ScreenAnimator.splashFinish(
                statusLabel: ui.statusLabel,
                progressFill: ui.progressFill,
                pctLabel: ui.pctLabel,
                successColor: AppTheme.Color.success
            )

            let window = vc.resolveWindow()

            Task { @MainActor in

                try? await Task.sleep(nanoseconds: 900_000_000)

                guard let w = window else { return }

                AppRouter.setRoot(window: w)
            }
        }
    }
}
