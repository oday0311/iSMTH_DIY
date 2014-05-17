//
//  ViewController.m
//  WaterFlowDisplay
//
//  Created by B.H. Liu on 12-3-29.
//  Copyright (c) 2012年 Appublisher. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "AsyncImageView.h"
#import "NSString+PDRegex.h"
#import "imageCacheManager.h"
#import "topicDetailShow.h"
#import "UIGlossyButton.h"

#define NUMBER_OF_COLUMNS 2

@interface ViewController ()
@property (nonatomic,retain) NSMutableArray *imageUrls;
@property (nonatomic,readwrite) int currentPage;
@end

@implementation ViewController
@synthesize imageUrls=_imageUrls;
@synthesize currentPage=_currentPage;
@synthesize matchDictionary;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"图片贴", @"图片贴");
        self.tabBarItem.image = [UIImage imageNamed:@"third"];
    }
    return self;
}
-(void)startGetbtsmthPicture
{
    httpClient=[[HttpClient alloc] initWithDelegate:self];
    //[httpClient getBtsmthContentList:@"http://easynote.sinaapp.com/ismth/getcontent.php"];
    
    
    [httpClient getBtsmthContentList:@"http://www.btsmth.com/show_all_pic_articles.php"];
    
}

-(void)startThreadWork_getBtSmthPitures
{
    dispatch_queue_t downloadQueue = dispatch_queue_create("get private message queue", NULL);
    dispatch_async(downloadQueue, ^{
        [self startGetbtsmthPicture];
        dispatch_async(dispatch_get_main_queue(), ^{
            //update the UI in main queue;
            [flowView reloadData];
        }); });
    dispatch_release(downloadQueue); //won’t actually go away until queue is empty
    
}
static int pictureFirstAppear = 1;
- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.topItem.title = @"图片贴";
    
    if (pictureFirstAppear == 1) {
        pictureFirstAppear = 0;
        [self startThreadWork_getBtSmthPitures];
          //safer to do it here, in case it may delay viewDidLoad
    }
    
}




- (void)viewDidLoad
{
    [super viewDidLoad];
     srand((unsigned)time(0));
    self.currentPage = 1;
    
    
    self.picPostDetailUrlArray = [[[NSMutableArray alloc] init] autorelease];
    self.imageUrls = [[[NSMutableArray alloc] initWithObjects:
                       
                       @"http://www.btsmth.com/attachments/953.10364306.297.jpg",
                       @"http://www.btsmth.com/attachments/953.10364306.297.jpg",
                       @"http://www.btsmth.com/attachments/953.10364306.297.jpg",
                       
                       @"http://www.btsmth.com/attachments/953.10364306.297.jpg",
                       @"http://www.btsmth.com/attachments/953.10364306.297.jpg",
                       @"http://www.btsmth.com/attachments/953.10364306.297.jpg",
                       @"http://www.btsmth.com/attachments/953.10364306.297.jpg",
                       @"http://www.btsmth.com/attachments/953.10364306.297.jpg",
                       
                       nil] autorelease];
    
    {
        matchDictionary = [[NSMutableDictionary alloc] init] ;
        [matchDictionary setObject:@"FamilyLife" forKey:@"9"];
        [matchDictionary setObject:@"" forKey:@"65"];
        [matchDictionary setObject:@"Beauty" forKey:@"135"];
        [matchDictionary setObject:@"DSLR" forKey:@"179"];
        [matchDictionary setObject:@"EconForum" forKey:@"225"];
        [matchDictionary setObject:@"" forKey:@"387"];
        [matchDictionary setObject:@"PieLife" forKey:@"398"];
        [matchDictionary setObject:@"Age" forKey:@"953"];
        [matchDictionary setObject:@"Elite" forKey:@"956"];
        [matchDictionary setObject:@"MyPhoto" forKey:@"874"];
        [matchDictionary setObject:@"OurEstate" forKey:@"1030"];
        [matchDictionary setObject:@"Diablo" forKey:@"1298"];
        [matchDictionary setObject:@"Picture" forKey:@"1349"];

        
        
    }
    
    
	// Do any additional setup after loading the view, typically from a nib.    
    flowView = [[WaterflowView alloc] initWithFrame:self.view.frame];
    flowView.flowdatasource = self;
    flowView.flowdelegate = self;
    [self.view addSubview:flowView];
    
    
    UIView* pageIndexView = [self createPageIndexView];
    [self.view addSubview: pageIndexView];
    
    //[self startThreadWork_getBtSmthPitures];
    //
    
}

