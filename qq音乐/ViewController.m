//
//  ViewController.m
//  qq音乐
//
//  Created by mac on 15/11/26.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    int _songNum;
    UIButton *_cover;
    UIImageView *_coverView;
    NSMutableArray *_songs;
    Song *_songNow;
    UIVisualEffectView *_topView;
    UILabel *_song;
    UILabel *_singer;
    UIButton *_back;
    UIButton *_like;
    UIButton *_dislike;
    UIVisualEffectView *_buttomView;
    UILabel *_rightSlider;
    UISlider *_slider;
    UIImageView *_leftSlider;
    UIImageView *_thumb;
    UILabel *_nowTime;
    UILabel *_totalTime;
    UIButton *_pause;
    UIButton *_play;
    UIButton *_pre;
    UIButton *_next;
    BOOL _playing;
}
@end

@implementation ViewController

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _songNum = 0;
    //创建封面
    _cover = [[UIButton alloc]initWithFrame:self.view.frame];
    _coverView = [[UIImageView alloc]initWithFrame:self.view.frame];
    
    UIImage *joy = [UIImage imageNamed:@"joy.jpg"];
    UIImage *eason = [UIImage imageNamed:@"chenyixun.jpg"];
    UIImage *lihong = [UIImage imageNamed:@"wanglihong.jpg"];
    UIImage *yanzi = [UIImage imageNamed:@"yanzi.jpg"];
    
    _songs = [NSMutableArray arrayWithObjects:[[Song alloc]initWithName:@"安静" withSinger:@"周杰伦" withLike:NO withImage:joy withTime:223],[[Song alloc]initWithName:@"孤独患者" withSinger:@"陈奕迅" withLike:NO withImage:eason withTime:250],[[Song alloc]initWithName:@"依然爱你" withSinger:@"王力宏" withLike:NO withImage:lihong withTime:294],[[Song alloc]initWithName:@"天黑黑" withSinger:@"孙燕姿" withLike:NO withImage:yanzi withTime:280], nil];
    _cover.tag = 100;
    _songNow = _songs[_songNum];
    _coverView.image = _songNow.image;
    [_cover addSubview:_coverView];
    [self.view addSubview:_cover];
    [_cover addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //顶端栏
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    _topView = [[UIVisualEffectView alloc]initWithEffect:blur];
    _topView.frame = CGRectMake(0, 0, self.view.frame.size.width, 80);
    [self.view addSubview:_topView];
    //歌曲名
    _song = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    _song.text = _songNow.name;
    _song.textColor = [UIColor whiteColor];
    _song.font = [UIFont systemFontOfSize:22];
    _song.textAlignment = NSTextAlignmentCenter;
    _song.center = CGPointMake(_topView.center.x,35);
    [_topView addSubview:_song];
    //歌手名
    _singer = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    _singer.text = _songNow.singer;
    _singer.textColor = [UIColor whiteColor];
    _singer.font = [UIFont systemFontOfSize:17];
    _singer.textAlignment = NSTextAlignmentCenter;
    _singer.center = CGPointMake(_topView.center.x,60);
    _singer.alpha = 0.9;
    [_topView addSubview:_singer];
    //返回按钮
    _back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35 , 35)];
    [_back setImage:[UIImage imageNamed:@"top_back_white@2x.png"] forState:UIControlStateNormal];
