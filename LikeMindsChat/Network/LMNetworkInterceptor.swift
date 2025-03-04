//
//  LMNetworkInterceptor.swift
//  LikeMindsChat
//
//  Created by Anurag Tyagi on 03/03/25.
//

import Alamofire
import Foundation

/// `LMNetworkInterceptor` is a custom `RequestInterceptor` that intercepts Alamofire requests and retries them
/// for specific HTTP status codes using exponential backoff strategy.
///
/// Status codes that trigger retry attempts:
/// - 500 (Internal Server Error)
/// - 502 (Bad Gateway)
/// - 503 (Service Unavailable)
/// - 504 (Gateway Timeout)
/// - 408 (Request Timeout)
/// - 429 (Too Many Requests)
///
/// Exponential backoff logic:
/// - Delay is calculated as `pow(2.0, Double(currentRetryCount - 1))`
/// - For `currentRetryCount` = 1, delay = 1 second
/// - For `currentRetryCount` = 2, delay = 2 seconds
/// - For `currentRetryCount` = 3, delay = 4 seconds
class LMNetworkInterceptor: RequestInterceptor {

    /// The maximum number of times a request is retried before giving up.
    private let maxRetryCount = 3

    /**
     Determines whether or not a request should be retried based on the response status code.

     - Parameters:
       - request: The `Request` instance that has failed.
       - session: The `Session` containing the request.
       - error: The `Error` that caused the request to fail.
       - completion: A closure to execute once a retry decision has been made, passing a `RetryResult`.
     */
    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {

        // Attempt to get the response from the completed task.
        guard let response = request.task?.response as? HTTPURLResponse else {
            // If there's no HTTP response, we cannot decide on retry based on status code.
            // Indicate not to retry.
            completion(.doNotRetry)
            return
        }

        // Only retry requests for these HTTP status codes
        let statusCodesToRetry = [500, 502, 503, 504, 408, 429]

        // Get how many times this request has been retried.
        let currentRetryCount = request.retryCount

        // Stop retrying if we've reached or exceeded the maximum retry count.
        if currentRetryCount >= maxRetryCount {
            completion(.doNotRetry)
            return
        }

        // If the response status code is not one of the specified,
        // do not attempt retry.
        guard statusCodesToRetry.contains(response.statusCode) else {
            completion(.doNotRetry)
            return
        }

        // Use exponential backoff to calculate the delay (in seconds).
        // Example:
        // - for 1st retryCount = 1 => pow(2, 0) = 1 second
        // - for 2nd retryCount = 2 => pow(2, 1) = 2 seconds
        // - for 3rd retryCount = 3 => pow(2, 2) = 4 seconds
        let retryDelay = pow(2.0, Double(currentRetryCount - 1))

        // Tell Alamofire to retry with the calculated delay.
        completion(.retryWithDelay(retryDelay))
    }
}
