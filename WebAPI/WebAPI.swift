//
//  WebAPI.swift
//  Test12306ForMac
//
//  Created by fancymax on 2018/1/22.
//  Copyright © 2018年 fancyApp. All rights reserved.
//

import Foundation
import JavaScriptCore

public class WebAPI: NSObject {
    
    private lazy var xmlRequest:XMLHttpRequest! = {
        return XMLHttpRequest()
    }()
    
    private lazy var context:JSContext = {
        return JSContext()
    }()
    
    override public init() {
        super.init()
        
        let jsPath = Bundle(for: WebAPI.self).path(forResource: "WebAPI", ofType: "js")!
        let jsContent = try! String(contentsOfFile: jsPath)
        
        let block:@convention(block) (String) -> () = { info in
            print(info)
        }
        
        context.setObject(block, forKeyedSubscript:"log" as NSCopying & NSObjectProtocol)
        context.setObject(QueryLeftNewDTO.self, forKeyedSubscript: "QueryLeftNewDTO" as NSCopying & NSObjectProtocol)
        
        context.exceptionHandler = { context, error in
            print(error)
        }
        
        xmlRequest.extend(context)
        context.evaluateScript(jsContent)
    }
    
    public func queryTicketFlow() -> [QueryLeftNewDTO]? {
        let queryTicket = context.objectForKeyedSubscript("queryTicketFlow")
        if let tickets = queryTicket?.call(withArguments: []).toArray() as? [QueryLeftNewDTO] {
            return tickets
        }
        
        return nil
    }
}
