//
//  StringExtension.swift
//  OmdbMovies
//
//  Created by LongTM3 on 11/24/21.
//  Copyright © 2021 LongTM3. All rights reserved.
//

import Foundation

extension String {

    var boolValue: Bool {
        return (self as NSString).boolValue
    }
}
