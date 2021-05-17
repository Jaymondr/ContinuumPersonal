//
//  SearchableRecord.swift
//  Continuum
//
//  Created by Jaymond Richardson on 5/12/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import Foundation

protocol SearchableRecord: AnyObject {
    func matches(searchTerm: String) -> Bool
}
