//
//  QueryLeftNewDTO.swift
//  12306ForMac
//
//  Created by fancymax on 15/8/1.
//  Copyright (c) 2015年 fancy. All rights reserved.
//

import Cocoa

struct SeatTypePair:CustomDebugStringConvertible {
    let seatName:String //无座
    let seatCode:String // 1
    let hasTicket:Bool
    
    init(seatName:String,seatCode:String,hasTicket:Bool) {
        self.seatName = seatName
        self.seatCode = seatCode
        self.hasTicket = hasTicket
    }
    
    var debugDescription: String {
        return "seatName:\(seatName) seatCode:\(seatCode) hasTicket:\(hasTicket)"
    }
}

enum TicketOrder:String {
    case StartTime
    case ArriveTime
    case Lishi
}

@objc protocol QueryLeftNewDTOJSExport:JSExport {
    var secretHBStr:String{get set}
    var secretStr:String{get set}
    var buttonTextInfo:String {get set}
    
    var train_no:String {get set}
    var station_train_code:String {get set}
    var start_station_telecode:String {get set}
    var end_station_telecode:String {get set}
    var from_station_telecode:String {get set}
    var to_station_telecode:String {get set}
    
    var start_time :String{get set}
    var arrive_time :String{get set}
    var lishi :String {get set}
    var canWebBuy: String {get set}
    var yp_info:String {get set}
    var start_train_date :String {get set}
    var train_seat_feature :String {get set}
    var location_code:String {get set}
    var from_station_no :String {get set}
    var to_station_no :String {get set}
    var is_support_card :String {get set}
    var controlled_train_flag :String {get set}
    var gg_num :String {get set}
    var gr_num :String {get set}
    var qt_num :String {get set}
    var rw_num :String {get set}
    var rz_num :String {get set}
    var tz_num :String {get set}
    var wz_num :String {get set}
    var yb_num :String {get set}
    var yw_num :String {get set}
    var yz_num :String {get set}
    var ze_num :String {get set}
    var zy_num :String {get set}
    var swz_num :String {get set}
    var srrb_num :String {get set}
    var yp_ex :String {get set}
    var seat_types :String {get set}
    var exchange_train_flag :String {get set}
    var from_station_name :String {get set}
    var to_station_name :String {get set}
    
    static func createNew() -> QueryLeftNewDTO
}

public class QueryLeftNewDTO:NSObject, QueryLeftNewDTOJSExport{
    
    dynamic var secretHBStr: String
    dynamic var secretStr: String
    dynamic var buttonTextInfo: String 
    dynamic var train_no: String 
    dynamic var station_train_code: String 
    dynamic var start_station_telecode: String 
    dynamic var end_station_telecode: String
    dynamic var from_station_telecode: String
    dynamic var to_station_telecode: String
    dynamic var start_time: String
    dynamic var arrive_time: String
    dynamic var lishi: String
    dynamic var canWebBuy: String
    dynamic var yp_info: String
    dynamic var start_train_date: String
    dynamic var train_seat_feature: String
    dynamic var location_code: String
    dynamic var from_station_no: String
    dynamic var to_station_no: String
    dynamic var is_support_card: String
    dynamic var controlled_train_flag: String 
    dynamic var gg_num: String 
    dynamic var gr_num: String 
    dynamic var qt_num: String 
    dynamic var rw_num: String 
    dynamic var rz_num: String 
    dynamic var tz_num: String
    dynamic var wz_num: String
    dynamic var yb_num: String
    dynamic var yw_num: String
    dynamic var yz_num: String
    dynamic var zy_num: String
    dynamic var ze_num: String 
    dynamic var swz_num: String
    dynamic var srrb_num: String
    dynamic var yp_ex: String
    dynamic var seat_types: String
    dynamic var exchange_train_flag: String
    dynamic var from_station_name: String
    dynamic var to_station_name: String
    
    public override init() {
        secretHBStr = "";
        secretStr = "";
        buttonTextInfo = "";
        train_no = "";
        station_train_code = "";
        start_station_telecode = "";
        end_station_telecode = "";
        from_station_telecode = "";
        to_station_telecode = "";
        start_time = "";
        arrive_time = "";
        lishi = "";
        canWebBuy = "";
        yp_info = "";
        start_train_date = "";
        train_seat_feature = "";
        location_code = "";
        from_station_no = "";
        to_station_no = "";
        is_support_card = "";
        controlled_train_flag = "";
        gg_num = "";
        gr_num = "";
        qt_num = "";
        rw_num = "";
        rz_num = "";
        tz_num = "";
        wz_num = "";
        yb_num = "";
        yw_num = "";
        yz_num = "";
        zy_num = "";
        ze_num = "";
        swz_num = "";
        srrb_num = "";
        yp_ex = "";
        seat_types = "";
        exchange_train_flag = "";
        from_station_name = "";
        to_station_name = "";
    }
    
