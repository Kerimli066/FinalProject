//
//  DockerImage.swift
//  Final Project
//
//  Created by SabinaKarimli on 10.02.26.
//


import Foundation

struct DockerImage: Codable, Identifiable, Hashable {
    var id: String { Id }

    let Containers: Int?
    let Created: Int64?
    let Id: String
    let Labels: [String: String]?
    let ParentId: String?
    let RepoDigests: [String]?
    let RepoTags: [String]?
    let SharedSize: Int64?
    let Size: Int64?
    let VirtualSize: Int64?
}

extension DockerImage {
    var displayName: String {
        RepoTags?.first?.split(separator: ":").first.map(String.init) ?? "<none>"
    }
    var displayTag: String {
        RepoTags?.first?.split(separator: ":").dropFirst().first.map(String.init) ?? "latest"
    }
    var sizeMB: String {
        guard let s = Size else { return "—" }
        return s > 1_000_000_000
            ? String(format: "%.1f GB", Double(s) / 1_000_000_000)
            : String(format: "%.0f MB", Double(s) / 1_000_000)
    }
    var createdRelative: String {
        guard let c = Created else { return "—" }
        let f = RelativeDateTimeFormatter(); f.unitsStyle = .short
        return f.localizedString(for: Date(timeIntervalSince1970: TimeInterval(c)), relativeTo: Date())
    }
    var inUse: Bool { (Containers ?? 0) > 0 }
}