- (void)dealloc
{
    self.imageUrls = nil;
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark-
#pragma mark- WaterflowDataSource

- (NSInteger)numberOfColumnsInFlowView:(WaterflowView *)flowView
{
    return NUMBER_OF_COLUMNS;
}

- (NSInteger)flowView:(WaterflowView *)flowView numberOfRowsInColumn:(NSInteger)column
{
    return [self.imageUrls count]/NUMBER_OF_COLUMNS;
}

- (WaterFlowCell *)flowView:(WaterflowView *)flowView_ cellForRowAtIndex:(NSInteger)index
{
    
    NSLog(@"this is called");
    static NSString *CellIdentifier = @"Cell";
	WaterFlowCell *cell = [flowView_ dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if(cell == nil)
	{
		cell  = [[[WaterFlowCell alloc] initWithReuseIdentifier:CellIdentifier] autorelease];
		
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[cell addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:223/255.0 alpha:1.0];


		imageView.layer.borderColor = [[UIColor whiteColor] CGColor];
		imageView.layer.borderWidth = 1;
		[imageView release];
		imageView.tag = 1001;
	}
    
    float height = [self flowView:nil heightForCellAtIndex:index];
    
    UIImageView *imageView  = (UIImageView *)[cell viewWithTag:1001];
	imageView.frame = CGRectMake(0, 0, self.view.frame.size.width / NUMBER_OF_COLUMNS, height);
    
    //[imageView loadImage:[self.imageUrls objectAtIndex:index ]];
	[imageCacheManager setImageView:imageView withUrlString:[self.imageUrls objectAtIndex:index ]];
	return cell;
    
}

- (WaterFlowCell*)flowView:(WaterflowView *)flowView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    static NSString *CellIdentifier = @"Cell";
	WaterFlowCell *cell = [flowView_ dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if(cell == nil)
	{
		cell  = [[[WaterFlowCell alloc] initWithReuseIdentifier:CellIdentifier] autorelease];
		
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[cell addSubview:imageView];
        imageView.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:223/255.0 alpha:1.0];

        imageView.contentMode = UIViewContentModeScaleAspectFit;
		imageView.layer.borderColor = [[UIColor whiteColor] CGColor];
		imageView.layer.borderWidth = 1;
		[imageView release];
		imageView.tag = 1001;
	}
	
	float height = [self flowView:nil heightForRowAtIndexPath:indexPath];
	
	UIImageView *imageView  = (UIImageView *)[cell viewWithTag:1001];
	imageView.frame = CGRectMake(0, 0, self.view.frame.size.width /NUMBER_OF_COLUMNS , height);
    
    
   
    
    int imageIndex = (indexPath.row+indexPath.section*12) % self.imageUrls.count;
    
    //[imageView loadImage:[self.imageUrls objectAtIndex: imageIndex ]];
	[imageCacheManager setImageView:imageView withUrlString:[self.imageUrls objectAtIndex:imageIndex ]];
     NSLog(@"the indexpath is section , row: , %d, %d ..url is %@", indexPath.section, indexPath.row, [self.imageUrls objectAtIndex:imageIndex]);
    
	return cell;
    
}

#pragma mark-
#pragma mark- WaterflowDelegate

- (CGFloat)flowView:(WaterflowView *)flowView heightForCellAtIndex:(NSInteger)index
{
    float height = 0;
	switch (index  % 5) {
		case 0:
			height = 127;
			break;
		case 1:
			height = 120;
			break;
		case 2:
			height = 147;
			break;
		case 3:
			height = 144;
			break;
		case 4:
			height = 140;
			break;
		case 5:
			height = 158;
			break;
		default:
			break;
	}
	
	return height;
}

-(CGFloat)flowView:(WaterflowView *)flowView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
	float height = 0;
	switch ((indexPath.row + indexPath.section )  % 5) {
		case 0:
			height = 127;
			break;
		case 1:
			height = 120;
			break;
		case 2:
			height = 147;
			break;
		case 3:
			height = 144;
			break;
		case 4:
			height = 140;
			break;
		case 5:
			height = 158;
			break;
		default:
			break;
	}
	
	height += indexPath.row + indexPath.section;
	
	return height;
    
}

