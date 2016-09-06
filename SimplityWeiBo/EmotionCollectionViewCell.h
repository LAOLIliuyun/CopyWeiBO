//
//  EmotionCollectionViewCell.h
//  SimplityWeiBo
//
//  Created by Macx on 16/8/19.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^EmotionBlock)();


@interface EmotionCollectionViewCell : UICollectionViewCell

@property (nonatomic,copy)EmotionBlock emotionBlock;
@property (strong, nonatomic) IBOutlet UIButton *emotionButton;
@property (strong, nonatomic) IBOutlet UIImageView *emotionImageView;


- (IBAction)emotionButtonAction:(UIButton *)sender;

@end
