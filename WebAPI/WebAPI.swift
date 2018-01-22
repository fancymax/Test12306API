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
    
    var xmlRequest:XMLHttpRequest!
    var context = JSContext()!
    
    override public init() {
        let jsPath = Bundle(for: WebAPI.self).path(forResource: "WebAPI", ofType: "js")!
        let jsContent = try! String(contentsOfFile: jsPath)
        
        let block:@convention(block) (String) -> () = { info in
            Swift.print(info)
        }
        
        context.setObject(block, forKeyedSubscript:"log" as NSCopying & NSObjectProtocol)
        
        context.exceptionHandler = { context, error in
            Swift.print(error)
        }
        
        xmlRequest = XMLHttpRequest()
        xmlRequest.extend(context)
        context.evaluateScript(jsContent)
    }
    
    public func queryTicketFlow() {
        let queryTicket = context.objectForKeyedSubscript("queryTicketFlow")
        queryTicket?.call(withArguments: [])
    }
}
