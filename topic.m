//
//  topic.m
//  iSMTH_Stock
//
//  Created by  on 12-3-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "topic.h"
@implementation topic

@synthesize topicTitle,link,createTime,creator,IsTopTopic;


- (id)init
{
    self = [super init];
    if (self) {
        
        topicTitle = [[NSString alloc] init];
        link = [[NSString alloc] init];
        creator = [[NSString alloc] init];
        createTime =[[NSString alloc] init];
        IsTopTopic = FALSE;
        
    }
    
    
    return self;
}
@end
