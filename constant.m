
#import "constant.h"

#import "DataSingleton.h"

///////////////////////////////////////
@implementation constant


+(NSMutableDictionary*)readDataFromPlist
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary* datas = [defaults valueForKey:@"plist_of_user_like"];
    
    NSLog(@"the data from read %@",datas);
    return datas;
}

+(void)addDataToPlist:(NSString*)Keystring content:(NSString*)ContentString
{
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary* datas = [defaults valueForKey:@"plist_of_user_like"];
    NSMutableDictionary* newdata = [[NSMutableDictionary alloc] initWithDictionary:datas];
    
    [newdata setValue:ContentString forKey:Keystring];
    
    [defaults setObject:newdata forKey:@"plist_of_user_like"];
    
}
@end
