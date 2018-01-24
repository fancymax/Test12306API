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
    
    public func queryTicketFlowWith(_ params:LeftTicketParam,success:@escaping ([QueryLeftNewDTO])->Void,failure:@escaping (NSError)->Void) {
        guard let queryTicketFunc = context.objectForKeyedSubscript("queryTicketFlow") else {
            //TODO call error
            return
        }
        
        let paramStr = params.ToGetParams()
        DispatchQueue.global().async {
            if let tickets = queryTicketFunc.call(withArguments: [paramStr]).toArray() as? [QueryLeftNewDTO] {
                DispatchQueue.main.async {
                    success(tickets)
                }
            }
            else {
                //TODO call error
            }
        }
    }
}
