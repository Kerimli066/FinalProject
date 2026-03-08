//
//  PocketLumenEndpoint.swift
//  Final Project
//
//  Created by SabinaKarimli on 13.02.26.
//


import Foundation

enum PocketLumenEndpoint {
    case listContainers(base: String)
    case containerDetail(base: String, id: String)
    case startContainer(base: String, id: String)
    case stopContainer(base: String, id: String)
    case restartContainer(base: String, id: String)
    case removeContainer(base: String, id: String)

    case listImages(base: String)
    case listNetworks(base: String)
    case listVolumes(base: String)

    case alertHistory(base: String)
    case clearAlertHistory(base: String)
    case getAlertSettings(base: String)
    case updateAlertSettings(base: String, body: AlertSettings)
}

extension PocketLumenEndpoint: Endpoint {

    var baseURL: String {
        switch self {
        case .listContainers(let b),
             .containerDetail(let b, _),
             .startContainer(let b, _),
             .stopContainer(let b, _),
             .restartContainer(let b, _),
             .removeContainer(let b, _),
             .listImages(let b),
             .listNetworks(let b),
             .listVolumes(let b),
             .alertHistory(let b),
             .clearAlertHistory(let b),
             .getAlertSettings(let b),
             .updateAlertSettings(let b, _):
            return b
        }
    }

    var path: String {
        switch self {
        case .listContainers:
            return "/containers"
        case .containerDetail(_, let id):
            return "/containers/\(id)"
        case .startContainer(_, let id):
            return "/containers/\(id)/start"
        case .stopContainer(_, let id):
            return "/containers/\(id)/stop"
        case .restartContainer(_, let id):
            return "/containers/\(id)/restart"
        case .removeContainer(_, let id):
            return "/containers/\(id)"

        case .listImages:
            return "/containers/images"
        case .listNetworks:
            return "/containers/networks"
        case .listVolumes:
            return "/containers/volumes"

        case .alertHistory:
            return "/alerts/history"
        case .clearAlertHistory:
            return "/alerts/history"
        case .getAlertSettings:
            return "/alerts/settings"
        case .updateAlertSettings:
            return "/alerts/settings"
        }
    }

    var method: HttpMethod {
        switch self {
        case .listContainers, .containerDetail, .listImages, .listNetworks, .listVolumes, .alertHistory, .getAlertSettings:
            return .get
        case .startContainer, .stopContainer, .restartContainer, .updateAlertSettings:
            return .post
        case .removeContainer, .clearAlertHistory:
            return .delete
        }
    }

    var headers: [String : String]? { nil }
    var queryItems: [URLQueryItem]? { nil }

    var httpBody: Encodable? {
        switch self {
        case .updateAlertSettings(_, let body):
            return body
        default:
            return nil
        }
    }
}
