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

#define NUMBER_OF_COLUMNS 3

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
        self.title = NSLocalizedString(@"图片", @"图片");
        self.tabBarItem.image = [UIImage imageNamed:@"third"];
    }
    return self;
}
-(void)startGetbtsmthPicture
{
    httpClient=[[HttpClient alloc] initWithDelegate:self];
    [httpClient getBtsmthContentList:@"http://www.btsmth.com/show_all_pic_articles.php"];
    
}

-(void)startThreadWork_getBtSmthPitures
{
    dispatch_queue_t downloadQueue = dispatch_queue_create("get private message queue", NULL);
    dispatch_async(downloadQueue, ^{
        [self startGetbtsmthPicture];
        dispatch_async(dispatch_get_main_queue(), ^{
            //update the UI in main queue;
        }); });
    dispatch_release(downloadQueue); //won’t actually go away until queue is empty
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentPage = 1;
    
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
        matchDictionary = [[[NSMutableDictionary alloc] init] autorelease];
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
    
    
    
    
    //[self startThreadWork_getBtSmthPitures];
    //
    [self startGetbtsmthPicture];
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

- (void)viewDidAppear:(BOOL)animated
{
    [flowView reloadData];  //safer to do it here, in case it may delay viewDidLoad
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
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
		
		AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:CGRectZero];
		[cell addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleToFill;
		imageView.layer.borderColor = [[UIColor whiteColor] CGColor];
		imageView.layer.borderWidth = 1;
		[imageView release];
		imageView.tag = 1001;
	}
    
    float height = [self flowView:nil heightForCellAtIndex:index];
    
    AsyncImageView *imageView  = (AsyncImageView *)[cell viewWithTag:1001];
	imageView.frame = CGRectMake(0, 0, self.view.frame.size.width / NUMBER_OF_COLUMNS, height);
    
    [imageView loadImage:[self.imageUrls objectAtIndex:index ]];
	
	return cell;
    
}

- (WaterFlowCell*)flowView:(WaterflowView *)flowView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"the indexpath is section , row: , %d, %d", indexPath.section, indexPath.row);
    static NSString *CellIdentifier = @"Cell";
	WaterFlowCell *cell = [flowView_ dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if(cell == nil)
	{
		cell  = [[[WaterFlowCell alloc] initWithReuseIdentifier:CellIdentifier] autorelease];
		
		AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:CGRectZero];
		[cell addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleToFill;
		imageView.layer.borderColor = [[UIColor whiteColor] CGColor];
		imageView.layer.borderWidth = 1;
		[imageView release];
		imageView.tag = 1001;
	}
	
	float height = [self flowView:nil heightForRowAtIndexPath:indexPath];
	
	AsyncImageView *imageView  = (AsyncImageView *)[cell viewWithTag:1001];
	imageView.frame = CGRectMake(0, 0, self.view.frame.size.width / 3, height);
    
    
    int imageIndex = (indexPath.section*NUMBER_OF_COLUMNS+indexPath.row ) % self.imageUrls.count;
    [imageView loadImage:[self.imageUrls objectAtIndex: imageIndex ]];
	
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
			height = 100;
			break;
		case 2:
			height = 87;
			break;
		case 3:
			height = 114;
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
			height = 100;
			break;
		case 2:
			height = 87;
			break;
		case 3:
			height = 114;
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
    
    NSString*modulestring = [matchDictionary valueForKey:[btsmthModulePart objectAtIndex:0]];
    if (modulestring.length < 2) {
        return @"";
    }
    
    newsmthbaseUrl = [@"" stringByAppendingFormat:@"%@%@/%@/%@/small", newsmthbaseUrl,modulestring,[btsmthModulePart objectAtIndex:1], [btsmthModulePart objectAtIndex:2]];
    
    return newsmthbaseUrl;
}

-(void)getPicturesUrl:(NSString*)resultstring
{
      ////<img src="attachments/953.10366646.1176.jpg"
    [self.imageUrls removeAllObjects];
    resultstring = [resultstring stringByReplacingRegexPattern:@"width=" withString:@"\n"];
    NSArray *matches_name = [resultstring stringsByExtractingGroupsUsingRegexPattern:@"src=\"attachments/(.*).jpg"];
    
    for (int i = 0; i<matches_name.count; i++) {
        NSString* tempstring = [matches_name objectAtIndex:i];
        NSLog(@"the picture url : %@", tempstring);
        
        
        NSString* myStringUrl = [self urltransfer:tempstring];
        if (myStringUrl.length >= 2) {
            ///add to the list.
            NSLog(@"the newsmth url is : %@", myStringUrl);
            [self.imageUrls addObject:myStringUrl];
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
@end
