

#import "HeaderView.h"

@implementation HeaderView
@synthesize backSelf,btn_menu,btn_write,bnt_menu_img;
- (void)drawRect:(CGRect)rect
{
    
    if (_blank_header == 3)
    {
        bnt_menu_img.hidden =  btn_write.hidden = btn_menu.hidden = YES;
    }
    if (_blank_header == 1)
    {
        [bnt_menu_img setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
        btn_write.hidden = YES;
    }
}


- (IBAction)tap_write:(id)sender {
    
}

- (IBAction)tap_menu:(id)sender
{
    if(_blank_header == 1)
    {
        [self.backSelf.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        MenuView *menuView = [[[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil] objectAtIndex:1];
        menuView.backgroundColor = CLEAR_COLOR;
        menuView.backSelf = self.backSelf;
        [self.backSelf.view addSubview:menuView];
        menuView.frame = CGRectMake(-WIDTH,0,WIDTH,HEIGHT);
    }
}


@end
