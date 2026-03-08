//
//  LogsContainerLogic.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import Foundation

@MainActor
final class LogsContainerLogic {

    func updateContainers(
        _ list: [ContainerInfo],
        preselect: ContainerInfo?,
        currentContainers: [ContainerInfo],
        currentSelected: ContainerInfo?,
        applyContainers: ([ContainerInfo]) -> Void,
        select: (ContainerInfo) -> Void,
        clearSelection: () -> Void
    ) {
        let merged = list.isEmpty ? currentContainers : list
        applyContainers(merged)

        if let pre = preselect {
            if let found = merged.first(where: { $0.id == pre.id }) {
                select(found)
            } else {
                clearSelection()
            }
            return
        }

        if let currentSelected {
            if let found = merged.first(where: { $0.id == currentSelected.id }) {
                select(found)
            } else {
                clearSelection()
            }
        }
    }
}
