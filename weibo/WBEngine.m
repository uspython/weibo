//
//  WBEngine.m
//  SinaWeiBoSDK
//  Based on OAuth 2.0
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//
//  Copyright 2011 Sina. All rights reserved.
//

#import "WBEngine.h"
#import "WBSDKGlobal.h"
#import "WBUtil.h"

#define kWBURLSchemePrefix              @"WB_"

#define kWBKeychainServiceNameSuffix    @"_WeiBoServiceName"
#define kWBKeychainUserID               @"WeiBoUserID"
#define kWBKeychainAccessToken          @"WeiBoAccessToken"
#define kWBKeychainExpireTime           @"WeiBoExpireTime"

@interface WBEngine()

@property(nonatomic, strong) WBAuthorize *authorize;

@end

@implementation WBEngine


#pragma mark - WBEngine Life Circle

- (id)initWithAppKey:(NSString *)theAppKey appSecret:(NSString *)theAppSecret
{
    if (self = [super init])
    {
        self.appKey = theAppKey;
        self.appSecret = theAppSecret;
        
        WBAuthorize *auth = [[WBAuthorize alloc] initWithAppKey:theAppKey appSecret:theAppSecret redirectURL:@"http://"];
        self.authorize = auth;
    }
    
    return self;
}

#pragma mark Request

- (void)loadRequestWithMethodName:(NSString *)methodName
                       httpMethod:(NSString *)httpMethod
                           params:(NSDictionary *)params
                     postDataType:(WBRequestPostDataType)postDataType
                 httpHeaderFields:(NSDictionary *)httpHeaderFields
{

    
    self.request = [WBRequest requestWithAccessToken:self.authorize.accessToken
                                                 url:[NSString stringWithFormat:@"%@%@", kWBSDKAPIDomain, methodName]
                                          httpMethod:httpMethod
                                              params:params
                                        postDataType:postDataType
                                    httpHeaderFields:httpHeaderFields
                                            delegate:self];
	
	[self.request connect];
}

//- (void)sendWeiBoWithText:(NSString *)text image:(Image *)image
//{
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
//
//    //NSString *sendText = [text URLEncodedString];
//    
//	[params setObject:(text ? text : @"") forKey:@"status"];
//	
//    if (image)
//    {
//		[params setObject:image forKey:@"pic"];
//
//        [self loadRequestWithMethodName:@"statuses/upload.json"
//                             httpMethod:@"POST"
//                                 params:params
//                           postDataType:kWBRequestPostDataTypeMultipart
//                       httpHeaderFields:nil];
//    }
//    else
//    {
//        [self loadRequestWithMethodName:@"statuses/update.json"
//                             httpMethod:@"POST"
//                                 params:params
//                           postDataType:kWBRequestPostDataTypeNormal
//                       httpHeaderFields:nil];
//    }
//}




#pragma mark - WBRequestDelegate Methods

- (void)request:(WBRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([self.delegate respondsToSelector:@selector(engine:requestDidSucceedWithResult:)])
    {
        [self.delegate engine:self requestDidSucceedWithResult:result];
    }
}

- (void)request:(WBRequest *)request didFailWithError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(engine:requestDidFailWithError:)])
    {
        [self.delegate engine:self requestDidFailWithError:error];
    }
}

@end
