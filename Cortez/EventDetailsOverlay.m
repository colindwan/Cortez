//
//  EventDetailsOverlay.m
//  Cortez
//
//  Created by COLIN DWAN on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventDetailsOverlay.h"
#import "GameEngine.h"
#import "MainStage.h"
#import "Event.h"

@implementation EventDetailsOverlay

+(CCScene *)scene
{
    // 'scene' is an autoreleas object
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object
    EventDetailsOverlay *layer = [EventDetailsOverlay node];
    
    // add layer as a child to scene
    [scene addChild:layer];
    
    // return the scene
    return scene;
}

- (id)initWithEvent:(Event *)pEvent
{
    if ((self=[super init])) {
        myEvent = pEvent;
        [self setupEventDetails];
    }
    return self;
}

- (void)dealloc
{
    [myEvent release];
    [super dealloc];
}

#pragma mark - Drawing

#pragma mark - Drawing

void ccFillPoly2( CGPoint *poli, int points, BOOL closePolygon )
{
    // Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
    // Needed states: GL_VERTEX_ARRAY,
    // Unneeded states: GL_TEXTURE_2D, GL_TEXTURE_COORD_ARRAY, GL_COLOR_ARRAY
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    glDisableClientState(GL_COLOR_ARRAY);
    
    glVertexPointer(2, GL_FLOAT, 0, poli);
    if( closePolygon )
        glDrawArrays(GL_TRIANGLE_FAN, 0, points);
    else
        glDrawArrays(GL_LINE_STRIP, 0, points);
    
    // restore default state
    glEnableClientState(GL_COLOR_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glEnable(GL_TEXTURE_2D);
}

-(void) draw
{
	CGSize s = [[CCDirector sharedDirector] winSize];
    
	// closed grey poly
	glColor4ub(0, 0, 0, 150);
	CGPoint vertices2[] = { ccp(s.width*0.05,s.height*0.05), ccp(s.width*0.05,s.height*0.95), 
                            ccp(s.width*0.95,s.height*0.95), ccp(s.width*0.95,s.height*0.05) };
    
    ccFillPoly2( vertices2, 4, YES);
}

#pragma mark - Event Details

- (void)setupEventDetails
{
    [self lockEventDetails];
    CGSize s = [[CCDirector sharedDirector] winSize];
     
    // Show core info
    CCLabelTTF *title = [CCLabelTTF labelWithString:[myEvent sEventName] fontName:@"Times New Roman" fontSize:24];
    title.position = ccp(s.width*0.50, s.height*0.85);
    
    CCLabelTTF *goal1 = [CCLabelTTF labelWithString:[myEvent sGoalName] fontName:@"Times New Roman" fontSize:18];
    goal1.position = ccp(s.width*0.25, s.height*0.60);
    
    // Show debug info
    CCLabelTTF *eventId = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", [myEvent iEventId]] fontName:@"Times New Roman" fontSize:14];
    eventId.position = ccp(s.width*0.50, s.height*0.75);
    
    CCLabelTTF *state = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", [myEvent iState]] fontName:@"Times New Roman" fontSize:14];
    state.position = ccp(s.width*0.50, s.height*0.70);
    
    CCLabelTTF *goalFlags = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", [myEvent iGoalFlags]] fontName:@"Times New Roman" fontSize:18];
    goalFlags.position = ccp(s.width*0.75, s.height*0.60);
    
    [self addChild:title z:2];
    [self addChild:goal1 z:2];
    [self addChild:eventId z:2];
    [self addChild:state z:2];
    [self addChild:goalFlags z:2];
    
    
    
    CCMenu *menu;
    CCMenuItemImage *menuItem = [CCMenuItemImage itemFromNormalImage:@"btn_exit.png" 
                                                       selectedImage:@"btn_exit_down.png" 
                                                              target:self 
                                                            selector:@selector(unlockEventDetails)];
    menu = [CCMenu menuWithItems:menuItem, nil];
    [menu setPosition:ccp(s.width*0.87, s.height*0.87)];
    [self addChild:menu z:2];
}

- (void)lockEventDetails
{
    if (!([[GameEngine sharedGameEngine] lockNode:self])) {
        NSLog(@"We tried to lock the event details on top of another one!");
        abort();
    }
}

- (void)unlockEventDetails
{
    [[GameEngine sharedGameEngine] unlockNode:self];
    [[self parent] removeChild:self cleanup:NO];
}

@end
