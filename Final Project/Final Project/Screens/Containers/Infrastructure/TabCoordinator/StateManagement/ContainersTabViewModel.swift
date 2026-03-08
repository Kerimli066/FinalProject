//
//  ContainersTabViewModel.swift
//  Final Project
//
//  Created by SabinaKarimli on 28.02.26.
//

import SwiftUI

@MainActor
final class ContainersTabViewModel: ObservableObject {

    enum Segment: String, CaseIterable {
        case containers = "Containers"
        case images     = "Images"
        case volumes    = "Volumes"
        case networks   = "Networks"

        var title: String { rawValue }

        var sfIcon: String {
            switch self {
            case .containers: return "shippingbox.fill"
            case .images:     return "square.stack.3d.up.fill"
            case .volumes:    return "externaldrive.fill"
            case .networks:   return "network"
            }
        }
    }

    @Published var selectedSegment: Segment = .containers

    @Published private(set) var images:   [DockerImage]   = []
    @Published private(set) var volumes:  [DockerVolume]  = []
    @Published private(set) var networks: [DockerNetwork] = []

    @Published private(set) var isLoadingImages   = false
    @Published private(set) var isLoadingVolumes  = false
    @Published private(set) var isLoadingNetworks = false

    @Published private(set) var imagesError:   String? = nil
    @Published private(set) var volumesError:  String? = nil
    @Published private(set) var networksError: String? = nil

    private var loadedImages   = false
    private var loadedVolumes  = false
    private var loadedNetworks = false

    private let service: LumenService

    init(service: LumenService = AppEnvironment.makeLumenService()) {
        self.service = service
    }

    func onAppear() {
        loadIfNeeded(selectedSegment)
    }

    func loadIfNeeded(_ segment: Segment) {
        switch segment {
        case .containers: break
        case .images:     if !loadedImages   { Task { await loadImages()   } }
        case .volumes:    if !loadedVolumes  { Task { await loadVolumes()  } }
        case .networks:   if !loadedNetworks { Task { await loadNetworks() } }
        }
    }

    func refresh() async {
        switch selectedSegment {
        case .containers: break
        case .images:
            loadedImages = false
            await loadImages()
        case .volumes:
            loadedVolumes = false
            await loadVolumes()
        case .networks:
            loadedNetworks = false
            await loadNetworks()
        }
    }

    func retryIfFailed(_ segment: Segment) {
        switch segment {
        case .images   where imagesError   != nil: loadedImages   = false; Task { await loadImages()   }
        case .volumes  where volumesError  != nil: loadedVolumes  = false; Task { await loadVolumes()  }
        case .networks where networksError != nil: loadedNetworks = false; Task { await loadNetworks() }
        default: break
        }
    }

    // MARK: - Private loaders

    private func loadImages() async {
        isLoadingImages = true
        imagesError     = nil
        do {
            images       = try await service.listImages()
            loadedImages = true
        } catch {
            imagesError = error.localizedDescription
        }
        isLoadingImages = false
    }

    private func loadVolumes() async {
        isLoadingVolumes = true
        volumesError     = nil
        do {
            volumes       = try await service.listVolumes()
            loadedVolumes = true
        } catch {
            volumesError = error.localizedDescription
        }
        isLoadingVolumes = false
    }

    private func loadNetworks() async {
        isLoadingNetworks = true
        networksError     = nil
        do {
            networks       = try await service.listNetworks()
            loadedNetworks = true
        } catch {
            networksError = error.localizedDescription
        }
        isLoadingNetworks = false
    }
}
