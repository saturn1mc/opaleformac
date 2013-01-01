//
//  OPBillView.h
//  Opale
//
//  Created by Camille on 30/12/12.
//
//

#import "OPView.h"

@interface OPBillView : OPView{
    IBOutlet NSTextField* headerTextField;
    IBOutlet NSTextField* bodyTextField;
    
    NSString* initialHeaderStr;
    NSString* initialBodyStr;
}

@property (nonatomic, retain) IBOutlet NSTextField* headerTextField;
@property (nonatomic, retain) IBOutlet NSTextField* bodyTextField;
@property (nonatomic, retain) NSString* initialHeaderStr;
@property (nonatomic, retain) NSString* initialBodyStr;

-(void)setPrice:(NSString*)price andPayer:(NSString*)payer andPatient:(NSString*)patient andDate:(NSString*)date;

@end