- (void)flowView:(WaterflowView *)flowView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did select at %@",indexPath);
    
    
    if (self.picPostDetailUrlArray.count > 0) {
        
        //////?en_name=Picture&gid=83203 the url format
        int imageIndex = (indexPath.row+indexPath.section*12) % self.imageUrls.count;
        NSString* urlstring = [self.picPostDetailUrlArray objectAtIndex:imageIndex ];
        
        
        NSArray* bangkuaiName = [urlstring stringsByExtractingGroupsUsingRegexPattern:@".*en_name=(.*)&gid"];
        NSArray *postIndex = [urlstring stringsByExtractingGroupsUsingRegexPattern:@".*&gid=(.*)"];
        if ([bangkuaiName count]>0&& [postIndex count]>0) {
            
            NSString* bangkuaistring = [bangkuaiName objectAtIndex:0];
            NSString* postIndexString = [postIndex objectAtIndex:0];

            /// http://www.newsmth.net/nForum/article/Career_Plaza/1385183

            /////// http://www.newsmth.net/nForum/#!article/PieLove/1985438
            
            
            urlstring =[ @"http://www.newsmth.net/nForum/article/" stringByAppendingFormat:@"%@/%@", bangkuaistring,postIndexString];
            NSLog(@"Urlstring is %@",urlstring);
            
            
            
            
            [DataSingleton singleton].topic_detail_link = urlstring;
            topicDetailShow*
            viewController2 = [[topicDetailShow alloc] initWithNibName:@"topicDetailShow" bundle:nil];
            [self.navigationController pushViewController:viewController2 animated:YES];


        }

        
    }
}

- (void)flowView:(WaterflowView *)flowView didSelectAtCell:(WaterFlowCell *)cell ForIndex:(int)index
{
    NSLog(@"did selected ");
}

- (void)flowView:(WaterflowView *)_flowView willLoadData:(int)page
{
    [flowView reloadData];
}



/////transfer the btsmth url to newsmth picurl
///   http://att.newsmth.net/nForum/att/Picture/77274/551/small


-(NSString*)urltransfer:(NSString*)btsmthpictureurl
{
    
    ////Input sample: 953.10366646.1176
    NSArray*  btsmthModulePart = [btsmthpictureurl componentsSeparatedByString:@"."];
    if (btsmthModulePart.count !=3) {
        return @"";
    }
    
    NSString* newsmthbaseUrl = @"http://att.newsmth.net/nForum/att/";
    NSString* moduleSequenceString = [btsmthModulePart objectAtIndex:0];
    NSString*modulestring = [matchDictionary valueForKey:moduleSequenceString];
    if (modulestring.length < 2) {
        return @"";
    }
    
    newsmthbaseUrl = [@"" stringByAppendingFormat:@"%@%@/%@/%@/middle", newsmthbaseUrl,modulestring,[btsmthModulePart objectAtIndex:1], [btsmthModulePart objectAtIndex:2]];
    
    return newsmthbaseUrl;
}

-(void)getPicturesUrl:(NSString*)resultstring
{
      ////<img src="attachments/953.10366646.1176.jpg"
    [self.imageUrls removeAllObjects];
    [self.picPostDetailUrlArray removeAllObjects];
    
    
    resultstring = [resultstring stringByReplacingRegexPattern:@"width=" withString:@"\n"];
    NSArray *matches_name = [resultstring stringsByExtractingGroupsUsingRegexPattern:@"<a href=(.*).jpg"];
    
    
   
    
    for (int i = 0; i<matches_name.count; i++) {
        NSString* tempstring = [matches_name objectAtIndex:i];
        NSLog(@"the link string is  : %@", tempstring);
       
        NSArray* matches_detailurl = [tempstring stringsByExtractingGroupsUsingRegexPattern:@"\"show_topic.php?(.*)\" onclick.*"];
        NSArray *matches_picurl = [tempstring stringsByExtractingGroupsUsingRegexPattern:@".*attachments/(.*)"];
        if (matches_picurl.count >0 && matches_detailurl.count >0)
        {
            NSString* codestring = [matches_picurl objectAtIndex:0];
            NSLog(@"the pic code string is %@", codestring);
            NSString* myStringUrl = [self urltransfer:codestring];
            
            NSString* detailstring = [matches_detailurl objectAtIndex:0];
             if (myStringUrl.length >= 2 && detailstring.length >= 2)
             {
                 ///add to the list.
                 [self.imageUrls addObject:myStringUrl];
                 [self.picPostDetailUrlArray addObject:detailstring];
             }


        }
        
    
    }
    
    NSLog(@"the valid picture url count is %d", self.imageUrls.count);
    
}
///////////////////////////////////////////
-(void)doSuccess:(NSString *)dict
{
    //NSLog(@"The return string is %@", dict);
    
    [self getPicturesUrl:dict];
    [flowView reloadData];
}
-(void)doFail:(NSString *)msg
{
    NSLog(@"this is do fail");
}
-(void)doNetWorkFail
{
    NSLog(@"This is NetWork fail");
}

