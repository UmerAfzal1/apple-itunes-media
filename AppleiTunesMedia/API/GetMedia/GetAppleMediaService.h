//
//  GetAppleMediaService.h
//  AppleiTunesMedia
//
//  Created by Umer Afzal on 13/03/2019.
//  Copyright © 2019 Umer Afzal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SharedConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface GetAppleMediaService : NSObject

-(void)getAppleMediaDataService:(MediaType)mediaType withCompletionHandler:(void(^)(NSDictionary* mediaDic, NSError* error))completionHandler;


@end

NS_ASSUME_NONNULL_END
