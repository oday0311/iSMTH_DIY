//
//  HttpClinetUingASIhttp_getWeather.h
//  Air_Reporter
//
//  Created by Alex on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASIHTTPRequest.h"
#import "DataSingleton.h"





@interface HttpClinetUingASIhttp_summaryReport : NSObject<ASIHTTPRequestDelegate>
{
    
}


-(void)httpGetWeather;
@end