-(NSString*)dateStringFromNow:(NSInteger)addDaysCount
{
    //NSString *myStringDate = @"11_11_17";
    
    // How much day to add
    //addDaysCount = -30;
    
    // Creating and configuring date formatter instance
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yy_MM_dd"];
    
    // Retrieve NSDate instance from stringified date presentation
    NSDate *dateFromString = [[NSDate alloc]init];
    //[dateFormatter dateFromString:myStringDate];
    
    // Create and initialize date component instance
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:addDaysCount];
    
    // Retrieve date with increased days count
    NSDate *newDate = [[NSCalendar currentCalendar]
                       dateByAddingComponents:dateComponents
                       toDate:dateFromString options:0];
    
    NSLog(@"Original date: %@", [dateFormatter stringFromDate:dateFromString]);
    NSLog(@"New date: %@", [dateFormatter stringFromDate:newDate]);
    
    return [dateFormatter stringFromDate:newDate];
}

-(void)startGetbtsmthPictureWithDate:(NSString*)DateString
{
    httpClient=[[HttpClient alloc] initWithDelegate:self];
    NSString* finalstring = [@"http://easynote.sinaapp.com/ismth/getcontent.php?date=" stringByAppendingFormat:@"%@",DateString];
    [httpClient getBtsmthContentList:finalstring];
    
}

-(void)startThreadWork_getBtSmthPituresWithDate:(NSString*)DateString
{
    dispatch_queue_t downloadQueue = dispatch_queue_create("get private message queue", NULL);
    dispatch_async(downloadQueue, ^{
        [self startGetbtsmthPictureWithDate:DateString];
        dispatch_async(dispatch_get_main_queue(), ^{
            //update the UI in main queue;
            [flowView reloadData];
        }); });
    dispatch_release(downloadQueue); //won’t actually go away until queue is empty
    
}


static int AdddayCounts = 0;
-(void)btnPressLast
{
    NSLog(@"btnPressLast begin ");
    
    AdddayCounts--;

    NSString* datestring = [self dateStringFromNow:AdddayCounts];
    ////////we do not have content before 12-10-31
    NSString* dateJudgeString =  [datestring stringByReplacingRegexPattern:@"_" withString:@""];
   
    if ( dateJudgeString.intValue < 121030) {
        AdddayCounts++;
        datestring = [self dateStringFromNow:AdddayCounts];
    }
    else{
        PagelabelView.text = [@"日期: " stringByAppendingFormat:@"%@", datestring ];
        
        [self startThreadWork_getBtSmthPituresWithDate:datestring];

    }
   
}

-(void)btnPressNext
{
    NSLog(@"btnPressNext begin ");
    AdddayCounts++;
    if (AdddayCounts>0) {
        AdddayCounts=0;
    }
    else{
        NSString* datestring = [self dateStringFromNow:AdddayCounts];
        
        PagelabelView.text =  [@"日期: " stringByAppendingFormat:@"%@", datestring ];;
        
        [self startThreadWork_getBtSmthPituresWithDate:datestring];
    }
   
}


-(UIView*)createPageIndexView
{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 40)];
    customView.backgroundColor= [UIColor colorWithRed:189/255.0 green:197/255.0 blue:198/255.0 alpha:0.8];
    {
        
        UIGNavigationButton *b;
        
        b = [[UIGNavigationButton alloc] initWithFrame:CGRectMake(15, 5, 80, 30)] ;
        b.leftArrow = YES;
        [b setNavigationButtonWithColor:[UIColor navigationBarButtonColor]];
        
        UILabel* textlabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 60, 30)];
        textlabel.backgroundColor = [UIColor clearColor];
        textlabel.textColor = [UIColor whiteColor];
        textlabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:16];
        textlabel.text =  @"上一页";
        
        [b addTarget:self action:@selector(btnPressLast) forControlEvents:UIControlEventTouchUpInside];
        [b addSubview:textlabel];
        [customView addSubview: b];
        
    }
    
    {
        // Creating and configuring date formatter instance
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yy_MM_dd"];
        // Retrieve NSDate instance from stringified date presentation
        NSDate *dateFromString = [[NSDate alloc] init];
        
        PagelabelView = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 120, 30)];
        PagelabelView.backgroundColor = [UIColor clearColor];
        PagelabelView.text = [@"日期: " stringByAppendingFormat:@"%@", [dateFormatter stringFromDate:dateFromString] ];
        
        [customView addSubview:PagelabelView];
    }
    
    {
        UIGNavigationButton *b;
        
        b = [[UIGNavigationButton alloc] initWithFrame:CGRectMake(225, 5, 80, 30)];
        b.leftArrow = NO;
        [b setNavigationButtonWithColor:[UIColor navigationBarButtonColor]];
        
        UILabel* textlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, 30)] ;
        textlabel.backgroundColor = [UIColor clearColor];
        textlabel.textColor = [UIColor whiteColor];
        textlabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:16];
        textlabel.text =  @"下一页";
        
        [b addTarget:self action:@selector(btnPressNext) forControlEvents:UIControlEventTouchUpInside];
        [b addSubview:textlabel];
        [customView addSubview: b];
    }
    
    
    
    return customView;
}
@end
