//
//  DailyQuoteViewModel.swift
//  HabitTracker
//
//  Created by Marcelo Casanovas on 6/1/26.
//

import Foundation

@MainActor
final class DailyQuoteViewModel : ObservableObject {
    
    enum State: Equatable {
        
        case idle
        case loading
        case loaded (Quote)
        case failed (String)
        
    }
    
    @Published private(set) var state: State = .idle
    
    private let apiClient : ZenQuotesAPIClient
    
    init(apiClient: ZenQuotesAPIClient = ZenQuotesAPIClient()){
        self.apiClient = apiClient
    }
    
    
    func loadTodayQuote() async {
        
        if case .loaded = state {return}
        
        state = .loading
        do {
            
            let quote = try await apiClient.fetchTodayQuote()
            state = .loaded(quote)
        }catch{
            let message = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
            state = .failed(message)
        }
        
    }
    
    func retry() async {
        state = .idle
        await loadTodayQuote()
    }
    
}
