//
//  LeftTicketDTO.swift
//  Train12306
//
//  Created by fancymax on 15/10/24.
//  Copyright © 2015年 fancy. All rights reserved.
//

import Foundation

public struct LeftTicketParam{
    public init() {
    }
    //2015-09-23
    public var train_date = "2015-09-23"
    //SZQ  ->  深圳
    public var from_stationCode = "SZQ"
    //SHH  ->  上海
    public var to_stationCode = "SHH"
    //ADULT
    public var purpose_codes = "ADULT"
    
    func ToGetParams()->String{
        return "leftTicketDTO.train_date=\(train_date)&leftTicketDTO.from_station=\(from_stationCode)&leftTicketDTO.to_station=\(to_stationCode)&purpose_codes=\(purpose_codes)"
    }
}
