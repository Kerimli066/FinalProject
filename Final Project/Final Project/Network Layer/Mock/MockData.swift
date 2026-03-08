//
//  MockData.swift
//  Final Project
//
//  Created by SabinaKarimli on 13.02.26.
//

import Foundation

enum MockData {

    // MARK: - Containers
    static let containers: [ContainerInfo] = [
        .init(
            id: "a039244dfa47c1fae56d0c7242f955031e13a084f97ef37915e7e056f240d760",
            name: "lumen-app",
            status: "Up 5 minutes",
            image: "lumen-mobile-app:local",
            state: "running",
            created: 1769967296,
            env: nil, ports: nil, mounts: nil
        ),
        .init(
            id: "b0c39a97099bd7565f57865b19ab3d5aed154a10d473292d98758178234c237a",
            name: "lumen-minio",
            status: "Up 19 minutes (healthy)",
            image: "minio/minio:latest",
            state: "running",
            created: 1769966463,
            env: nil, ports: nil, mounts: nil
        ),
        .init(
            id: "6f17dc43969e870f612f8c37cf5150162440a4c6eb998b773b4142ad8f7ad48e",
            name: "log-mongodb",
            status: "Up 19 minutes",
            image: "mongo:7",
            state: "running",
            created: 1769966463,
            env: nil, ports: nil, mounts: nil
        ),
        .init(
            id: "8365e424b7bf114c7b96f6f638846a139a013086b5728ab576504e0f8e909879",
            name: "log-memory-heavy",
            status: "Up 19 minutes",
            image: "alpine:latest",
            state: "running",
            created: 1769966463,
            env: nil, ports: nil, mounts: nil
        ),
        .init(
            id: "9ff181d10df96831e3ec4dccb83fdbafeb1c8f817c710c7c8f26463cc4c53ef4",
            name: "log-nginx-web",
            status: "Up 19 minutes",
            image: "nginx:alpine",
            state: "running",
            created: 1769966463,
            env: nil, ports: nil, mounts: nil
        ),
        .init(
            id: "9ed81fa9e4df29daf582ce0975ffdda077addd2d17bd5fa6e91c9cd748082d89",
            name: "log-worker-jobs",
            status: "Up 19 minutes",
            image: "python:3.11-alpine",
            state: "running",
            created: 1769966463,
            env: nil, ports: nil, mounts: nil
        ),
        .init(
            id: "ff599a3607f52e296a337443a64f80ff433ff77d5eed2183645a6945a13de15b",
            name: "log-redis-cache",
            status: "Up 19 minutes",
            image: "redis:7-alpine",
            state: "running",
            created: 1769966463,
            env: nil, ports: nil, mounts: nil
        ),
        .init(
            id: "ed1d3a36a3a3b854d6b2536196565dd9a670b9a007353685940b1c236c26b48c",
            name: "lumen-postgres",
            status: "Up 19 minutes (healthy)",
            image: "postgres:16-alpine",
            state: "running",
            created: 1769966463,
            env: nil, ports: nil, mounts: nil
        ),
        .init(
            id: "e517a71599f8befac1924000180debd05e9c5bacd3a3a2d4c86d53ba28c86d50",
            name: "log-cpu-heavy",
            status: "Up 19 minutes",
            image: "alpine:latest",
            state: "running",
            created: 1769966463,
            env: nil, ports: nil, mounts: nil
        ),
        .init(
            id: "383f11fc26639108e39ea8da6831c929891aa775da40dcf97e5ef64480a59b3b",
            name: "log-api-gateway",
            status: "Up 19 minutes",
            image: "alpine:latest",
            state: "running",
            created: 1769966463,
            env: nil, ports: nil, mounts: nil
        ),
        .init(
            id: "09ce3084ff21c39897c58d7806a22bc0e848b100c1942322711c79abf7582c41",
            name: "log-queue-processor",
            status: "Up 19 minutes",
            image: "alpine:latest",
            state: "running",
            created: 1769966463,
            env: nil, ports: nil, mounts: nil
        ),
        .init(
            id: "24437a905d2a2f28ba0f5aa2f6dde9a4a9d9a1ec72f63521b131732a1c72fe4b",
            name: "log-auth-service",
            status: "Up 19 minutes",
            image: "alpine:latest",
            state: "running",
            created: 1769966463,
            env: nil, ports: nil, mounts: nil
        ),
        .init(
            id: "a878a73e95efb7f733962f0312be7a22737ea90e9392fc03dba6261d6825ea3f",
            name: "log-notification-service",
            status: "Up 19 minutes",
            image: "alpine:latest",
            state: "running",
            created: 1769966463,
            env: nil, ports: nil, mounts: nil
        ),
        .init(
            id: "3a9c13b65818e12136f2e43edaa7fcb55f3929185283e5277d38c4329e5e29b4",
            name: "log-payment-service",
            status: "Up 19 minutes",
            image: "alpine:latest",
            state: "running",
            created: 1769966463,
            env: nil, ports: nil, mounts: nil
        ),
        .init(
            id: "74bf8f02aad06db4f7bacef02dc8d1194c050f4162069fb6100eea0e05cf398a",
            name: "log-search-service",
            status: "Up 19 minutes",
            image: "alpine:latest",
            state: "running",
            created: 1769966463,
            env: nil, ports: nil, mounts: nil
        ),
        .init(
            id: "aa067fa185af088a6d64af8a8907f98cc03f4f2c94d078115dd54b908db993c9",
            name: "log-analytics",
            status: "Up 19 minutes",
            image: "alpine:latest",
            state: "running",
            created: 1769966463,
            env: nil, ports: nil, mounts: nil
        ),
        .init(
            id: "a83138d1ff9c3e38fb30d87e40449d1294a563456da1782bc984601e6e267d6c",
            name: "log-metrics",
            status: "Up 19 minutes",
            image: "alpine:latest",
            state: "running",
            created: 1769966463,
            env: nil, ports: nil, mounts: nil
        ),
        .init(
            id: "5fa71b72c8e8c4aaa234a8f6a84364a440745d901162cb66668af053c2401ce6",
            name: "log-cleaner",
            status: "Up 19 minutes",
            image: "alpine:latest",
            state: "running",
            created: 1769966463,
            env: nil, ports: nil, mounts: nil
        ),
    ]

