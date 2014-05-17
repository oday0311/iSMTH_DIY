//
//  BaiduShiTuViewController.m
//  iSMTH_DIY
//
//  Created by Apple on 13-3-22.
//
//

#import "BaiduShiTuViewController.h"
#import "HttpPicUploader.h"
#import "webResultViewController.h"
#import "DataSingleton.h"
@interface BaiduShiTuViewController ()

@end

@implementation BaiduShiTuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    ////http://t2.baidu.com/it/u=2476226196,694006789&fm=15&gp=0.jpg
    //[ ]
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#define ACTION_SHEET_TITLE_PICfromAlbumn @"选自相册"
#define ACTION_SHEET_TITLE_PICfromCamera @"选自照相机"
#define ACTION_SHEET_TITLE_REMOVE_PIC @"删除当前照片"
#define ACTION_SHEET_TITLE_4 @""

-(void)PopupActionSheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:ACTION_SHEET_TITLE_PICfromAlbumn,ACTION_SHEET_TITLE_PICfromCamera, nil];
    [actionSheet showInView:self.view];
    
}


-(void)showAlbum
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *m_imagePicker = [[UIImagePickerController alloc] init];
        m_imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        m_imagePicker.delegate = self;
        [m_imagePicker setAllowsEditing:YES];
        [self presentModalViewController:m_imagePicker animated:YES];
    }else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:
                              @"访问图片库出错!" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alert show];
    }
}
-(void)showCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *m_imagePicker = [[UIImagePickerController alloc] init];
        m_imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        m_imagePicker.delegate = self;
        [m_imagePicker setAllowsEditing:YES];
        self.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        [self presentModalViewController:m_imagePicker animated:YES];
    }else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:
                              @"访问相机出错!" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alert show];
    }
}




-(void)PopupRemovePicSheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:ACTION_SHEET_TITLE_REMOVE_PIC, nil];
    [actionSheet showInView:self.view];
    
}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString* ATtitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([ATtitle isEqualToString:ACTION_SHEET_TITLE_PICfromAlbumn]) {
        [self showAlbum];
    }
    else if([ATtitle isEqualToString:ACTION_SHEET_TITLE_PICfromCamera])
    {
        [self showCamera];
    }
    else if([ATtitle isEqualToString:ACTION_SHEET_TITLE_REMOVE_PIC])
    {
        //[self removePicFromScrollview];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //controller.image=[info objectForKey:UIImagePickerControllerEditedImage];
    //    recognize.delegate=self;
    
    
    //[DataSingleton singleton].usingMap = 2;
    
    UIImage*temp =[info objectForKey:UIImagePickerControllerEditedImage];
    self.myimageView.image = temp;
    [picker dismissViewControllerAnimated:NO completion:^{
        
    }];
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}






#pragma mark -
#pragma mark Compose Mail/SMS



// Displays an SMS composition interface inside the application.
-(void)displaySMSComposerSheet
{
//	MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
//	picker.messageComposeDelegate = self;
//	picker.body = [@"" stringByAppendingFormat:@"%@ %@", dataRecorder.shortUrl,smsContentTextView.text];
//    picker.title = @"新短信";
//	[self presentModalViewController:picker animated:YES];
}


#pragma mark -
#pragma mark Dismiss Mail/SMS view controller



#pragma mark -
#pragma mark Compose Mail/SMS

// Displays an email composition interface inside the application. Populates all the Mail fields.
-(void)displayMailComposerSheet
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"Hello from California!"];
	
	
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:@"first@example.com"];
	NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
	NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
	
	[picker setToRecipients:toRecipients];
	[picker setCcRecipients:ccRecipients];
	[picker setBccRecipients:bccRecipients];
	
	// Attach an image to the email
	NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"jpg"];
	NSData *myData = [NSData dataWithContentsOfFile:path];
	[picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"rainy"];
	
	// Fill out the email body text
	NSString *emailBody = @"It is raining in sunny California!";
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
}




#pragma mark -
#pragma mark Dismiss Mail/SMS view controller

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the
// message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
			break;
		case MFMailComposeResultSent:
			break;
		case MFMailComposeResultFailed:
			break;
		default:
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}


// Dismisses the message composition interface when users tap Cancel or Send. Proceeds to update the
// feedback message field with the result of the operation.
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
	
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MessageComposeResultCancelled:
			break;
		case MessageComposeResultSent:
			break;
		case MessageComposeResultFailed:
			break;
		default:
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}


- (IBAction)selectPic:(id)sender {
    [self PopupActionSheet];
}

- (IBAction)shituAPI:(id)sender {
    [self uploadwithMBProgressHUD];
}

-(void)storeJPGimage:(UIImage*)image
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test.jpg"]; ;
    
    // Write a UIImage to JPEG with minimum compression (best quality)
    // The value 'image' must be a UIImage object
    // The value '1.0' represents image compression quality as value from 0.0 to 1.0
    
    NSUserDefaults *persistentDefaults = [NSUserDefaults standardUserDefaults];
    NSString* rateString = [persistentDefaults objectForKey:@"compressRate"];
    double rate = rateString.doubleValue;
    double realRate = rate*0.5;
    
    [DataSingleton singleton].uploadData = UIImageJPEGRepresentation(image, realRate);
    
    
    [UIImageJPEGRepresentation(image, realRate) writeToFile:path atomically:YES];
    
}

-(void)testUploadPic
{
    
    [self storeJPGimage:self.myimageView.image];
    
    NSString *path =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test.jpg"];
    
    HttpPicUploader*temp =  [[HttpPicUploader alloc] initWithURL:[NSURL URLWithString:@"http://easynote.sinaapp.com/saestorage.php"]
                                                        filePath:path
                                                        delegate:self
                                                    doneSelector:@selector(onUploadDone:)
                                                   errorSelector:@selector(onUploadError:)];
}
- (void)uploadwithMBProgressHUD {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = @"上传中";
    [HUD show:YES];
    [HUD setHidden:NO];
    [self testUploadPic];
    
    //[HUD showWhileExecuting:@selector(testUploadPic) onTarget:self withObject:nil animated:YES];
    
}
- (void)hudWasHidden {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];

}

-(void)onUploadDone:(id)sender
{
    httpClient=[[HttpClient alloc] initWithDelegate:self];
    [httpClient httpBaiduShiTuImage:[DataSingleton singleton].shortUrl];
    
    [HUD setHidden:YES];
    [HUD show:NO];
    NSLog(@"upload data done");
#if TARGET_IPHONE_SIMULATOR
    // 模拟器
#elif TARGET_OS_IPHONE
    // 目标板
    //////////start the SMS
    [self displaySMSComposerSheet];
    
#else
    
#endif
    
}

-(void)onUploadError:(id)sender
{
    [HUD setHidden:YES];
    [HUD show:NO];
    NSLog(@"upload data fail");
}

- (void)viewDidUnload {
    [self setMyimageView:nil];
    [super viewDidUnload];
}

///////////////////////////////////////////
-(void)doSuccess:(NSString *)dict
{
    NSLog(@"The return string is %@", dict);
    webResultViewController* controller =
    [[webResultViewController alloc] initWithNibName:@"webResultViewController" bundle:nil];
    controller.htmlString = dict;
    [self.navigationController pushViewController:controller animated:YES];


}
-(void)doFail:(NSString *)msg
{
    NSLog(@"this is do fail");
}
-(void)doNetWorkFail
{
    NSLog(@"This is NetWork fail");
}

@end
