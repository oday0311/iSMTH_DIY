//
//  DataSingleton.h
//  tableview
//
//  Created by Alex on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "constant.h"

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
@class StatusDataSource;

@interface DataSingleton : NSObject{
    NSString* finalstring;
    
    
    ////////
    
    NSString* stockBoardlist;
    
    
    ////
    
    NSString* topic_detail_link;
};

+ (DataSingleton *)singleton;
@property(nonatomic,retain) NSString* topic_detail_link;@property(nonatomic,retain) NSString* finalstring;
@property(nonatomic,retain) NSString* stockBoardlist;
@end

