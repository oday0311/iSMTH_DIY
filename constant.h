


#import <Foundation/Foundation.h>
#import "MyHttp_remoteClient.h"
#import "DataSingleton.h"


////a1501758f6d0a00
////a15090cb8c6f891
#define ADMOB_PUBLISH_ID @"a15090cb8c6f891"
#define UMENG_ID @"508dfc395270151c54000046"
#define SMTH_BASE_URL @"http://www.newsmth.net/"

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

+(NSMutableDictionary*)readDataFromPlist;
+(void)addDataToPlist:(NSString*)Keystring content:(NSString*)ContentString;

@end
