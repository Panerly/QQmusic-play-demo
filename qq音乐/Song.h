//
//  Song.h
//  qq音乐
//
//  Created by mac on 15/11/26.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Song : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *singer;
@property (nonatomic,assign)BOOL like;
@property (nonatomic,strong)UIImage *image;
@property (nonatomic,assign)NSInteger time;

-(instancetype)initWithName:(NSString *)name withSinger:(NSString *)singer withLike:(BOOL)islike withImage:(UIImage *)image withTime:(NSInteger)time;

@end
