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
    NSString* selected_topic_title;
    
    ////////////////
    int DocListFirstload ;
    
    
    ///////////////////
    
    
    /////////////////////////////
    int ad_config_open;
    NSMutableString* adImageUrl;
    NSMutableString* linkUrl;
    
    int freshHistoryNeed;
    NSDate* selectedDate;
    
    
    
    /////////////
    int IsCookieSetted;
    NSMutableDictionary* cookieDictionary;
    NSMutableString* cookieJsonString;
    
    
    
    ////////////////////////
    NSMutableString* shortUrl;
    NSData* uploadData;
    
    ////////////////////////////////////
    int usingMap;
    UIImage* mapView;
    
    
    ////////////////////////////////////
    NSMutableString* stringSMScontent;
};

+ (DataSingleton *)singleton;

@property(nonatomic,retain)NSMutableString* cookieJsonString;
@property(nonatomic,retain) NSMutableString* stringSMScontent;
@property(nonatomic,assign) int usingMap;
@property(nonatomic,retain) UIImage* mapView;

@property(nonatomic,retain) NSData* uploadData;
@property(nonatomic,retain) NSMutableString* shortUrl;


@property(nonatomic, retain) NSMutableDictionary* cookieDictionary;
@property(nonatomic,assign) int IsCookieSetted;
@property(nonatomic, assign)    int freshHistoryNeed;

@property(nonatomic, retain)    NSDate* selectedDate;

@property(nonatomic,assign)int ad_config_open;
@property(nonatomic,retain)NSMutableString* adImageUrl;
@property(nonatomic,retain) NSMutableString* linkUrl;
@property(nonatomic,retain)  NSString* selected_topic_title;
@property(nonatomic,assign)int DocListFirstload ;
@property(nonatomic,assign) NSInteger selected_url_pageIndex;
@property(nonatomic,retain) NSString*Selected_complete_url;
@property(nonatomic,retain) NSMutableArray*UserFavoriteListUrl;
@property(nonatomic,retain) NSMutableArray*UserFavoriteListName;

@property(nonatomic,retain) NSString* topic_detail_link;
@property(nonatomic,retain) NSString* finalstring;
@property(nonatomic,retain) NSString* stockBoardlist;
@property(nonatomic,retain) NSMutableArray* searchBoardResults;

@end