    static func createNew() -> QueryLeftNewDTO {
        return QueryLeftNewDTO()
    }

//
//    //"12:01"
//    let lishi:String!
//    //"Y"  "IS_TIME_NOT_BUY"预售期未到/系统维护时间
//    let canWebBuy:String?
//
//    //"yp_ex":"O0M0O0"
//    let yp_ex:String?
//    //标识符
//    var SecretStr:String?
//    //票务描述
//    var buttonTextInfo:String
//    //观光
//    var Gg_Num:String!
//    //迎宾
//    var Yb_Num:String!
//    //高级软卧
//    let Gr_Num:String!
//    //其他
//    let Qt_Num:String!
//    //软卧
//    let Rw_Num:String!
//    //软座
//    let Rz_Num:String!
//    //特等座
//    let Tz_Num:String!
//    //无座
//    let Wz_Num:String!
//    //硬卧
//    let Yw_Num:String!
//    //硬座
//    let Yz_Num:String!
//    //二等座
//    let Ze_Num:String!
//    //一等座
//    let Zy_Num:String!
//    //商务座
//    let Swz_Num:String!
    
//// MARK: Custom Property
//    var seatTypePairDic = [String:SeatTypePair]()
//
//    let isStartStation:Bool
//    let isEndStation:Bool
//
//    var hasTicket:Bool = false
//
//    func isTicketInvalid() -> Bool {
//        if controlled_train_flag == "1" {
//            return true
//        }
//        else {
//            return false
//        }
//    }
//
//    func canTicketAdd2Calendar() -> Bool {
//        if buttonTextInfo.contains("起售") {
//            return true
//        }
//        else {
//            return false
//        }
//    }
//
////MARK: Train Date
//    var trainDate:Date!
////    yyyy-MM-dd
//    let trainDateStr:String
//
//    var start_train_date_formatStr:String!
//
//    private func getFormatStartTrainStr(_ dateStr:String)->String {
//        let startIndex = dateStr.startIndex
//
//        var resStr = dateStr
//        resStr.insert("-", at: resStr.index(startIndex, offsetBy: 4))
//        resStr.insert("-", at: resStr.index(startIndex, offsetBy: 7))
//
//        return resStr
//    }
//
//    private func trainDateStr2Date(_ dateStr:String)->Date {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        if let date = dateFormatter.date(from: dateStr) {
//            return date
//        }
//        else {
////            logger.error("trainDateStr2Date dateStr = \(dateStr)")
//            return Date()
//        }
//    }
//
//    //"Fri Dec 04 2015 08:00:00 GMT+0800 (中国标准时间)"
//    var jsStartTrainDateStr:String!
//    fileprivate func getJsStartTrainDateStr(_ date:Date)->String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "EEE MMM dd yyyy '00:00:00' 'GMT'+'0800' '(CST)'"
//        dateFormatter.locale = Locale(identifier: "en-US")
//        return dateFormatter.string(from: date)
//    }
//
////MARK: Seat and Ticket
//    func hasTicketForSeatTypeFilterKey(_ key:String) -> Bool {
//        for val in seatTypePairDic.values {
//            if ((key.contains(val.seatName))&&(val.hasTicket)) {
//                return true
//            }
//        }
//        return false
//    }
//
//    func getSeatTypeNameByFilterKey(_ key:String) -> String? {
//        for val in seatTypePairDic.values {
//            if ((key.contains(val.seatName))&&(val.hasTicket)) {
//                return val.seatName
//            }
//        }
//        return nil
//    }
//
//    func setupHasTicket(){
//        for val in seatTypePairDic.values {
//            if val.hasTicket {
//                hasTicket = true
//                return
//            }
//        }
//    }
    
    
//func getSeatInfosFrom(trainCode:String)->[String:SeatTypePair] {
//    var seatInfos  = [String:SeatTypePair]()
//
//    let seatTypeNameDic = G_QuerySeatTypeNameDicBy(trainCode)
//    let seatTypeKeyPathDic = G_QuerySeatTypeKeyPathDicBy(trainCode)
//    for seatName in seatTypeNameDic.keys {
//        if let keyPath = seatTypeKeyPathDic[seatName] {
//            let seatVal = self.value(forKey: keyPath) as! String
//            if (seatVal != "--") && (seatVal != "无") && (seatVal != "*")&&(seatVal != ""){
//                seatInfos[seatName] = SeatTypePair(seatName: seatName, seatCode: seatTypeNameDic[seatName]!, hasTicket: true)
//            }
//        }
//    }
//
//    return seatInfos
//}
    
//    init(json:JSON, map:JSON, dateStr:String)
//    {
//        isStartStation = (FromStationCode == start_station_telecode)
//        isEndStation = (ToStationCode == end_station_telecode)
//
//        trainDateStr = dateStr
//
//        super.init()
//
//        start_train_date_formatStr = getFormatStartTrainStr(start_train_date)
//
//        trainDate = trainDateStr2Date(dateStr)
//        jsStartTrainDateStr = getJsStartTrainDateStr(trainDate)
//        seatTypePairDic = getSeatInfosFrom(trainCode: TrainCode)
//        setupHasTicket()
//    }
    
}

