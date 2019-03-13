//
//  MediaCollectionCell.h
//  AppleiTunesMedia
//
//  Created by Umer Afzal on 13/03/2019.
//  Copyright © 2019 Umer Afzal. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MediaCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mediaImg;
@property (weak, nonatomic) IBOutlet UILabel *mediaName;

@end

NS_ASSUME_NONNULL_END
