//
//  GetAppleMediaService.m
//  AppleiTunesMedia
//
//  Created by Umer Afzal on 13/03/2019.
//  Copyright © 2019 Umer Afzal. All rights reserved.
//

#import "GetAppleMediaService.h"
#import "GenericService.h"

@implementation GetAppleMediaService

-(void)getAppleMediaDataService:(MediaType)mediaType withCompletionHandler:(void(^)(NSDictionary* mediaDic, NSError* error))completionHandler
{
    
    // Calling Service Request
    GenericService *genericSercie =  [[GenericService alloc] init];
    
    NSMutableDictionary *header = [[NSMutableDictionary alloc]init];
    // Creating Final Update Service Url
    NSString *finalMediaSerivceUrl = @"";
    
    if (mediaType == APPLEMUSIC )
    {
       finalMediaSerivceUrl = [NSString stringWithFormat:APPLE_MEDIA_BASE_URL,[NSString stringWithFormat:@"%@",ITUNES_MUSIC]];
    }
    else if (mediaType == ITUNESMUSIC)
    {
         finalMediaSerivceUrl = [NSString stringWithFormat:APPLE_MEDIA_BASE_URL,[NSString stringWithFormat:@"%@",ITUNES_MUSIC]];
    }
    else if (mediaType == IOSAPP)
    {
        finalMediaSerivceUrl = [NSString stringWithFormat:APPLE_MEDIA_BASE_URL,[NSString stringWithFormat:@"%@",IOS_APPS]];
    }
    
    [genericSercie callServiceWithURL:finalMediaSerivceUrl requestType:GET httpHeader:header
                           parameters:nil callWithControlerId:self withCompletionHandler:^(NSData * _Nonnull data, NSError * _Nonnull error) {
                               
                               
                               @try {
                                   if (data) {
                                       int status = [[data valueForKey:@"success"] intValue];
                                       
                                       if (status == 1)
                                       {
                                           NSError* error;
                                           NSDictionary* jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                                                                options:kNilOptions
                                                                                                  error:&error];
                                           if(completionHandler) {
                                               completionHandler(jsonDic, nil);
                                           }
                                       }
                                       else
                                       {
                                           NSError *error = [NSError errorWithDomain:[data valueForKey:@"error"] code:200 userInfo:nil];
                                           
                                           if(completionHandler) {
                                               completionHandler(nil, error);
                                           }
                                       }
                                   }
                                   else
                                   {
                                       if(completionHandler) {
                                           completionHandler(nil, error);
                                       }
                                   }
                               } @catch (NSException *exception) {
                                   NSLog(@" Media Service Exception %@", exception);
                                   if(completionHandler) {
                                       completionHandler(nil, error);
                                   }
                                   
                               } @finally {
                                   
                               }
                               
                           }];
    
    
}


@end
