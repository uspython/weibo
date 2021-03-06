//
//  WBAuthorize.h
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

#import <Foundation/Foundation.h>

#import "WBRequest.h"

@class WBAuthorize;

@protocol WBAuthorizeDelegate <NSObject>

@optional

- (void)authorize:(WBAuthorize *)authorize didSucceedWithAccessToken:(NSString *)accessToken userID:(NSString *)userID expiresIn:(NSInteger)seconds;

- (void)authorize:(WBAuthorize *)authorize didFailWithError:(NSError *)error;

@end

@interface WBAuthorize : NSObject <WBRequestDelegate> 


@property (nonatomic, strong) NSString *appKey;
@property (nonatomic, strong) NSString *appSecret;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *redirectURL;
@property (nonatomic, strong) WBRequest *request;
@property (nonatomic, weak) id<WBAuthorizeDelegate> delegate;

+(WBAuthorize *)sharedInstance;

- (id)initWithAppKey:(NSString *)theAppKey appSecret:(NSString *)theAppSecret redirectURL:(NSString *)redirectURL;
- (NSURLRequest *)getAuthorizeUrl;
- (void)requestAccessTokenWithAuthorizeCode:(NSString *)code;
- (void)requestUserInfo;
- (void)logout;
- (BOOL)isLoggedIn;
- (BOOL)isAuthorizationExpired;
- (void)deleteAuthorization;

@end