//    _back.alpha = 0.5;
    [_topView addSubview:_back];
    _back.center = CGPointMake(30, _topView.center.y + 8);
    //收藏按钮
    _like = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [_like setImage:[UIImage imageNamed:@"playing_btn_love@2x.png"] forState:UIControlStateNormal];
    [_topView addSubview:_like];
    _like.center = CGPointMake(_topView.frame.size.width - 30, _topView.center.y + 8);
    [_like addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _dislike = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [_dislike setImage:[UIImage imageNamed:@"playing_btn_in_myfavor@2x.png"] forState:UIControlStateNormal];
    _dislike.center = CGPointMake(_topView.frame.size.width - 30, _topView.center.y + 8);
    [_dislike addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _like.tag = 101;
    _dislike.tag = 102;
    
    //底端栏
    _buttomView = [[UIVisualEffectView alloc]initWithEffect:blur];
    _buttomView.frame = CGRectMake(0, self.view.frame.size.height - 130, self.view.frame.size.width, 130);
    [self.view addSubview:_buttomView];
    //白底播放进度条
//    _rightSlider = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _buttomView.frame.size.width, 2)];
//    _rightSlider.backgroundColor = [UIColor whiteColor];
//    _rightSlider.alpha = 0.8;
//    [_buttomView addSubview:_rightSlider];
    //总播放进度条按钮
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(0, -5, _buttomView.frame.size.width, 10)];
    [_buttomView addSubview:_slider];
    [_slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    
    _slider.maximumValue = 5*60+20;
//    _slider.backgroundColor =[UIColor whiteColor];
//    _slider.minimumValueImage = ;
    UIImage *left = [UIImage imageNamed:@"playing_slider_play_left@2x"];
    UIImage *right = [UIImage imageNamed:@"playing_slider_play_right@2x"];
    [_slider setMinimumTrackImage:left forState:UIControlStateNormal];
    [_slider setMaximumTrackImage:right forState:UIControlStateNormal];
    [_slider setThumbImage:[UIImage imageNamed:@"playing_slider_thumb@2x"] forState:UIControlStateNormal];
    
    [_slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    
    
    _slider.tag = 103;
    
    //左侧时间
    _nowTime = [[UILabel alloc]initWithFrame:CGRectMake(0, 6, 50, 30)];
    _nowTime.text = @"00:00";
    _nowTime.textColor = [UIColor whiteColor];
    _nowTime.font = [UIFont systemFontOfSize:14];
    _nowTime.alpha = 0.9;
    _nowTime.textAlignment = NSTextAlignmentCenter;
    [_buttomView addSubview:_nowTime];
    //右侧时间
    _totalTime = [[UILabel alloc]initWithFrame:CGRectMake(_buttomView.frame.size.width - 50, 6, 50, 30)];
    _totalTime.text = [NSString stringWithFormat:@"%02ld:%02ld",_songNow.time / 60,_songNow.time % 60];
    _totalTime.textColor = [UIColor whiteColor];
    _totalTime.font = [UIFont systemFontOfSize:14];
    _totalTime.alpha = 0.9;
    _totalTime.textAlignment = NSTextAlignmentCenter;
    [_buttomView addSubview:_totalTime];
    //暂停播放按键
    _pause = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 75, 75)];
    
    [_pause setImage:[UIImage imageNamed:@"playing_btn_pause_n@2x.png"] forState:UIControlStateNormal];
    [_buttomView addSubview:_pause];
    _pause.center = CGPointMake(_buttomView.center.x, _buttomView.frame.size.height/2);
    
    _play = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 75, 75)];
    [_play setImage:[UIImage imageNamed:@"playing_btn_play_n@2x.png"] forState:UIControlStateNormal];
    _play.center = CGPointMake(_buttomView.center.x, _buttomView.frame.size.height/2);
    _pause.tag = 104;
    _play.tag = 105;
    [_pause addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_play addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //上一曲下一曲
    _pre = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    _next = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];

    [_pre setImage:[UIImage imageNamed:@"playing_btn_pre_n@2x.png"] forState:UIControlStateNormal];
    [_next setImage:[UIImage imageNamed:@"playing_btn_next_n@2x.png"] forState:UIControlStateNormal];
    _pre.center = CGPointMake(_buttomView.center.x - 90, _buttomView.frame.size.height/2);
    _next.center = CGPointMake(_buttomView.center.x + 90, _buttomView.frame.size.height/2);
    [_buttomView addSubview:_pre];
    [_buttomView addSubview:_next];
    
    _pre.tag = 106;
    _next.tag = 107;
    
    [_pre addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_next addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _playing = YES;
    
    [self play];
    
}

