//
//  AppleMediaViewController.m
//  AppleiTunesMedia
//
//  Created by Umer Afzal on 13/03/2019.
//  Copyright © 2019 Umer Afzal. All rights reserved.
//

#import "AppleMediaViewController.h"
#import "MediaTableCell.h"
#import "MediaCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "GetAppleMediaService.h"



@interface AppleMediaViewController ()
{
    
}
@property(strong,nonatomic)GetAppleMediaService *getAppleMediaService;
@property(strong,nonatomic)NSMutableDictionary *appleMediaDic;
@property(strong,nonatomic)NSArray *mediaTypeArr;




@end

@implementation AppleMediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self performSelector:@selector(updateUI) withObject:nil afterDelay:2];
}

-(void)updateUI
{
    self.getAppleMediaService =  [[GetAppleMediaService alloc] init];
    self.appleMediaDic = [[NSMutableDictionary alloc]init];
    self.mediaTypeArr = @[@"Apple Music:",@"Movies",@"TV Shows",@"iTunes Music:",@"iOS Apps:"];

    
    [self.getAppleMediaService getAppleMediaDataService:APPLEMUSIC withCompletionHandler:^(NSDictionary * _Nonnull mediaDic, NSError * _Nonnull error) {
       
        if (mediaDic) {
            [self.appleMediaDic setObject:mediaDic forKey:APPLE_MUSIC];
            [self getMovies];
        }
       
        
    }];
}
-(void)getMovies
{
    [self.getAppleMediaService getAppleMediaDataService:MOVIES withCompletionHandler:^(NSDictionary * _Nonnull mediaDic, NSError * _Nonnull error) {
        if (mediaDic) {
            [self.appleMediaDic setObject:mediaDic forKey:MOIVE];
            [self getTvShows];
        }
        
    }];
}
-(void)getTvShows
{
    [self.getAppleMediaService getAppleMediaDataService:TVSHOWS withCompletionHandler:^(NSDictionary * _Nonnull mediaDic, NSError * _Nonnull error) {
        if (mediaDic) {
            [self.appleMediaDic setObject:mediaDic forKey:TVSHOW];
            [self getiTunesMusic];
            [self.mediaTblView reloadData];

        }
        
    }];
}

-(void)getiTunesMusic
{
    [self.getAppleMediaService getAppleMediaDataService:ITUNESMUSIC withCompletionHandler:^(NSDictionary * _Nonnull mediaDic, NSError * _Nonnull error) {
        if (mediaDic) {
            [self.appleMediaDic setObject:mediaDic forKey:ITUNES_MUSIC];
            [self getiOSApps];
        }
        
    }];
}

-(void)getiOSApps
{
    [self.getAppleMediaService getAppleMediaDataService:IOSAPP withCompletionHandler:^(NSDictionary * _Nonnull mediaDic, NSError * _Nonnull error)
    {
        
        if (mediaDic) {
            [self.appleMediaDic setObject:mediaDic forKey:IOS_APPS];
            [self.mediaTblView reloadData];
            
        }
        
    }];
}



#pragma mark - TableView Data Source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int numberOfRows = 0;
    numberOfRows = (int)[self.mediaTypeArr count];
    return numberOfRows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cellToReturn = nil;
    
    
    MediaTableCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"MediaTableCell"];
    
    if ( !cell ) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MediaTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
 
    if (self.appleMediaDic)
    {
        if (indexPath.row == 0) {
            [cell.mediaTypeLbl setText:[NSString stringWithFormat:@"%@ %@",[self.mediaTypeArr objectAtIndex:indexPath.row],[[self.appleMediaDic valueForKey:APPLE_MUSIC] valueForKey:@"title"]]];
        }
        else  if (indexPath.row == 1) {
            [cell.mediaTypeLbl setText:[NSString stringWithFormat:@"%@ %@",[self.mediaTypeArr objectAtIndex:indexPath.row],[[self.appleMediaDic valueForKey:MOIVE] valueForKey:@"title"]]];
        }
        else  if (indexPath.row == 2) {
            [cell.mediaTypeLbl setText:[NSString stringWithFormat:@"%@ %@",[self.mediaTypeArr objectAtIndex:indexPath.row],[[self.appleMediaDic valueForKey:TVSHOW] valueForKey:@"title"]]];
        }
        else  if (indexPath.row == 3) {
            [cell.mediaTypeLbl setText:[NSString stringWithFormat:@"%@ %@",[self.mediaTypeArr objectAtIndex:indexPath.row],[[self.appleMediaDic valueForKey:ITUNES_MUSIC] valueForKey:@"title"]]];
        }
        else if (indexPath.row == 4) {
            [cell.mediaTypeLbl setText:[NSString stringWithFormat:@"%@ %@",[self.mediaTypeArr objectAtIndex:indexPath.row],[[self.appleMediaDic valueForKey:IOS_APPS] valueForKey:@"title"]]];
        }
    }
    
    [cell.mediaCollectionView setTag:indexPath.row];
    [cell.mediaCollectionView reloadData];
    cellToReturn  = cell;
    return cellToReturn;
    
}


