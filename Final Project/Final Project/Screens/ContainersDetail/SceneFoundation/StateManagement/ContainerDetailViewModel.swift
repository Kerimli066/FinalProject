//
//  ContainerDetailViewModel.swift
//  Final Project
//
//  Created by SabinaKarimli on 28.02.26.
//

import FirebaseAuth

@MainActor
final class ContainerDetailViewModel: ObservableObject {

    @Published private(set) var container: ContainerInfo

    @Published var isActionLoading: Bool = false
    @Published var isLoadingDetail: Bool = false
    @Published var showActionError: Bool = false
    @Published var actionErrorMessage: String? = nil
    @Published var showRemoveConfirm: Bool = false

    @Published var envExpanded: Bool = false
    @Published var portsExpanded: Bool = false
    @Published var mountsExpanded: Bool = false

    @Published private(set) var envVars: [(key: String, value: String)] = []
    @Published private(set) var ports: [String] = []
    @Published private(set) var mounts: [String] = []

    var onRemoved: (() -> Void)?
    var onViewLogs: ((ContainerInfo) -> Void)?
    var onActionCompleted: (() -> Void)?

    private let service: LumenService
    private var detailTask: Task<Void, Never>?
    private var detailLoaded = false

    init(
        container: ContainerInfo,
        service: LumenService = AppEnvironment.makeLumenService()
    ) {
        self.container = container
        self.service = service
        loadLocalDetail()
    }

    func onAppear() {
        detailTask?.cancel()
        detailTask = Task { await loadDetail(force: false) }
    }

    func onDisappear() {
        detailTask?.cancel()
        detailTask = nil
    }

    private func loadDetail(force: Bool) async {
        if !force {
            guard !detailLoaded else { return }
        }

        isLoadingDetail = true
        defer { isLoadingDetail = false }

        do {
            let detail = try await service.getContainerDetail(id: container.id)
            container = detail
            loadLocalDetail()
            detailLoaded = true
        } catch {
        }
    }

    private func loadLocalDetail() {
        envVars = (container.env ?? [:])
            .sorted { $0.key < $1.key }
            .map { (key: $0.key, value: $0.value) }

        ports = container.ports ?? []
        mounts = container.mounts ?? []
    }

    private func perform(
        actionName: String,
        isRemove: Bool = false,
        optimisticUpdate: (() -> Void)? = nil,
        _ action: @escaping () async throws -> Void
    ) async {
        isActionLoading = true
        actionErrorMessage = nil
        showActionError = false

        do {
            try await action()
            optimisticUpdate?()

            if isRemove {
                onActionCompleted?()
                onRemoved?()
            } else {
                if let updated = try? await service.getContainerDetail(id: container.id) {
                    container = updated
                }
                detailLoaded = true  
                loadLocalDetail()
                onActionCompleted?()
            }

        } catch {
            actionErrorMessage = "\(actionName) failed: \(error.localizedDescription)"
            showActionError = true
        }

        isActionLoading = false
    }

    func startContainer() async {
        await perform(
            actionName: "Start",
            optimisticUpdate: { [weak self] in
                guard let self else { return }
                self.container = ContainerInfo(
                    id: self.container.id,
                    name: self.container.name,
                    status: "Up a few seconds",
                    image: self.container.image,
                    state: "running",
                    created: self.container.created,
                    env: self.container.env,
                    ports: self.container.ports,
                    mounts: self.container.mounts
                )
            }
        ) {
            try await self.service.startContainer(id: self.container.id)
        }
    }

    func stopContainer() async {
        await perform(
            actionName: "Stop",
            optimisticUpdate: { [weak self] in
                guard let self else { return }
                self.container = ContainerInfo(
                    id: self.container.id,
                    name: self.container.name,
                    status: "Exited recently",
                    image: self.container.image,
                    state: "exited",
                    created: self.container.created,
                    env: self.container.env,
                    ports: self.container.ports,
                    mounts: self.container.mounts
                )
            }
        ) {
            try await self.service.stopContainer(id: self.container.id)
        }
    }

    func restartContainer() async {
        await perform(
            actionName: "Restart",
            optimisticUpdate: { [weak self] in
                guard let self else { return }
                self.container = ContainerInfo(
                    id: self.container.id,
                    name: self.container.name,
                    status: "Restarting...",
                    image: self.container.image,
                    state: "running",
                    created: self.container.created,
                    env: self.container.env,
                    ports: self.container.ports,
                    mounts: self.container.mounts
                )
            }
        ) {
            try await self.service.restartContainer(id: self.container.id)
        }
    }

    func removeContainer() async {
        await perform(actionName: "Remove", isRemove: true) {
            try await self.service.removeContainer(id: self.container.id)
        }
    }

    var userEmail: String? { Auth.auth().currentUser?.email }
}
