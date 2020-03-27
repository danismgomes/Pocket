//
//  DoubleExtention.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-03-26.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import Foundation

extension Double
{
    func truncate(places : Int)-> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
