//
//  MediaTableCell.h
//  AppleiTunesMedia
//
//  Created by Umer Afzal on 13/03/2019.
//  Copyright © 2019 Umer Afzal. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MediaTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellContentView;
@property (weak, nonatomic) IBOutlet UILabel *mediaTypeLbl;
@property (weak, nonatomic) IBOutlet UICollectionView *mediaCollectionView;

@end

NS_ASSUME_NONNULL_END
