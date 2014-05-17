//
//  BaiduShiTuViewController.h
//  iSMTH_DIY
//
//  Created by Apple on 13-3-22.
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "MBProgressHUD.h"
#import "HttpClient.h"
@interface BaiduShiTuViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,
MFMailComposeViewControllerDelegate,
MFMessageComposeViewControllerDelegate,MBProgressHUDDelegate,HttpClientDelegate>
{
    MBProgressHUD *HUD;
     HttpClient                      *httpClient;
}
- (IBAction)selectPic:(id)sender;

- (IBAction)shituAPI:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *myimageView;



@end
