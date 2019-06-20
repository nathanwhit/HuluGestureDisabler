@interface TVGuideViewController : UIViewController
- (UIView*)playerContainerView;
@end

@interface UIView (huluplayer)
- (void)setDeliversTouchesForGesturesToSuperview:(BOOL)arg;
@end

@interface UITapGestureRecognizer (hulu)
- (void)setMaximumTapDuration:(CGFloat)arg;
@end

@interface PlayerViewController : UIViewController
@end

%hook TVGuideViewController
- (void)viewDidLoad {
	%orig;
	[[self playerContainerView] setDeliversTouchesForGesturesToSuperview: NO];
}
%end

%hook PlayerViewController
- (void)viewDidLoad {
	%orig;
	for (UIGestureRecognizer *recognizer in [(UIView*)[self view] gestureRecognizers]) {
		if ([recognizer isMemberOfClass:[UITapGestureRecognizer class]]) {
			UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer*)recognizer;
			if (tapRecognizer.numberOfTapsRequired == 2) {
				[tapRecognizer setMaximumTapDuration:0.0];
			}
		}
	}
}
%end

%ctor {
	%init(TVGuideViewController = NSClassFromString(@"Hulu.TVGuideViewController"), PlayerViewController = NSClassFromString(@"Hulu.PlayerViewController"));
}