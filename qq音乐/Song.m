//
//  Song.m
//  qq音乐
//
//  Created by mac on 15/11/26.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "Song.h"

@implementation Song

-(instancetype)initWithName:(NSString *)name withSinger:(NSString *)singer withLike:(BOOL)like withImage:(UIImage *)image withTime:(NSInteger)time
{
    self = [super init];
    if (self) {
        _name = name;
        _singer = singer;
        _like = like;
        _image = image;
        _time = time;
    }
    return self;
}

@end
