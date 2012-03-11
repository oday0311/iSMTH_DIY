//
//  topicDetailShow.h
//  iSMTH_Stock
//
//  Created by  on 12-3-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface topicDetailShow : UIViewController {
    UIWebView *webivew;
    
    
    NSMutableString* html;
}

@property (strong, nonatomic) IBOutlet UIWebView *webivew;
- (void)loadHtml:(NSString*)middlecontenthtml;
@end
