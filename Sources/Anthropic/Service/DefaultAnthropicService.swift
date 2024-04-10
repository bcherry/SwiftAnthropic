//
//  DefaultAnthropicService.swift
//
//
//  Created by James Rochabrun on 1/28/24.
//

import Foundation

struct DefaultAnthropicService: AnthropicService {

   let session: URLSession
   let decoder: JSONDecoder
   let apiKey: String
   let apiVersion: String
   let baseUrl: String

   private static let betaHeader = "tools-2024-04-04"

   init(
      apiKey: String,
      apiVersion: String,
      baseUrl: String,
      configuration: URLSessionConfiguration = .default)
   {
      self.session = URLSession(configuration: configuration)
      let decoderWithSnakeCaseStrategy = JSONDecoder()
      decoderWithSnakeCaseStrategy.keyDecodingStrategy = .convertFromSnakeCase
      self.decoder = decoderWithSnakeCaseStrategy
      self.apiKey = apiKey
      self.apiVersion = apiVersion
      self.baseUrl = baseUrl
   }
   
   // MARK: Message

   func createMessage(
      _ parameter: MessageParameter)
      async throws -> MessageResponse
   {
      var localParameter = parameter
      localParameter.stream = false
      let request = try AnthropicAPI(base: baseUrl).messages.request(apiKey: apiKey, version: apiVersion, method: .post, params: localParameter, beta: Self.betaHeader)
      return try await fetch(type: MessageResponse.self, with: request)
   }
   
   func streamMessage(
      _ parameter: MessageParameter)
      async throws -> AsyncThrowingStream<MessageStreamResponse, Error>
   {
      var localParameter = parameter
      localParameter.stream = true
      let request = try AnthropicAPI(base: baseUrl).messages.request(apiKey: apiKey, version: apiVersion, method: .post, params: localParameter, beta: Self.betaHeader)
      return try await fetchStream(type: MessageStreamResponse.self, with: request)
   }
   
   /// "messages-2023-12-15"
   // MARK: Text Completion

   func createTextCompletion(
      _ parameter: TextCompletionParameter)
      async throws -> TextCompletionResponse
   {
      var localParameter = parameter
      localParameter.stream = false
      let request = try AnthropicAPI(base: baseUrl).textCompletions.request(apiKey: apiKey, version: apiVersion, method: .post, params: localParameter)
      return try await fetch(type: TextCompletionResponse.self, with: request)
   }
   
   func createStreamTextCompletion(
      _ parameter: TextCompletionParameter)
      async throws -> AsyncThrowingStream<TextCompletionStreamResponse, Error>
   {
      var localParameter = parameter
      localParameter.stream = true
      let request = try AnthropicAPI(base: baseUrl).textCompletions.request(apiKey: apiKey, version: apiVersion, method: .post, params: localParameter)
      return try await fetchStream(type: TextCompletionStreamResponse.self, with: request)
   }
   
}