    static func containerDetail(id: String) -> ContainerInfo {
        containers.first(where: { $0.id == id }) ?? containers[0]
    }

    static let defaultAlertSettings = AlertSettings(
        recipientEmail: "demo@pocketlumen.io",
        notificationsEnabled: true
    )

    static func alerts() -> [Alert] {
        let now = Date()
        return [
            .init(id: UUID().uuidString,
                  containerId: "e517a71599f8befac1924000180debd05e9c5bacd3a3a2d4c86d53ba28c86d50",
                  containerName: "log-cpu-heavy",
                  type: "CPU",
                  message: "Critical CPU usage detected: 23.47%",
                  value: 23.47,
                  timestamp: now.addingTimeInterval(-90)),

            .init(id: UUID().uuidString,
                  containerId: "a039244dfa47c1fae56d0c7242f955031e13a084f97ef37915e7e056f240d760",
                  containerName: "lumen-app",
                  type: "CPU",
                  message: "Critical CPU spike: 21.83%",
                  value: 21.83,
                  timestamp: now.addingTimeInterval(-240)),

            .init(id: UUID().uuidString,
                  containerId: "e517a71599f8befac1924000180debd05e9c5bacd3a3a2d4c86d53ba28c86d50",
                  containerName: "log-cpu-heavy",
                  type: "CPU",
                  message: "High CPU usage detected: 15.62%",
                  value: 15.62,
                  timestamp: now.addingTimeInterval(-480)),

            .init(id: UUID().uuidString,
                  containerId: "ed1d3a36a3a3b854d6b2536196565dd9a670b9a007353685940b1c236c26b48c",
                  containerName: "lumen-postgres",
                  type: "CPU",
                  message: "High CPU usage detected: 13.86%",
                  value: 13.86,
                  timestamp: now.addingTimeInterval(-720)),

            .init(id: UUID().uuidString,
                  containerId: "6f17dc43969e870f612f8c37cf5150162440a4c6eb998b773b4142ad8f7ad48e",
                  containerName: "log-mongodb",
                  type: "CPU",
                  message: "Elevated CPU usage: 5.34%",
                  value: 5.34,
                  timestamp: now.addingTimeInterval(-1080)),

            .init(id: UUID().uuidString,
                  containerId: "b0c39a97099bd7565f57865b19ab3d5aed154a10d473292d98758178234c237a",
                  containerName: "lumen-minio",
                  type: "CPU",
                  message: "Elevated CPU usage: 3.21%",
                  value: 3.21,
                  timestamp: now.addingTimeInterval(-1440)),
        ]
    }

