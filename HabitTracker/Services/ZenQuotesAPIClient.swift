//
//  ZenQuotesAPIClient.swift
//  HabitTracker
//
//  Created by Marcelo Casanovas on 6/1/26.
//
import Foundation

enum QuoteAPIError: Error, LocalizedError {

    case invalidURL
    case invalidResponse
    case badStatusCode(Int)
    case decodingFailed
    
    var errorDescription: String? {
        
        switch self {
        case .invalidURL : return "URL Invalida"
        case .invalidResponse : return "Respuesta invalida del servidor"
        case .badStatusCode(let code) : return "Error del servidor (HTTP \(code))"
        case .decodingFailed : return "No se pudo interpretar la respuesta"
        }
    }
    
}

final class ZenQuotesAPIClient {
    
    private let endpoint = "https://zenquotes.io/api/today"
    
    func fetchTodayQuote() async throws -> Quote {
        
        guard let url = URL(string: endpoint) else {throw QuoteAPIError.invalidURL}
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let http = response as? HTTPURLResponse else {throw QuoteAPIError.invalidResponse}
        
        guard (200...299).contains(http.statusCode) else {throw QuoteAPIError.badStatusCode(http.statusCode)}
        
        guard let dto = try JSONDecoder().decode([ZenQuoteDTO].self, from: data).first else {
            throw QuoteAPIError.decodingFailed
        }
        
        return Quote(text: dto.q, author: dto.a)
    }
    
}