-(void)buttonAction:(UIButton *)sender{
    
    if (sender.tag == 100) {
        if (_topView.frame.origin.y == 0) {
            [UIView animateWithDuration:1 animations:^{
                _topView.transform = CGAffineTransformTranslate(_topView.transform, 0, -80);
                _buttomView.transform = CGAffineTransformTranslate(_buttomView.transform, 0, 130);
            } completion:^(BOOL finished) {}
             ];
        }
        else{
            [UIView animateWithDuration:1 animations:^{
                _topView.transform = CGAffineTransformTranslate(_topView.transform, 0, 80);
                _buttomView.transform = CGAffineTransformTranslate(_buttomView.transform, 0, -130);
            } completion:^(BOOL finished) {}
             ];
        }
    }
    if (sender.tag == 101) {
        
        [_like removeFromSuperview];
        [_topView addSubview:_dislike];
        _songNow.like = YES;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"收藏成功" preferredStyle:UIAlertControllerStyleAlert];
        
        //    通过addAction来添加
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alert animated:YES completion:^{
        }];
    }
    if (sender.tag == 102) {
        
        [_dislike removeFromSuperview];
        [_topView addSubview:_like];
        _songNow.like = NO;
        
    }
    
    if (sender.tag == 104) {
        [_pause removeFromSuperview];
        [_buttomView addSubview:_play];
        _playing = NO;
    }
    
    if (sender.tag == 105) {
        [_play removeFromSuperview];
        [_buttomView addSubview:_pause];
        _playing = YES;
    }
    
    if (sender.tag == 106) {
        if (_songNum == 0) {
            _songNum = (int)_songs.count - 1;
        }
        else{
            _songNum--;
        }
        _songNow = _songs[_songNum];
        _coverView.image = _songNow.image;
        _song.text = _songNow.name;
        _singer.text = _songNow.singer;
        [_like removeFromSuperview];
        [_dislike removeFromSuperview];
        if (_songNow.like == YES) {
            [_topView addSubview:_dislike];
        }
        else{
            [_topView addSubview:_like];
        }
        _slider.maximumValue = _songNow.time;
        _slider.value = 0;
        [self sliderAction:NULL];
    }
    if (sender.tag == 107) {
        if (_songNum == (int)_songs.count - 1) {
            _songNum = 0;
        }
        else{
            _songNum++;
        }
        _songNow = _songs[_songNum];
        _coverView.image = _songNow.image;
        _song.text = _songNow.name;
        _singer.text = _songNow.singer;
        _totalTime.text = [NSString stringWithFormat:@"%02ld:%02ld",_songNow.time / 60,_songNow.time % 60];
        [_like removeFromSuperview];
        [_dislike removeFromSuperview];
        if (_songNow.like == YES) {
            [_topView addSubview:_dislike];
        }
        else{
            [_topView addSubview:_like];
        }
        _slider.maximumValue = _songNow.time;
        _slider.value = 0;
        [self sliderAction:NULL];
    }
    
}

-(void)sliderAction:(UISlider *)sender{
    _nowTime.text = [NSString stringWithFormat:@"%02d:%02d",(int)_slider.value/60,(int)_slider.value % 60];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)play{
    
    _slider.maximumValue = _songNow.time;
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(playMusic:) userInfo:nil repeats:YES];
}

- (void)playMusic:(NSTimer *)timer{
    
    if (_slider.value == _songNow.time) {
        [self buttonAction:_next];
    }
    
    if (_playing == YES) {
        _slider.value++;
        
    }
    _nowTime.text = [NSString stringWithFormat:@"%02d:%02d",(int)_slider.value/60,(int)_slider.value % 60];
    
}

@end
