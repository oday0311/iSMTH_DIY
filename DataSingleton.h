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
    
    NSMutableArray* searchBoardResults;
    
    ////////////////////////
    
    NSMutableArray* UserFavoriteListUrl;
    NSMutableArray* UserFavoriteListName;
    
    ////////////////////////
    NSString* Selected_complete_url;
    NSInteger selected_url_pageIndex;
    
};

+ (DataSingleton *)singleton;

@property(nonatomic,assign) NSInteger selected_url_pageIndex;
@property(nonatomic,retain) NSString*Selected_complete_url;
@property(nonatomic,retain) NSMutableArray*UserFavoriteListUrl;
@property(nonatomic,retain) NSMutableArray*UserFavoriteListName;

@property(nonatomic,retain) NSString* topic_detail_link;
@property(nonatomic,retain) NSString* finalstring;
@property(nonatomic,retain) NSString* stockBoardlist;
@property(nonatomic,retain) NSMutableArray* searchBoardResults;

@end

