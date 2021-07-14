//
//  SearchableRecord.swift
//  Continuum
//
//  Created by Jaymond Richardson on 5/12/21.
//

import Foundation

protocol SearchableRecord: AnyObject {
    func matches(searchTerm: String) -> Bool
}
