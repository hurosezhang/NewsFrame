//
//  ZYKViewController.m
//  网易新闻
//
//  Created by zhangyongkang on 2017/9/6.
//  Copyright © 2017年 JWHL.com. All rights reserved.
//

#import "ZYKViewController.h"
#import "ZYKSociaViewController.h"
#import "ZYKHomeLabel.h"

@interface ZYKViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@end

@implementation ZYKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setuPChildVC];
    [self setUptitle];
    
    // 显示第0个
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    
}

- (void)setuPChildVC
{
    ZYKSociaViewController *socia0 = [[ZYKSociaViewController alloc]init];
    socia0.title = @"国际";
    [self addChildViewController:socia0];
    
    
    ZYKSociaViewController *socia1 = [[ZYKSociaViewController alloc]init];
    socia1.title = @"军事";
    [self addChildViewController:socia1];
    
    ZYKSociaViewController *socia2 = [[ZYKSociaViewController alloc]init];
    socia2.title = @"体育";
    [self addChildViewController:socia2];
    
    
    ZYKSociaViewController *socia3 = [[ZYKSociaViewController alloc]init];
    socia3.title = @"政治";
    [self addChildViewController:socia3];
    ZYKSociaViewController *socia4 = [[ZYKSociaViewController alloc]init];
    socia4.title = @"经济";
    [self addChildViewController:socia4];
    
    
    ZYKSociaViewController *socia5 = [[ZYKSociaViewController alloc]init];
    socia5.title = @"拳击";
    [self addChildViewController:socia5];
    ZYKSociaViewController *socia6 = [[ZYKSociaViewController alloc]init];
    socia6.title = @"NBA";
    [self addChildViewController:socia6];
    
    
}

/**
 设置标题栏
 */
- (void)setUptitle{
    
    CGFloat LabelY = 0;
    CGFloat LabelWeight = 100;
    CGFloat LabelHeight = self.titleScrollView.bounds.size.height;

    for (int i = 0; i < 7 ; i ++ ) {
        
        
        CGFloat LabelX = i * LabelWeight;
        ZYKHomeLabel *label = [[ZYKHomeLabel alloc]init];
        
        
        label.text = self.childViewControllers[i].title;
        
      
        label.frame = CGRectMake(LabelX, LabelY, LabelWeight, LabelHeight);
        
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelClick:) ]];
        
        label.tag = i;
        [self.titleScrollView addSubview:label];
        
        
        // 设置contentSize

        self.titleScrollView.contentSize = CGSizeMake(LabelWeight * 7, 0);
        self.contentScrollView.contentSize = CGSizeMake(7 * [UIScreen mainScreen].bounds.size.width, 0);
        
         
    }
    
}
- (void)labelClick:(UIGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag;
    
    
    CGPoint offset = self.contentScrollView.contentOffset;
    
    offset.x = index * self.contentScrollView.bounds.size.width ;
    
    [self.contentScrollView setContentOffset:offset animated:YES];
    
}

/**
scrollView结束了滚动动画以后就会调用这个方法
 @param scrollView <#scrollView description#>
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    // 一些临时变量
    CGFloat width = scrollView.frame.size.width;
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    
    //对应的顶部标题居中显示
    ZYKHomeLabel *label = self.titleScrollView.subviews[index];
    CGPoint titleOffet = self.titleScrollView.contentOffset;
    titleOffet.x = label.center.x - width * 0.5 ;
    
    //左边超出处理
    if (titleOffet.x < 0) titleOffet.x = 0;
    
    CGFloat maxTitleOffetX = self.titleScrollView.contentSize.width - width;
    // 右边超出处理
    if (titleOffet.x > maxTitleOffetX) titleOffet.x = maxTitleOffetX;
    
    
    [self.titleScrollView setContentOffset:titleOffet animated:YES];
    
    // 让其他label 回到最初的状态（当滑动范围大时，会触发别的label的颜色变化）
    
    for (ZYKHomeLabel *otherLable in self.titleScrollView.subviews) {
        
        if (otherLable != label) otherLable.scale = 0.0;
        
    }
    
    // 取出需要显示的控制器
    ZYKSociaViewController *willshowVC = self.childViewControllers[index];

    // 如果当前位置的位置已经显示过了，就直接返回
    if ([willshowVC isViewLoaded]) return;
    
    
    
    willshowVC.view.frame = CGRectMake(scrollView.contentOffset.x, 0, scrollView.frame.size.width, scrollView.frame.size.height);
    
    [scrollView addSubview:willshowVC.view];
    
    
/**
 滚动减速的时候

 @return <#return value description#>
 */
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/**
 滚动的时候

 @param scrollView <#scrollView description#>
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 滑到最左边和最右边的时候，do nothing
    if (scale < 0 || scale > self.titleScrollView.subviews.count ) return;
    
    //左边label
    NSInteger leftIndex = scale;
    ZYKHomeLabel *leftlabel = self.titleScrollView.subviews[leftIndex];
    
    // 右边label
    CGFloat rightScale = scale - leftIndex;
    CGFloat leftScale  = 1 - rightScale;
    
    
    if (leftIndex == self.titleScrollView.subviews.count - 1) return;
    
    
    // 获取右边的按钮
    NSInteger rightIndex = leftIndex + 1;
    
    ZYKHomeLabel *rightLabel = (rightIndex == self.titleScrollView.subviews.count)? nil : self.titleScrollView.subviews[rightIndex];
    
    
    leftlabel.scale = leftScale;
    
    rightLabel.scale = rightScale;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
