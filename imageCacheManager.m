//
//  imageCacheManager.m
//  trueNameSimpler
//
//  Created by Alex on 9/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "imageCacheManager.h"

@implementation imageCacheManager
static NSString*g_cacheDirectory = @"";
+(void) clearCache
{
    NSFileManager* fm = [NSFileManager defaultManager];
    NSDirectoryEnumerator* en = [fm enumeratorAtPath: g_cacheDirectory];
    
    NSError* err = nil;
    BOOL res;
    
    NSString* file = nil;
    while(file = [en nextObject]) 
    {
        res = [fm removeItemAtPath:[g_cacheDirectory stringByAppendingPathComponent:file] error:&err];
        if (!res && err) 
        {
            //NSLog(@"oops: %@", err);
        }
    }
    
}

+(void) initCacheDirectory
{
    g_cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, //NSDocumentDirectory or NSCachesDirectory
                                                            NSUserDomainMask, //NSUserDomainMask
                                                            YES)    // YES
                        objectAtIndex: 0];
    
    
    
    //[self clearCache];
}

+(UIImage *) getImageFromUrlString: (NSString *) urlString
{
    //NSFileManager *fileManager = [NSFileManager defaultManager];
    UIImage *returnImage;
    
    NSString *imageCachePath = [urlString stringByReplacingOccurrencesOfString: @"/" withString: @"_"];
    imageCachePath = [g_cacheDirectory stringByAppendingPathComponent: imageCachePath];
    
    // 从网络上获取图片
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString: urlString]];
    
    if(data != nil)
    {
        [data writeToFile: imageCachePath atomically: YES];
        
        returnImage = [UIImage imageWithData: data];
        
        return returnImage;
    }else
    {
        //huangzf :not all the url link will be work ok;
        //[data writeToFile: imageCachePath atomically: YES];
        
        returnImage = [UIImage imageNamed:@"empty.png"];
        
        return returnImage;
    }
    
}

//for button back ground
+(void) setButtonViewThread: (NSArray *) parameterArray
{
   
    
    UIButton *button = [parameterArray objectAtIndex: 0];
    
    NSString *urlString = [parameterArray objectAtIndex: 1];
    
    [button setBackgroundImage: [self getImageFromUrlString: urlString] forState: UIControlStateNormal];
    
   
}
+(void) setButtonView: (UIButton *) button withUrlString: (NSString *) urlString
{
    NSArray *parameterArray = [NSArray arrayWithObjects: button, urlString, nil];
    
    NSString *imageCachePath = [urlString stringByReplacingOccurrencesOfString: @"/" withString: @"_"];
    imageCachePath = [g_cacheDirectory stringByAppendingPathComponent: imageCachePath]; 
    //NSLog(@"imageCachePath%@",imageCachePath);
    //TODO: 被修改
    [button setBackgroundImage:[UIImage imageNamed:@"loading_default.png"] forState:UIControlStateNormal];
    if([[NSFileManager defaultManager] fileExistsAtPath: imageCachePath])
    {
        [button setBackgroundImage: [UIImage imageWithContentsOfFile: imageCachePath] forState: UIControlStateNormal];
    }
    else 
    {
        [self performSelectorInBackground: @selector(setButtonViewThread:) withObject: parameterArray];
    }
}
//for image view
+(void) setImageViewThread: (NSArray *) parameterArray
{
   
    
    UIImageView *imageView = [parameterArray objectAtIndex: 0];
    
    NSString *urlString = [parameterArray objectAtIndex: 1];
    
    
    UIImage *returnImage = [self getImageFromUrlString: urlString];
    [imageView stopAnimating];
    [imageView setImage:returnImage];
   
   
}
+(void) setImageView: (UIImageView*) imageView withUrlString: (NSString *) urlString
{
    NSArray *parameterArray = [NSArray arrayWithObjects: imageView, urlString, nil];
    
    NSString *imageCachePath = [urlString stringByReplacingOccurrencesOfString: @"/" withString: @"_"];
    
    
    imageCachePath = [g_cacheDirectory stringByAppendingPathComponent: imageCachePath]; 
    //NSLog(@"imageCachePath%@",imageCachePath);
    //TODO: 被修改
    
    //[imageView setImage:[UIImage imageNamed:@"empty.png"]];
    if([[NSFileManager defaultManager] fileExistsAtPath: imageCachePath])
    {
        //[button setBackgroundImage: [UIImage imageWithContentsOfFile: imageCachePath] forState: UIControlStateNormal];
        
        //huangzf 
        [imageView stopAnimating];
        
        [imageView setImage:[UIImage imageWithContentsOfFile:imageCachePath]];
        NSLog(@"Image loading from cache file,%@",imageCachePath);
    }
    else 
    {
        [self performSelectorInBackground: @selector(setImageViewThread:) withObject: parameterArray];
        NSLog(@"Image loading url internet %@",imageCachePath);
    }
}



@end
