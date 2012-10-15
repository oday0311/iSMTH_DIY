

#import <Foundation/Foundation.h>

@protocol HttpClientDelegate <NSObject>

@required
-(void)doSuccess:(NSDictionary *)dict;
-(void)doFail:(NSString *)msg;
@optional
-(void)doNetWorkFail;

@end
