//
//  topicDetailShow.h
//  iSMTH_Stock
//
//  Created by  on 12-3-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "constant.h"
#import "GADBannerView.h"
@interface topicDetailShow : UIViewController <MBProgressHUDDelegate,GADBannerViewDelegate>{
    UIWebView *webivew;
    MBProgressHUD *HUD;
    
    NSMutableString* html;
    int pageIndex;
    int maxPage;
    
    UILabel* PagelabelView;
    
    
     GADBannerView *adView;
    UIButton* adSelfDefineButton;
}

@property(nonatomic,retain) GADBannerView *adView;

@property (strong, nonatomic) IBOutlet UIWebView *webivew;
- (void)loadHtml:(NSString*)middlecontenthtml;
@end
