

#import "DataSingleton.h"

@implementation DataSingleton
@synthesize finalstring;
@synthesize stockBoardlist;
@synthesize topic_detail_link;
@synthesize searchBoardResults;
@synthesize UserFavoriteListUrl;
@synthesize UserFavoriteListName;
@synthesize Selected_complete_url;
@synthesize selected_url_pageIndex;
@synthesize selected_topic_title;
@synthesize ad_config_open,adImageUrl,linkUrl;
@synthesize selectedDate;
@synthesize freshHistoryNeed;
@synthesize IsCookieSetted;
@synthesize cookieDictionary;

@synthesize shortUrl;
@synthesize uploadData;
@synthesize usingMap;
@synthesize mapView;
@synthesize stringSMScontent;
@synthesize DocListFirstload;
@synthesize cookieJsonString;

static DataSingleton * MyCommon_Singleton = nil;

+ (DataSingleton *)singleton

{
    
    @synchronized(self)
    {
        if  (MyCommon_Singleton  ==  nil)
        {
            MyCommon_Singleton=[[DataSingleton alloc] init] ;
            
            
            MyCommon_Singleton.shortUrl = (NSMutableString*)@"";
            MyCommon_Singleton.uploadData= nil;
            
            MyCommon_Singleton.stringSMScontent =(NSMutableString*)@"";
            MyCommon_Singleton.usingMap = 0;
            
            
            
            
            MyCommon_Singleton.finalstring = @"init";
            MyCommon_Singleton.Selected_complete_url = @"";
            
            MyCommon_Singleton.selected_url_pageIndex = 1;
            MyCommon_Singleton.selected_topic_title = @"";
            MyCommon_Singleton.DocListFirstload = 1;       
            
            MyCommon_Singleton.ad_config_open= 0;
            MyCommon_Singleton.adImageUrl = [[NSMutableString alloc] init] ;
            MyCommon_Singleton.linkUrl = [[NSMutableString alloc] init];
            
            
            MyCommon_Singleton.freshHistoryNeed = 0;
            MyCommon_Singleton.selectedDate = [[NSDate alloc] init];
            
            
            
            
            
            MyCommon_Singleton.searchBoardResults = [[NSMutableArray alloc] init];
            
            
            MyCommon_Singleton.IsCookieSetted = 0;
            MyCommon_Singleton.cookieDictionary = [[NSMutableDictionary alloc] init];
            
            
            MyCommon_Singleton.UserFavoriteListUrl = [[NSMutableArray alloc] init];
            //股票
            [MyCommon_Singleton.UserFavoriteListUrl addObject:@"nForum/board/NewExpress"];
             //贴图
            [MyCommon_Singleton.UserFavoriteListUrl addObject:@"nForum/board/Picture"];
            //
            [MyCommon_Singleton.UserFavoriteListUrl addObject:@"nForum/board/Joke"];
            [MyCommon_Singleton.UserFavoriteListUrl addObject:@"nForum/board/MMJoke"];
            //求职广场
            [MyCommon_Singleton.UserFavoriteListUrl addObject:@"nForum/board/Career_Plaza"];
            //社会招聘
            [MyCommon_Singleton.UserFavoriteListUrl addObject:@"nForum/board/Career_Upgrade"];
            
            //猎头招聘
            [MyCommon_Singleton.UserFavoriteListUrl addObject:@"/nForum/board/ExecutiveSearch"];
            
            //家庭生活
            [MyCommon_Singleton.UserFavoriteListUrl addObject:@"nForum/board/FamilyLife"];
            [MyCommon_Singleton.UserFavoriteListUrl addObject:@"nForum/board/WorkLife"];
            [MyCommon_Singleton.UserFavoriteListUrl addObject:@"nForum/board/EconForum"];
            [MyCommon_Singleton.UserFavoriteListUrl addObject:@"nForum/board/MyPhoto"];
            
            {
                MyCommon_Singleton.UserFavoriteListName = [[NSMutableArray alloc] init];
                [MyCommon_Singleton.UserFavoriteListName addObject:@"水木特快"];
                [MyCommon_Singleton.UserFavoriteListName addObject:@"贴图"];
                [MyCommon_Singleton.UserFavoriteListName addObject:@"笑话联翩 Joke"];
                [MyCommon_Singleton.UserFavoriteListName addObject:@"幽默全方位 MMJoke"];
                
                [MyCommon_Singleton.UserFavoriteListName addObject:@"求职广场"];
                [MyCommon_Singleton.UserFavoriteListName addObject:@"社会招聘"];
                
                [MyCommon_Singleton.UserFavoriteListName addObject:@"猎头招聘"];
                [MyCommon_Singleton.UserFavoriteListName addObject:@"家庭生活"];
                    
                [MyCommon_Singleton.UserFavoriteListName addObject:@"职业生涯"];
                [MyCommon_Singleton.UserFavoriteListName addObject:@"经济论坛"];
                [MyCommon_Singleton.UserFavoriteListName addObject:@"个人show"];
                
            }
            {
                 NSMutableDictionary* dataDictionary = [constant readDataFromPlist];
                NSArray* keys = [dataDictionary allKeys];
                for (int i = 0; i<[keys count]; i++) {
                    NSString* keystring = [keys objectAtIndex:i];
                    NSString* contentstring = [dataDictionary valueForKey:keystring];
                    [MyCommon_Singleton.UserFavoriteListName addObject:keystring];
                    [MyCommon_Singleton.UserFavoriteListUrl addObject:contentstring];
                }
            }
        
    
        }
    }
    
    return  MyCommon_Singleton;
    
}
+(void)addDefaultUserFavorite
{
    
}
+  (id)allocWithZone:(NSZone  * )zone
{
    @synchronized(self)
    {
        if (MyCommon_Singleton  ==  nil)
        {
            MyCommon_Singleton  =  [super allocWithZone:zone];
            return  MyCommon_Singleton;
        }
    }
    
    return  nil;
}


- (id)copyWithZone:(NSZone *)zone
{
    return self;
}







-(void)dealloc
{
  
    //[super dealloc];
}

@end
