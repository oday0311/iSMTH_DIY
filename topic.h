//
//  topic.h
//  iSMTH_Stock
//
//  Created by  on 12-3-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface topic : NSObject
{
    NSString* topicTitle;
    NSString* link;
    NSString* creator;
    NSString* createTime;
    BOOL        IsTopTopic;
    
}
@property(nonatomic,retain) NSString* topicTitle;
@property(nonatomic,retain) NSString*link;
@property(nonatomic,retain) NSString*creator;
@property(nonatomic,retain) NSString* createTime;
@property(assign) BOOL IsTopTopic;

@end
