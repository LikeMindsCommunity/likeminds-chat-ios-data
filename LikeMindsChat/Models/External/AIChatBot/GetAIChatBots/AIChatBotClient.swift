//
//  AIChatBotClient.swift
//  LikeMindsChat
//
//  Created by Arpit Verma on 10/04/25.
//

import Foundation

/// Client class for handling AI Chatbots related network requests.
/// Inherits from `ServiceRequest` to utilize common network request functionalities.
/// Provides methods to interact with the AI Chatbots API endpoints.
class AIChatBotsClient: ServiceRequest {
    /// Fetches the list of AI chatbots with pagination
    /// - Parameters:
    ///   - request: GetAIChatbotsRequest containing page and pageSize
    ///   - moduleName: Name of the module making the request
    ///   - response: Callback to handle the response
    static func getAIChatbots(
        request: GetAIChatbotsRequest,
        withModuleName moduleName: String,
        _ response: LMClientResponse<GetAIChatbotsResponse>?
    ) {
        // Construct the network path for the API request
        let networkPath = ServiceAPIRequest.NetworkPath.getAIChatbots(request)
        
        // Create the URL for the API endpoint
        guard let url: URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {
            response?(LMResponse.failureResponse("Invalid URL"))
            return
        }
        
        // Make the network request
        DataNetwork.shared.requestWithDecoded(
            for: url,
            withHTTPMethod: networkPath.httpMethod,
            headers: ServiceRequest.httpHeaders(),
            withParameters: networkPath.parameters,
            withEncoding: networkPath.encoding,
            withResponseType: GetAIChatbotsResponse.self,
            withModuleName: moduleName
        ) { (moduleName, responseData) in
            // Handle successful response
            guard let result = responseData as? LMResponse<GetAIChatbotsResponse> else {
                response?(LMResponse.failureResponse("Failed to parse response"))
                return
            }
            
            // Check if the API call was successful
            if !result.success {
                response?(LMResponse.failureResponse(result.errorMessage ?? "Unknown error"))
                return
            }
            
            // Return success response with data if available
            if let data = result.data {
                response?(LMResponse.successResponse(data))
            } else {
                response?(LMResponse.failureResponse("No data received"))
            }
            
        } failureCallback: { (moduleName, error) in
            // Handle network request failure
            response?(LMResponse.failureResponse(error.errorMessage))
        }
    }
}
