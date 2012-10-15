
#import "HttpClient.h"

@interface HttpClientSampleViewController : UIViewController <HttpClientDelegate>
{
    HttpClient                      *httpClient;
}

- (IBAction)showInfo:(id)sender;
- (IBAction)testHttp:(id)sender;

@end
