//
//  OPCalendarView.h
//  Opale
//
//  Created by Camille on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "OPView.h"

@interface OPCalendarView : OPView{
    IBOutlet WebView* webView;
}

@property (nonatomic, retain) IBOutlet WebView* webView;

@end