    // MARK: - Images
    static let images: [DockerImage] = [
        .init(Containers: -1, Created: 1771742870,
              Id: "sha256:d81ebe6e9ab6", Labels: ["com.docker.compose.project": "lumen"],
              ParentId: "", RepoDigests: [], RepoTags: ["lumen-mobile-app:local"],
              SharedSize: -1, Size: 258_356_524, VirtualSize: nil),
        .init(Containers: -1, Created: 1771742865,
              Id: "sha256:94d7fc5dc55c", Labels: nil, ParentId: "",
              RepoDigests: [], RepoTags: [],
              SharedSize: -1, Size: 662_005_157, VirtualSize: nil),
        .init(Containers: -1, Created: 1771360166,
              Id: "sha256:3547741803ba", Labels: nil, ParentId: "",
              RepoDigests: ["mongo@sha256:81ed620b"], RepoTags: ["mongo:7"],
              SharedSize: -1, Size: 869_730_843, VirtualSize: nil),
        .init(Containers: -1, Created: 1770930428,
              Id: "sha256:87e04d274d18", Labels: nil, ParentId: "",
              RepoDigests: ["postgres@sha256:97ff59a4"], RepoTags: ["postgres:16-alpine"],
              SharedSize: -1, Size: 276_057_247, VirtualSize: nil),
        .init(Containers: -1, Created: 1770330041,
              Id: "sha256:8cfe5582a9ec", Labels: nil, ParentId: "",
              RepoDigests: ["eclipse-temurin@sha256:6ad8ed08"], RepoTags: ["eclipse-temurin:21-jre-alpine"],
              SharedSize: -1, Size: 206_888_404, VirtualSize: nil),
        .init(Containers: -1, Created: 1770250038,
              Id: "sha256:b76de378d572",
              Labels: ["maintainer": "NGINX Docker Maintainers"],
              ParentId: "",
              RepoDigests: ["nginx@sha256:1d13701a"], RepoTags: ["nginx:alpine"],
              SharedSize: -1, Size: 62_121_152, VirtualSize: nil),
        .init(Containers: -1, Created: 1770236760,
              Id: "sha256:2dbdacd9e496", Labels: nil, ParentId: "",
              RepoDigests: ["python@sha256:303398d5"], RepoTags: ["python:3.11-alpine"],
              SharedSize: -1, Size: 54_255_220, VirtualSize: nil),
        .init(Containers: -1, Created: 1769567711,
              Id: "sha256:e08bd8d5a677", Labels: nil, ParentId: "",
              RepoDigests: ["redis@sha256:02f2cc48"], RepoTags: ["redis:7-alpine"],
              SharedSize: -1, Size: 41_413_310, VirtualSize: nil),
        .init(Containers: -1, Created: 1769563084,
              Id: "sha256:a40c03cbb81c", Labels: nil, ParentId: "",
              RepoDigests: ["alpine@sha256:25109184"], RepoTags: ["alpine:latest"],
              SharedSize: -1, Size: 8_442_036, VirtualSize: nil),
        .init(Containers: -1, Created: 1757270557,
              Id: "sha256:69b2ec208575",
              Labels: ["maintainer": "MinIO Inc <dev@min.io>"],
              ParentId: "",
              RepoDigests: ["minio/minio@sha256:14cea493"], RepoTags: ["minio/minio:latest"],
              SharedSize: -1, Size: 175_494_058, VirtualSize: nil),
        .init(Containers: -1, Created: 1702926675,
              Id: "sha256:c38802599f18", Labels: nil, ParentId: "",
              RepoDigests: ["maven@sha256:8d63d4c1"],
              RepoTags: ["maven:3.9.6-eclipse-temurin-21"],
              SharedSize: -1, Size: 509_729_155, VirtualSize: nil),
    ]

