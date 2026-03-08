//
//  SettingsView.swift
//  Final Project
//
//  Created by SabinaKarimli on 28.02.26.
//

import SwiftUI
import UIKit

struct SettingsView: View {
    @StateObject private var vm = SettingsViewModel()

    @State private var showServerSetup = false
    @State private var appeared = false

    @Environment(\.settingsHostVC) private var hostVC

    var body: some View {
        ZStack {
            SettingsBackgroundView()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    SettingsHeroHeaderView(
                        appeared: appeared,
                        connectionColor: vm.connectionStatusColor,
                        connectionText: vm.connectionStatusText,
                        notificationsEnabled: vm.notificationsEnabled
                    )

                    Spacer().frame(height: 20)

                    NotificationsCardView(
                        isLoading: vm.isLoading,
                        notificationsEnabled: $vm.notificationsEnabled
                    )

                    AlertEmailCardView(
                        recipientEmail: vm.recipientEmail
                    )

                    AlertFlowCardView(appeared: appeared)

                    ServerCardView(
                        appeared: appeared,
                        showServerSetup: $showServerSetup,
                        connectionColor: vm.connectionStatusColor,
                        connectionText: vm.connectionStatusText
                    )

                    SignOutCardView(
                        onTap: { vm.showSignOutConfirm = true }
                    )

                    AppInfoCardView()

                    FooterBrandView()
                        .padding(.bottom, 60)
                }
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .onAppear {
            vm.onAppear()
            withAnimation(.spring(response: 0.9, dampingFraction: 0.75)) { appeared = true }
        }
        .alert("Saved", isPresented: $vm.showSavedToast) {
            Button("OK") { vm.showSavedToast = false }
        } message: { Text("Settings saved successfully.") }

        .alert("Error", isPresented: $vm.showError) {
            Button("OK") { vm.showError = false; vm.errorMessage = nil }
        } message: { Text(vm.errorMessage ?? "Unknown error") }

        .alert("Sign Out", isPresented: $vm.showSignOutConfirm) {
            Button("Sign Out", role: .destructive) {
                guard let vc = hostVC else { return }
                vm.signOut(from: vc)
            }
            Button("Cancel", role: .cancel) {}
        } message: { Text("Are you sure you want to sign out?") }

        .fullScreenCover(isPresented: $showServerSetup) {
            ServerSetupSheetView(isPresented: $showServerSetup)
                .ignoresSafeArea()
        }
    }
}

extension EnvironmentValues {
    var settingsHostVC: UIViewController? {
        get { self[SettingsHostVCKey.self] }
        set { self[SettingsHostVCKey.self] = newValue }
    }
}
