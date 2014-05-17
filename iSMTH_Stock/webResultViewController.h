//
//  webResultViewController.h
//  iSMTH_DIY
//
//  Created by Apple on 13-3-23.
//
//

#import <UIKit/UIKit.h>

@interface webResultViewController : UIViewController
{
    NSString*htmlString;
}
@property(nonatomic,strong)NSString* htmlString;
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end
