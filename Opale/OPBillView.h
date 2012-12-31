//
//  OPBillView.h
//  Opale
//
//  Created by Camille on 30/12/12.
//
//

#import "OPView.h"

@interface OPBillView : OPView{
    IBOutlet NSTextView* textView;
    
    NSString* initialString;
}

@property (nonatomic, retain) IBOutlet NSTextView* textView;
@property (nonatomic, retain) NSString* initialString;

-(void)setPrice:(NSString*)price andPayer:(NSString*)payer andPatient:(NSString*)patient andDate:(NSString*)date;

@end