#pragma mark - UITableView Delegate

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:tableView.indexPathForSelectedRow animated:NO];
    
}



#pragma mark - CollectionView Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    int numberOfRows = 10;
    return numberOfRows;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (MediaCollectionCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MediaCollectionCell *cCell= [collectionView dequeueReusableCellWithReuseIdentifier:@"mediaCollectionCell" forIndexPath:indexPath];
    
    //Deal Cell
    
    if (!cCell) {
       
        cCell= [collectionView dequeueReusableCellWithReuseIdentifier:@"mediaCollectionCell" forIndexPath:indexPath];
    }
    
    NSString * nameMediaStr = @"";
    NSString * imgMediaUrlStr = @"";

    
    if (self.appleMediaDic)
    {
        if (collectionView.tag == 0) {
            
            nameMediaStr = [[[[self.appleMediaDic valueForKey:APPLE_MUSIC] valueForKey:@"results"] valueForKey:@"name"] objectAtIndex:indexPath.row];
            
            
            imgMediaUrlStr = [[[[self.appleMediaDic valueForKey:APPLE_MUSIC] valueForKey:@"results"] valueForKey:@"artworkUrl100"] objectAtIndex:indexPath.row];
            
            
        }
        if (collectionView.tag == 1) {
            
            nameMediaStr = [[[[self.appleMediaDic valueForKey:MOIVE] valueForKey:@"results"] valueForKey:@"name"] objectAtIndex:indexPath.row];
            
            
            imgMediaUrlStr = [[[[self.appleMediaDic valueForKey:MOIVE] valueForKey:@"results"] valueForKey:@"artworkUrl100"] objectAtIndex:indexPath.row];
            
            
        }
        if (collectionView.tag == 2) {
            
            nameMediaStr = [[[[self.appleMediaDic valueForKey:TVSHOW] valueForKey:@"results"] valueForKey:@"name"] objectAtIndex:indexPath.row];
            
            
            imgMediaUrlStr = [[[[self.appleMediaDic valueForKey:TVSHOW] valueForKey:@"results"] valueForKey:@"artworkUrl100"] objectAtIndex:indexPath.row];
            
            
        }
        
        else if (collectionView.tag == 3) {
            
            nameMediaStr = [[[[self.appleMediaDic valueForKey:ITUNES_MUSIC] valueForKey:@"results"] valueForKey:@"name"] objectAtIndex:indexPath.row];
            
            imgMediaUrlStr = [[[[self.appleMediaDic valueForKey:ITUNES_MUSIC] valueForKey:@"results"] valueForKey:@"artworkUrl100"] objectAtIndex:indexPath.row];
            
            
        }
        else if (collectionView.tag == 4) {
            
            nameMediaStr = [[[[self.appleMediaDic valueForKey:IOS_APPS] valueForKey:@"results"] valueForKey:@"name"] objectAtIndex:indexPath.row];
            
            imgMediaUrlStr = [[[[self.appleMediaDic valueForKey:IOS_APPS] valueForKey:@"results"] valueForKey:@"artworkUrl100"] objectAtIndex:indexPath.row];
            
            
        }
        
    }
    
    [cCell.mediaName setText:nameMediaStr];
    
    
    [UIView transitionWithView:cCell.mediaImg
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [cCell.mediaImg sd_setImageWithURL:[NSURL URLWithString:imgMediaUrlStr] placeholderImage:nil options:0];
                        
                    } completion:nil];
    
    
  
    CATransition *transition = [CATransition animation];
    transition.duration = 1.00;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.delegate = self;
    [cCell.layer addAnimation:transition forKey:nil];
    
    
    return cCell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.backgroundColor = [UIColor whiteColor]; // Default color
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView.tag == 1) {
        return CGSizeMake(143, 210);

    }
    
    return CGSizeMake(172, 210);
}

#pragma mark collection view cell paddings
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(8, 8, 8, 8); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

@end
