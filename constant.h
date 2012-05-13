//
//  constant.h
//  mailuo
//
//  Created by Alex on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "MyHttp_remoteClient.h"
#import "DataSingleton.h"



#define SMTH_BASE_URL @"http://www.newsmth.net"

#define NIUMAO_SIGNATURE @"http://www.newsmth.net/nForum/user/query/every1nome"


#define GET_STOCKBOARD_LIST @"http://www.newsmth.net/nForum/board/Stock"
#define GET_NEWEXPRESS_LIST @"http://www.newsmth.net/nForum/board/Picture"


#ifndef __OPTIMIZE__
#ifndef WEIROBOT_NSLOG
#define NSLog(...) NSLog(__VA_ARGS__)
#define WEIROBOT_NSLOG
#endif
#else
#ifndef WEIROBOT_NSLOG
#define NSLog(...) {}
#endif
#endif
@class DataSingleton;
//////////////////////////////////////////
@interface constant : NSObject
{
    DataSingleton* dataRecorder;
}



@end
