//
//  Quote.swift
//  HabitTracker
//
//  Created by Marcelo Casanovas on 6/1/26.
//

import Foundation

struct Quote : Equatable
{
    let text: String
    let author: String
    
}

struct ZenQuoteDTO : Decodable{
    
    let q: String // quote text desde la API
    let a: String // author desde la API
    
}
