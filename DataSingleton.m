

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


static DataSingleton * MyCommon_Singleton = nil;

+ (DataSingleton *)singleton

{
    
    @synchronized(self)
    {
        if  (MyCommon_Singleton  ==  nil)
        {
            MyCommon_Singleton=[[DataSingleton alloc] init] ;
            MyCommon_Singleton.finalstring = @"init";
            MyCommon_Singleton.Selected_complete_url = @"";
            
            MyCommon_Singleton.selected_url_pageIndex = 1;
            
            MyCommon_Singleton.searchBoardResults = [[NSMutableArray alloc] init];
            
            MyCommon_Singleton.UserFavoriteListUrl = [[NSMutableArray alloc] init];
            //股票
            [MyCommon_Singleton.UserFavoriteListUrl addObject:@"nForum/board/Stock"];
             //贴图
            [MyCommon_Singleton.UserFavoriteListUrl addObject:@"nForum/board/Picture"];
            //
            [MyCommon_Singleton.UserFavoriteListUrl addObject:@"nForum/board/Joke"];
            [MyCommon_Singleton.UserFavoriteListUrl addObject:@"nForum/board/MMJoke"];
            //求职广场
            [MyCommon_Singleton.UserFavoriteListUrl addObject:@"nForum/board/Career_Plaza"];
            //社会招聘
            [MyCommon_Singleton.UserFavoriteListUrl addObject:@"nForum/board/Career_Upgrade"];
            //家庭生活
            [MyCommon_Singleton.UserFavoriteListUrl addObject:@"nForum/board/FamilyLife"];
            [MyCommon_Singleton.UserFavoriteListUrl addObject:@"nForum/board/WorkLife"];
            
            
            {
                MyCommon_Singleton.UserFavoriteListName = [[NSMutableArray alloc] init];
                [MyCommon_Singleton.UserFavoriteListName addObject:@"股票"];
                [MyCommon_Singleton.UserFavoriteListName addObject:@"贴图"];
                [MyCommon_Singleton.UserFavoriteListName addObject:@"笑话联翩 Joke"];
                [MyCommon_Singleton.UserFavoriteListName addObject:@"幽默全方位 MMJoke"];
                
                [MyCommon_Singleton.UserFavoriteListName addObject:@"求职广场"];
                [MyCommon_Singleton.UserFavoriteListName addObject:@"社会招聘"];
                [MyCommon_Singleton.UserFavoriteListName addObject:@"家庭生活"];
                    
                [MyCommon_Singleton.UserFavoriteListName addObject:@"职业生涯"];
            
            }
            
            
            
        }
    }
    
    return  MyCommon_Singleton;
    
}
-(void)addDefaultUserFavorite
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
