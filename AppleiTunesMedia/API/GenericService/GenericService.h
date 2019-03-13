//
//  GenericService.h
//  AppleiTunesMedia
//
//  Created by Umer Afzal on 13/03/2019.
//  Copyright © 2019 Umer Afzal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "SharedConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface GenericService : NSObject

-(void)callServiceWithURL:(NSString *)url requestType:(RequestType)requestType httpHeader:(NSDictionary *)httpHeader parameters:(NSDictionary *) parameters callWithControlerId : (id) callController withCompletionHandler:(void(^)(NSData* data, NSError* error))completionHandler;

@end

NS_ASSUME_NONNULL_END
