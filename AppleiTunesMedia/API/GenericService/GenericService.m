//
//  GenericService.m
//  AppleiTunesMedia
//
//  Created by Umer Afzal on 13/03/2019.
//  Copyright © 2019 Umer Afzal. All rights reserved.
//

#import "GenericService.h"

@implementation GenericService

-(void)callServiceWithURL:(NSString *)url requestType:(RequestType)requestType httpHeader:(NSDictionary *)httpHeader parameters:(NSDictionary *) parameters callWithControlerId : (id) callController withCompletionHandler:(void(^)(NSData* data, NSError* error))completionHandler
{
    
    
    if ([self connected]) {
        @try{
            if(url != nil){
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                
                manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
                
                if(httpHeader == nil){
                    httpHeader = [[NSMutableDictionary alloc] init];
                }
                
                //adding constant header
                
                for (id key in httpHeader)
                {
                    [manager.requestSerializer setValue:[httpHeader objectForKey:key]  forHTTPHeaderField:[NSString stringWithFormat:@"%@",key]];
                }
                if(requestType == GET){
                    
                    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                        // NSLog(@"JSON: %@", responseObject);
                        
                        //pass to your completion handler
                        if(completionHandler) {
                            completionHandler(responseObject, nil);
                        }
                        
                    } failure:^(NSURLSessionTask *operation, NSError *error) {
                        NSLog(@"Error: %@", error);
                        //pass to your completion handler
                        if(completionHandler) {
                            completionHandler(nil, error);
                        }
                    }];
                }else if(requestType == POST){
                    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                        //pass to your completion handler
                        if(completionHandler) {
                            completionHandler(responseObject, nil);
                        }
                        //return responseObject;
                    } failure:^(NSURLSessionTask *operation, NSError *error) {
                        NSLog(@"Error: %@", error);
                        //pass to your completion handler
                        if(completionHandler) {
                            completionHandler(nil, error);
                        }
                    }];
                    
                }
            }
            
        }@catch(NSException* exception){
            NSLog(@"%@",exception);
        }
        
    }else{
        NSLog(@"NO network found");
        //message no network
        
        NSError *error = nil;
        
        if(completionHandler) {
            completionHandler(nil, error);
        }
        
    }
    
    
}

-(BOOL)connected {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

@end