    // MARK: - Volumes
    static let volumes: [DockerVolume] = [
        .init(Driver: "local",
              Labels: ["com.docker.compose.project": "lumen-backend",
                       "com.docker.compose.volume": "postgres-data"],
              Mountpoint: "/var/lib/docker/volumes/lumen-backend_postgres-data/_data",
              Name: "lumen-backend_postgres-data", Options: nil),
        .init(Driver: "local",
              Labels: ["com.docker.compose.project": "lumen-backend",
                       "com.docker.compose.volume": "minio-data"],
              Mountpoint: "/var/lib/docker/volumes/lumen-backend_minio-data/_data",
              Name: "lumen-backend_minio-data", Options: nil),
        .init(Driver: "local",
              Labels: ["com.docker.compose.project": "lumen-backend",
                       "com.docker.compose.volume": "mongo-data"],
              Mountpoint: "/var/lib/docker/volumes/lumen-backend_mongo-data/_data",
              Name: "lumen-backend_mongo-data", Options: nil),
        .init(Driver: "local",
              Labels: ["com.docker.volume.anonymous": ""],
              Mountpoint: "/var/lib/docker/volumes/b20e7547841a/_data",
              Name: "b20e7547841a68e52c3ea8350b3d824a2a728e7b77769ea3487251814d2bf2e9",
              Options: nil),
        .init(Driver: "local",
              Labels: ["com.docker.volume.anonymous": ""],
              Mountpoint: "/var/lib/docker/volumes/292cd16fddbb/_data",
              Name: "292cd16fddbbac3bbbead08e2368f313f227d85f56a76b4e9090b9d5d11641da",
              Options: nil),
    ]

    // MARK: - Networks
    static let networks: [DockerNetwork] = [
        .init(Attachable: true, Containers: [:],
              Created: "2026-03-01T07:29:47.842Z", Driver: "bridge", EnableIPv6: false,
              Id: "86208becda290030d0ba1ee5a4e3d525e12167d3a5697c73cdb745844efb2e8e",
              Internal: false,
              IPAM: Ipam(Driver: "default",
                         Config: [IpamConfig(Subnet: "172.18.0.0/16", Gateway: "172.18.0.1",
                                             IPRange: nil, NetworkID: nil)],
                         Options: nil),
              Labels: ["com.docker.compose.network": "lumen-network",
                       "com.docker.compose.project": "lumen-backend"],
              Name: "lumen-backend_lumen-network", Options: nil, Scope: "local"),
        .init(Attachable: false, Containers: [:],
              Created: "2026-03-01T07:15:34.192Z", Driver: "bridge", EnableIPv6: false,
              Id: "1216bac9f91bf91ce3ceda6ad565ab4de3d02f51ed08d495df3bae6bb671ddca",
              Internal: false,
              IPAM: Ipam(Driver: "default",
                         Config: [IpamConfig(Subnet: "172.17.0.0/16", Gateway: "172.17.0.1",
                                             IPRange: nil, NetworkID: nil)],
                         Options: nil),
              Labels: [:], Name: "bridge", Options: nil, Scope: "local"),
        .init(Attachable: false, Containers: [:],
              Created: "2026-03-01T07:15:34.188Z", Driver: "host", EnableIPv6: false,
              Id: "06d58630edc655f9922cc0ca9529b354f73a53f1aa7b9c21cf573cd80e09d9a2",
              Internal: false, IPAM: nil, Labels: [:],
              Name: "host", Options: nil, Scope: "local"),
        .init(Attachable: false, Containers: [:],
              Created: "2026-03-01T07:15:34.184Z", Driver: "null", EnableIPv6: false,
              Id: "39cab6e993037bb96793fb842f453692200e69ff5e73cde528983e03e816f60c",
              Internal: false, IPAM: nil, Labels: [:],
              Name: "none", Options: nil, Scope: "local"),
    ]
}
