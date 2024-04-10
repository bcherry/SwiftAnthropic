//
//  AnthropicAPI.swift
//
//
//  Created by James Rochabrun on 1/28/24.
//

import Foundation

// MARK: AnthropicAPI

struct AnthropicAPI {
    let base: String

    var messages: Endpoint {
        StaticEndpoint(base: base, path: "/v1/messages")
    }

    var textCompletions: Endpoint {
        StaticEndpoint(base: base, path: "/v1/complete")
    }
}

// MARK: AnthropicAPI+Endpoint

struct StaticEndpoint: Endpoint {
    let base: String
    let path: String
}
