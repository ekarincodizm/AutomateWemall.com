*** Settings ***
# Suite Setup       Open Portal Main Page
# Suite Teardown    Close Browser
Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/Features/Portal_Main_Page_Mobile/keyword_mobile.robot
Resource          ${CURDIR}/../../Keyword/Features/Portal_Main_Page_Mobile/resource_mobile.robot

Test Setup   Start Test Case
# Test Tear Down   Close Browser
*** Keywords ***
Start Test Case
	keyword_mobile.Initialize Suite Variable    TestData

*** Test Cases ***
######################################################  portal/page1 ################################################################
TC_ITMWM_04238 Verify Mega Menu - “Register” is available
	[Tags]   TC_ITMWM_04238  Ready   Regression   Portal-Mobile   Sprint7   rebrand1
	Open Portal iTrueMart Mobile rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Login link For Test iTruemart Header rebrand    portal/page1

TC_ITMWM_04239 Verify Mega Menu - “Main Page” is available
	[Tags]   TC_ITMWM_04239  Ready    Portal-Mobile   Sprint7   rebrand1
	Open Portal iTrueMart Mobile rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Home link For Test iTruemart Header

TC_ITMWM_04240 Verify Mega Menu - Everyday Wow is available
	[Tags]   TC_ITMWM_04240   Ready   Regression   Portal-Mobile   Sprint7   rebrand1
	Open Portal iTrueMart Mobile rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_04241 Verify Mega Menu - Category is available
	[Tags]   TC_ITMWM_04241  Ready   Regression   Portal-Mobile   Sprint7   rebrand1
	Open Portal iTrueMart Mobile rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_04242 Verify Mega Menu - "Category" display follow PCMS config
# 	[Tags]   TC_ITMWM_04242  Ready   Regression   Portal-Mobile   Sprint7   Waitfortest   rebrand1
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    portal/page1
# 	Compare Mega Menu Category In WeMall Mobile Site with PCMS

TC_ITMWM_04244 Verify Tab Menu - Promotion is available
	[Tags]   TC_ITMWM_04244  Ready   Regression   Portal-Mobile   Sprint7   rebrand1
	Open Portal iTrueMart Mobile rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_04245 Verify Mega Menu - "Promotion" display follow PCMS config
# 	[Tags]   TC_ITMWM_04245  Ready   Regression   Portal-Mobile   Sprint7   rebrand1
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    portal/page1
# 	Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS

TC_ITMWM_04247 Verify Tab Menu - iTruemart is available
	[Tags]   TC_ITMWM_04247  Ready   Regression   Portal-Mobile   Sprint7   rebrand1
	Open Portal iTrueMart Mobile rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Itruemart link For Test iTruemart Header

TC_ITMWM_04248 Verify Tab Menu - Cart is available
	[Tags]   TC_ITMWM_04248  Ready   Regression   Portal-Mobile   Sprint7   rebrand1
	Login iTruemart And Go To Portal rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Cart link For Test iTruemart Header

TC_ITMWM_04249 Verify Tab Menu - Order Tracking is available
	[Tags]   TC_ITMWM_04249  Ready   Regression   Portal-Mobile   Sprint7   rebrand1
	Login iTruemart And Go To Portal rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_04250 Verify Tab Menu - Return Policy is available
	[Tags]   TC_ITMWM_04250  Ready   Regression   Portal-Mobile   Sprint7   rebrand1
	Open Portal iTrueMart Mobile rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Return Policy link For Test iTruemart Header

TC_ITMWM_04251 Verify Tab Menu - Shipment Policy is available
	[Tags]   TC_ITMWM_04251  Ready   Regression   Portal-Mobile   Sprint7   rebrand1
	Open Portal iTrueMart Mobile without resize rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_04252 Verify Tab Menu - Refund Policy is available
	[Tags]   TC_ITMWM_04252  Ready   Regression   Portal-Mobile   Sprint7   rebrand1
	Open Portal iTrueMart Mobile without resize rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_04253 Verify Tab Menu - Discount Code is available
	[Tags]   TC_ITMWM_04253  Ready   Regression    Portal-Mobile   Sprint7   rebrand1
	Open Portal iTrueMart Mobile without resize rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Discount Code link For Test iTruemart Header

TC_ITMWM_04254 Verify Tab Menu - Contact Us is available
	[Tags]   TC_ITMWM_04254  Ready   Regression   Portal-Mobile   Sprint7   rebrand1
	Open Portal iTrueMart Mobile without resize rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Contact Us link For Test iTruemart Header

TC_ITMWM_04255 Verify Tab Menu - Select THAI language is available
	[Tags]   TC_ITMWM_04255  Ready    Portal-Mobile   Sprint7   rebrand1
	Open Portal iTrueMart Mobile without resize rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Thai language For Test iTruemart Header rebrand    portal/page1

TC_ITMWM_04256 Verify Tab Menu - Select ENGLISH language is available
	[Tags]   TC_ITMWM_04256  Ready    Portal-Mobile   Sprint7   rebrand1
	Open Portal iTrueMart Mobile without resize rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify English language For Test iTruemart Header rebrand    portal/page1

TC_ITMWM_04257 Verify Search have auto suggestion when type keyword on Search field
	[Tags]  TC_ITMWM_04257   Portal-Mobile       Regression   Ready   Sprint7   rebrand1
    Open Portal iTrueMart Mobile rebrand    portal/page1
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_04258 Verify Search Function when not found item
	[Tags]  TC_ITMWM_04258   Portal-Mobile       Regression   Ready   Sprint7   rebrand1
    Open Portal iTrueMart Mobile rebrand    portal/page1
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_04259 Verify Cancle Button In Search Page
	[Tags]  TC_ITMWM_04259   Portal-Mobile       Regression   Ready   Sprint7   rebrand1
    Open Portal iTrueMart Mobile without resize rebrand    portal/page1
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    portal/page1

TC_ITMWM_04260 Verify WeMall icon Button
	[Tags]   TC_ITMWM_04260  Ready   Regression    Portal-Mobile   Sprint7   rebrand1
	Open Portal iTrueMart Mobile rebrand    portal/page1
	Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_04261 Verify Header shop cart Button
	[Tags]   TC_ITMWM_04261  Ready   Regression   Portal-Mobile   Sprint7   rebrand1
	Login iTruemart And Go To Portal rebrand    portal/page1
	Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header



################################ category/mobile-tablet-accessories-3713634511853.html #################################
TC_ITMWM_04262 Verify Mega Menu - “Register” is available
	[Tags]   TC_ITMWM_04262  Ready   Regression   Portal-Mobile   Sprint7   rebrand2
	Open Portal iTrueMart Mobile rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Login link For Test iTruemart Header rebrand    category/mobile-tablet-accessories-3713634511853.html

TC_ITMWM_04263 Verify Mega Menu - “Main Page” is available
	[Tags]   TC_ITMWM_04263  Ready    Portal-Mobile   Sprint7   rebrand2
	Open Portal iTrueMart Mobile rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Home link For Test iTruemart Header

TC_ITMWM_04264 Verify Mega Menu - Everyday Wow is available
	[Tags]   TC_ITMWM_04264  Ready   Regression   Portal-Mobile   Sprint7   rebrand2
	Open Portal iTrueMart Mobile rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_04265 Verify Mega Menu - Category is available
	[Tags]   TC_ITMWM_04265  Ready   Regression   Portal-Mobile   Sprint7   rebrand2
	Open Portal iTrueMart Mobile rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_04266 Verify Mega Menu - "Category" display follow PCMS config
# 	[Tags]   TC_ITMWM_04266  Ready   Regression   Portal-Mobile   Sprint7   Waitfortest   rebrand2
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    category/mobile-tablet-accessories-3713634511853.html
# 	Compare Mega Menu Category In WeMall Mobile Site with PCMS

TC_ITMWM_04268 Verify Tab Menu - Promotion is available
	[Tags]   TC_ITMWM_04268  Ready   Regression   Portal-Mobile   Sprint7   rebrand2
	Open Portal iTrueMart Mobile rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_04269 Verify Mega Menu - "Promotion" display follow PCMS config
# 	[Tags]   TC_ITMWM_04269  Ready   Regression   Portal-Mobile   Sprint7   rebrand2
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    category/mobile-tablet-accessories-3713634511853.html
# 	Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS

TC_ITMWM_04271 Verify Tab Menu - iTruemart is available
	[Tags]   TC_ITMWM_04271  Ready   Regression   Portal-Mobile   Sprint7   rebrand2
	Open Portal iTrueMart Mobile rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Itruemart link For Test iTruemart Header

TC_ITMWM_04272 Verify Tab Menu - Cart is available
	[Tags]   TC_ITMWM_04272  Ready   Regression   Portal-Mobile   Sprint7   rebrand2
	Login iTruemart And Go To Portal rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Cart link For Test iTruemart Header

TC_ITMWM_04273 Verify Tab Menu - Order Tracking is available
	[Tags]   TC_ITMWM_04273  Ready   Regression   Portal-Mobile   Sprint7   rebrand2
	Login iTruemart And Go To Portal rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_04274 Verify Tab Menu - Return Policy is available
	[Tags]   TC_ITMWM_04274  Ready   Regression   Portal-Mobile   Sprint7   rebrand2
	Open Portal iTrueMart Mobile rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Return Policy link For Test iTruemart Header

TC_ITMWM_04275 Verify Tab Menu - Shipment Policy is available
	[Tags]   TC_ITMWM_04275  Ready   Regression   Portal-Mobile   Sprint7   rebrand2
	Open Portal iTrueMart Mobile without resize rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_04276 Verify Tab Menu - Refund Policy is available
	[Tags]   TC_ITMWM_04276  Ready   Regression   Portal-Mobile   Sprint7   rebrand2
	Open Portal iTrueMart Mobile without resize rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_04277 Verify Tab Menu - Discount Code is available
	[Tags]   TC_ITMWM_04277  Ready   Regression    Portal-Mobile   Sprint7   rebrand2
	Open Portal iTrueMart Mobile without resize rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Discount Code link For Test iTruemart Header

TC_ITMWM_04278 Verify Tab Menu - Contact Us is available
	[Tags]   TC_ITMWM_04278  Ready   Regression   Portal-Mobile   Sprint7   rebrand2
	Open Portal iTrueMart Mobile without resize rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Contact Us link For Test iTruemart Header

TC_ITMWM_04279 Verify Tab Menu - Select THAI language is available
	[Tags]   TC_ITMWM_04279  Ready    Portal-Mobile   Sprint7   rebrand2
	Open Portal iTrueMart Mobile without resize rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Thai language For Test iTruemart Header rebrand    category/mobile-tablet-accessories-3713634511853.html

TC_ITMWM_04280 Verify Tab Menu - Select ENGLISH language is available
	[Tags]   TC_ITMWM_04280  Ready    Portal-Mobile   Sprint7   rebrand2
	Open Portal iTrueMart Mobile without resize rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify English language For Test iTruemart Header rebrand    category/mobile-tablet-accessories-3713634511853.html

TC_ITMWM_04281 Verify Search have auto suggestion when type keyword on Search field
	[Tags]  TC_ITMWM_04281   Portal-Mobile       Regression   Ready   Sprint7   rebrand2
    Open Portal iTrueMart Mobile rebrand    category/mobile-tablet-accessories-3713634511853.html
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_04282 Verify Search Function when not found item
	[Tags]  TC_ITMWM_04282   Portal-Mobile       Regression   Ready   Sprint7   rebrand2
    Open Portal iTrueMart Mobile rebrand    category/mobile-tablet-accessories-3713634511853.html
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_04283 Verify Cancle Button In Search Page
	[Tags]  TC_ITMWM_04283   Portal-Mobile       Regression   Ready   Sprint7   rebrand2
    Open Portal iTrueMart Mobile without resize rebrand    category/mobile-tablet-accessories-3713634511853.html
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    category/mobile-tablet-accessories-3713634511853.html

TC_ITMWM_04284 Verify WeMall icon Button
	[Tags]   TC_ITMWM_04284  Ready   Regression    Portal-Mobile   Sprint7   rebrand2
	Open Portal iTrueMart Mobile rebrand    category/mobile-tablet-accessories-3713634511853.html
	Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_04285 Verify Header shop cart Button
	[Tags]   TC_ITMWM_04285  Ready   Regression   Portal-Mobile   Sprint7   rebrand2
	Login iTruemart And Go To Portal rebrand    category/mobile-tablet-accessories-3713634511853.html
	Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header







################################################ search2?q=iphone ######################################################
TC_ITMWM_04286 Verify Mega Menu - “Register” is available
	[Tags]   TC_ITMWM_04286  Ready   Regression   Portal-Mobile   Sprint7   rebrand3
	Open Portal iTrueMart Mobile rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Login link For Test iTruemart Header rebrand    search2?q=iphone

TC_ITMWM_04287 Verify Mega Menu - “Main Page” is available
	[Tags]   TC_ITMWM_04287  Ready    Portal-Mobile   Sprint7   rebrand3
	Open Portal iTrueMart Mobile rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Home link For Test iTruemart Header

TC_ITMWM_04288 Verify Mega Menu - Everyday Wow is available
	[Tags]   TC_ITMWM_04288  Ready   Regression   Portal-Mobile   Sprint7   rebrand3
	Open Portal iTrueMart Mobile rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_04289 Verify Mega Menu - Category is available
	[Tags]   TC_ITMWM_04289  Ready   Regression   Portal-Mobile   Sprint7   rebrand3
	Open Portal iTrueMart Mobile rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_04290 Verify Mega Menu - "Category" display follow PCMS config
# 	[Tags]   TC_ITMWM_04290  Ready   Regression   Portal-Mobile   Sprint7   Waitfortest   rebrand3
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    search2?q=iphone
# 	Compare Mega Menu Category In WeMall Mobile Site with PCMS

TC_ITMWM_04292 Verify Tab Menu - Promotion is available
	[Tags]   TC_ITMWM_04292  Ready   Regression   Portal-Mobile   Sprint7   rebrand3
	Open Portal iTrueMart Mobile rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_04293 Verify Mega Menu - "Promotion" display follow PCMS config
# 	[Tags]   TC_ITMWM_04293  Ready   Regression   Portal-Mobile   Sprint7   rebrand3
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    search2?q=iphone
# 	Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS

TC_ITMWM_04295 Verify Tab Menu - iTruemart is available
	[Tags]   TC_ITMWM_04295  Ready   Regression   Portal-Mobile   Sprint7   rebrand3
	Open Portal iTrueMart Mobile rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Itruemart link For Test iTruemart Header

TC_ITMWM_04296 Verify Tab Menu - Cart is available
	[Tags]   TC_ITMWM_04296  Ready   Regression   Portal-Mobile   Sprint7   rebrand3
	Login iTruemart And Go To Portal rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Cart link For Test iTruemart Header

TC_ITMWM_04297 Verify Tab Menu - Order Tracking is available
	[Tags]   TC_ITMWM_04297  Ready   Regression   Portal-Mobile   Sprint7   rebrand3
	Login iTruemart And Go To Portal rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_04298 Verify Tab Menu - Return Policy is available
	[Tags]   TC_ITMWM_04298  Ready   Regression   Portal-Mobile   Sprint7   rebrand3
	Open Portal iTrueMart Mobile rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Return Policy link For Test iTruemart Header

TC_ITMWM_04299 Verify Tab Menu - Shipment Policy is available
	[Tags]   TC_ITMWM_04299  Ready   Regression   Portal-Mobile   Sprint7   rebrand3
	Open Portal iTrueMart Mobile without resize rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_04300 Verify Tab Menu - Refund Policy is available
	[Tags]   TC_ITMWM_04300  Ready   Regression   Portal-Mobile   Sprint7   rebrand3
	Open Portal iTrueMart Mobile without resize rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_04301 Verify Tab Menu - Discount Code is available
	[Tags]   TC_ITMWM_04301  Ready   Regression    Portal-Mobile   Sprint7   rebrand3
	Open Portal iTrueMart Mobile without resize rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Discount Code link For Test iTruemart Header

TC_ITMWM_04302 Verify Tab Menu - Contact Us is available
	[Tags]   TC_ITMWM_04302  Ready   Regression   Portal-Mobile   Sprint7   rebrand3
	Open Portal iTrueMart Mobile without resize rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Contact Us link For Test iTruemart Header

TC_ITMWM_04303 Verify Tab Menu - Select THAI language is available
	[Tags]   TC_ITMWM_04303  Ready    Portal-Mobile   Sprint7   rebrand3
	Open Portal iTrueMart Mobile without resize rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Thai language For Test iTruemart Header rebrand    search2?q=iphone

TC_ITMWM_04304 Verify Tab Menu - Select ENGLISH language is available
	[Tags]   TC_ITMWM_04304  Ready    Portal-Mobile   Sprint7   rebrand3
	Open Portal iTrueMart Mobile without resize rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify English language For Test iTruemart Header rebrand    search2?q=iphone

TC_ITMWM_04305 Verify Search have auto suggestion when type keyword on Search field
	[Tags]  TC_ITMWM_04305   Portal-Mobile       Regression   Ready   Sprint7   rebrand3
    Open Portal iTrueMart Mobile rebrand    search2?q=iphone
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_04306 Verify Search Function when not found item
	[Tags]  TC_ITMWM_04306   Portal-Mobile       Regression   Ready   Sprint7   rebrand3
    Open Portal iTrueMart Mobile rebrand    search2?q=iphone
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_04307 Verify Cancle Button In Search Page
	[Tags]  TC_ITMWM_04307   Portal-Mobile       Regression   Ready   Sprint7   rebrand3
    Open Portal iTrueMart Mobile without resize rebrand    search2?q=iphone
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    search2?q=iphone

TC_ITMWM_04308 Verify WeMall icon Button
	[Tags]   TC_ITMWM_04308  Ready   Regression    Portal-Mobile   Sprint7   rebrand3
	Open Portal iTrueMart Mobile rebrand    search2?q=iphone
	Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_04309 Verify Header shop cart Button
	[Tags]   TC_ITMWM_04309  Ready   Regression   Portal-Mobile   Sprint7   rebrand3
	Login iTruemart And Go To Portal rebrand    search2?q=iphone
	Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header




#################################################### everyday-wow ######################################################
TC_ITMWM_04310 Verify Mega Menu - “Register” is available
	[Tags]   TC_ITMWM_04310  Ready   Regression   Portal-Mobile   Sprint7   rebrand4
	Open Portal iTrueMart Mobile rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Login link For Test iTruemart Header rebrand    everyday-wow

TC_ITMWM_04311 Verify Mega Menu - “Main Page” is available
	[Tags]   TC_ITMWM_04311  Ready    Portal-Mobile   Sprint7   rebrand4
	Open Portal iTrueMart Mobile rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Home link For Test iTruemart Header

TC_ITMWM_04312 Verify Mega Menu - Everyday Wow is available
	[Tags]   TC_ITMWM_04312  Ready   Regression   Portal-Mobile   Sprint7   rebrand4
	Open Portal iTrueMart Mobile rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_04313 Verify Mega Menu - Category is available
	[Tags]   TC_ITMWM_04313  Ready   Regression   Portal-Mobile   Sprint7   rebrand4
	Open Portal iTrueMart Mobile rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_04314 Verify Mega Menu - "Category" display follow PCMS config
# 	[Tags]   TC_ITMWM_04314  Ready   Regression   Portal-Mobile   Sprint7   Waitfortest   rebrand4
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    everyday-wow
# 	Compare Mega Menu Category In WeMall Mobile Site with PCMS

TC_ITMWM_04316 Verify Tab Menu - Promotion is available
	[Tags]   TC_ITMWM_04316  Ready   Regression   Portal-Mobile   Sprint7   rebrand4
	Open Portal iTrueMart Mobile rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_04317 Verify Mega Menu - "Promotion" display follow PCMS config
# 	[Tags]   TC_ITMWM_04317  Ready   Regression   Portal-Mobile   Sprint7   rebrand4
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    everyday-wow
# 	Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS

TC_ITMWM_04319 Verify Tab Menu - iTruemart is available
	[Tags]   TC_ITMWM_04319  Ready   Regression   Portal-Mobile   Sprint7   rebrand4
	Open Portal iTrueMart Mobile rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Itruemart link For Test iTruemart Header

TC_ITMWM_04320 Verify Tab Menu - Cart is available
	[Tags]   TC_ITMWM_04320  Ready   Regression   Portal-Mobile   Sprint7   rebrand4
	Login iTruemart And Go To Portal rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Cart link For Test iTruemart Header

TC_ITMWM_04321 Verify Tab Menu - Order Tracking is available
	[Tags]   TC_ITMWM_04321  Ready   Regression   Portal-Mobile   Sprint7   rebrand4
	Login iTruemart And Go To Portal rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_04322 Verify Tab Menu - Return Policy is available
	[Tags]   TC_ITMWM_04322  Ready   Regression   Portal-Mobile   Sprint7   rebrand4
	Open Portal iTrueMart Mobile rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Return Policy link For Test iTruemart Header

TC_ITMWM_04323 Verify Tab Menu - Shipment Policy is available
	[Tags]   TC_ITMWM_04323  Ready   Regression   Portal-Mobile   Sprint7   rebrand4
	Open Portal iTrueMart Mobile without resize rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_04324 Verify Tab Menu - Refund Policy is available
	[Tags]   TC_ITMWM_04324  Ready   Regression   Portal-Mobile   Sprint7   rebrand4
	Open Portal iTrueMart Mobile without resize rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_04325 Verify Tab Menu - Discount Code is available
	[Tags]   TC_ITMWM_04325  Ready   Regression    Portal-Mobile   Sprint7   rebrand4
	Open Portal iTrueMart Mobile without resize rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Discount Code link For Test iTruemart Header

TC_ITMWM_04326 Verify Tab Menu - Contact Us is available
	[Tags]   TC_ITMWM_04326  Ready   Regression   Portal-Mobile   Sprint7   rebrand4
	Open Portal iTrueMart Mobile without resize rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Contact Us link For Test iTruemart Header

TC_ITMWM_04327 Verify Tab Menu - Select THAI language is available
	[Tags]   TC_ITMWM_04327  Ready    Portal-Mobile   Sprint7   rebrand4
	Open Portal iTrueMart Mobile without resize rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Thai language For Test iTruemart Header rebrand    everyday-wow

TC_ITMWM_04328 Verify Tab Menu - Select ENGLISH language is available
	[Tags]   TC_ITMWM_04328  Ready    Portal-Mobile   Sprint7   rebrand4
	Open Portal iTrueMart Mobile without resize rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify English language For Test iTruemart Header rebrand    everyday-wow

TC_ITMWM_04329 Verify Search have auto suggestion when type keyword on Search field
	[Tags]  TC_ITMWM_04329   Portal-Mobile       Regression   Ready   Sprint7   rebrand4
    Open Portal iTrueMart Mobile rebrand    everyday-wow
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_04330 Verify Search Function when not found item
	[Tags]  TC_ITMWM_04330   Portal-Mobile       Regression   Ready   Sprint7   rebrand4
    Open Portal iTrueMart Mobile rebrand    everyday-wow
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_04331 Verify Cancle Button In Search Page
	[Tags]  TC_ITMWM_04331   Portal-Mobile       Regression   Ready   Sprint7   rebrand4
    Open Portal iTrueMart Mobile without resize rebrand    everyday-wow
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    everyday-wow

TC_ITMWM_04332 Verify WeMall icon Button
	[Tags]   TC_ITMWM_04332  Ready   Regression    Portal-Mobile   Sprint7   rebrand4
	Open Portal iTrueMart Mobile rebrand    everyday-wow
	Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_04333 Verify Header shop cart Button
	[Tags]   TC_ITMWM_04333  Ready   Regression   Portal-Mobile   Sprint7   rebrand4
	Login iTruemart And Go To Portal rebrand    everyday-wow
	Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header


########################################## brand/samsung-6931849325692.html ############################################
TC_ITMWM_04334 Verify Mega Menu - “Register” is available
	[Tags]   TC_ITMWM_04334  Ready   Regression   Portal-Mobile   Sprint7   rebrand5
	Open Portal iTrueMart Mobile rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Login link For Test iTruemart Header rebrand    brand/samsung-6931849325692.html

TC_ITMWM_04335 Verify Mega Menu - “Main Page” is available
	[Tags]   TC_ITMWM_04335  Ready    Portal-Mobile   Sprint7   rebrand5
	Open Portal iTrueMart Mobile rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Home link For Test iTruemart Header

TC_ITMWM_04336 Verify Mega Menu - Everyday Wow is available
	[Tags]   TC_ITMWM_04336  Ready   Regression   Portal-Mobile   Sprint7   rebrand5
	Open Portal iTrueMart Mobile rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_04337 Verify Mega Menu - Category is available
	[Tags]   TC_ITMWM_04337  Ready   Regression   Portal-Mobile   Sprint7   rebrand5
	Open Portal iTrueMart Mobile rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_04338 Verify Mega Menu - "Category" display follow PCMS config
# 	[Tags]   TC_ITMWM_04338  Ready   Regression   Portal-Mobile   Sprint7   Waitfortest   rebrand5
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    brand/samsung-6931849325692.html
# 	Compare Mega Menu Category In WeMall Mobile Site with PCMS

TC_ITMWM_04340 Verify Tab Menu - Promotion is available
	[Tags]   TC_ITMWM_04340  Ready   Regression   Portal-Mobile   Sprint7   rebrand5
	Open Portal iTrueMart Mobile rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_04341 Verify Mega Menu - "Promotion" display follow PCMS config
# 	[Tags]   TC_ITMWM_04341  Ready   Regression   Portal-Mobile   Sprint7   rebrand5
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    brand/samsung-6931849325692.html
# 	Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS

TC_ITMWM_04343 Verify Tab Menu - iTruemart is available
	[Tags]   TC_ITMWM_04343  Ready   Regression   Portal-Mobile   Sprint7   rebrand5
	Open Portal iTrueMart Mobile rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Itruemart link For Test iTruemart Header

TC_ITMWM_04344 Verify Tab Menu - Cart is available
	[Tags]   TC_ITMWM_04344  Ready   Regression   Portal-Mobile   Sprint7   rebrand5
	Login iTruemart And Go To Portal rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Cart link For Test iTruemart Header

TC_ITMWM_04345 Verify Tab Menu - Order Tracking is available
	[Tags]   TC_ITMWM_04345  Ready   Regression   Portal-Mobile   Sprint7   rebrand5
	Login iTruemart And Go To Portal rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_04346 Verify Tab Menu - Return Policy is available
	[Tags]   TC_ITMWM_04346  Ready   Regression   Portal-Mobile   Sprint7   rebrand5
	Open Portal iTrueMart Mobile rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Return Policy link For Test iTruemart Header

TC_ITMWM_04347 Verify Tab Menu - Shipment Policy is available
	[Tags]   TC_ITMWM_04347  Ready   Regression   Portal-Mobile   Sprint7   rebrand5
	Open Portal iTrueMart Mobile without resize rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_04348 Verify Tab Menu - Refund Policy is available
	[Tags]   TC_ITMWM_04348  Ready   Regression   Portal-Mobile   Sprint7   rebrand5
	Open Portal iTrueMart Mobile without resize rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_04349 Verify Tab Menu - Discount Code is available
	[Tags]   TC_ITMWM_04349  Ready   Regression    Portal-Mobile   Sprint7   rebrand5
	Open Portal iTrueMart Mobile without resize rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Discount Code link For Test iTruemart Header

TC_ITMWM_04350 Verify Tab Menu - Contact Us is available
	[Tags]   TC_ITMWM_04350  Ready   Regression   Portal-Mobile   Sprint7   rebrand5
	Open Portal iTrueMart Mobile without resize rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Contact Us link For Test iTruemart Header

TC_ITMWM_04351 Verify Tab Menu - Select THAI language is available
	[Tags]   TC_ITMWM_04351  Ready    Portal-Mobile   Sprint7   rebrand5
	Open Portal iTrueMart Mobile without resize rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Thai language For Test iTruemart Header rebrand    brand/samsung-6931849325692.html

TC_ITMWM_04352 Verify Tab Menu - Select ENGLISH language is available
	[Tags]   TC_ITMWM_04352  Ready    Portal-Mobile   Sprint7   rebrand5
	Open Portal iTrueMart Mobile without resize rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify English language For Test iTruemart Header rebrand    brand/samsung-6931849325692.html

TC_ITMWM_04353 Verify Search have auto suggestion when type keyword on Search field
	[Tags]  TC_ITMWM_04353   Portal-Mobile       Regression   Ready   Sprint7   rebrand5
    Open Portal iTrueMart Mobile rebrand    brand/samsung-6931849325692.html
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_04354 Verify Search Function when not found item
	[Tags]  TC_ITMWM_04354   Portal-Mobile       Regression   Ready   Sprint7   rebrand5
    Open Portal iTrueMart Mobile rebrand    brand/samsung-6931849325692.html
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_04355 Verify Cancle Button In Search Page
	[Tags]  TC_ITMWM_04355   Portal-Mobile       Regression   Ready   Sprint7   rebrand5
    Open Portal iTrueMart Mobile without resize rebrand    brand/samsung-6931849325692.html
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    brand/samsung-6931849325692.html

TC_ITMWM_04356 Verify WeMall icon Button
	[Tags]   TC_ITMWM_04356  Ready   Regression    Portal-Mobile   Sprint7   rebrand5
	Open Portal iTrueMart Mobile rebrand    brand/samsung-6931849325692.html
	Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_04357 Verify Header shop cart Button
	[Tags]   TC_ITMWM_04357  Ready   Regression   Portal-Mobile   Sprint7   rebrand5
	Login iTruemart And Go To Portal rebrand    brand/samsung-6931849325692.html
	Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header



####################################################### cart ###########################################################
TC_ITMWM_04358 Verify Mega Menu - “Register” is available
	[Tags]   TC_ITMWM_04358  Ready   Regression   Portal-Mobile   Sprint7   rebrand6
	Open Portal iTrueMart Mobile rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Login link For Test iTruemart Header rebrand    cart

TC_ITMWM_04359 Verify Mega Menu - “Main Page” is available
	[Tags]   TC_ITMWM_04359  Ready    Portal-Mobile   Sprint7   rebrand6
	Open Portal iTrueMart Mobile rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Home link For Test iTruemart Header

TC_ITMWM_04360 Verify Mega Menu - Everyday Wow is available
	[Tags]   TC_ITMWM_04360  Ready   Regression   Portal-Mobile   Sprint7   rebrand6
	Open Portal iTrueMart Mobile rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_04361 Verify Mega Menu - Category is available
	[Tags]   TC_ITMWM_04361  Ready   Regression   Portal-Mobile   Sprint7   rebrand6
	Open Portal iTrueMart Mobile rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_04362 Verify Mega Menu - "Category" display follow PCMS config
# 	[Tags]   TC_ITMWM_04362  Ready   Regression   Portal-Mobile   Sprint7   Waitfortest   rebrand6
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    cart
# 	Compare Mega Menu Category In WeMall Mobile Site with PCMS


TC_ITMWM_04364 Verify Tab Menu - Promotion is available
	[Tags]   TC_ITMWM_04364  Ready   Regression   Portal-Mobile   Sprint7   rebrand6
	Open Portal iTrueMart Mobile rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_04365 Verify Mega Menu - "Promotion" display follow PCMS config
# 	[Tags]   TC_ITMWM_04365  Ready   Regression   Portal-Mobile   Sprint7   rebrand6
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    cart
# 	Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS



TC_ITMWM_04367 Verify Tab Menu - iTruemart is available
	[Tags]   TC_ITMWM_04367  Ready   Regression   Portal-Mobile   Sprint7   rebrand6
	Open Portal iTrueMart Mobile rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Itruemart link For Test iTruemart Header

TC_ITMWM_04368 Verify Tab Menu - Cart is available
	[Tags]   TC_ITMWM_04368  Ready   Regression   Portal-Mobile   Sprint7   rebrand6
	Login iTruemart And Go To Portal rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Cart link For Test iTruemart Header

TC_ITMWM_04369 Verify Tab Menu - Order Tracking is available
	[Tags]   TC_ITMWM_04369  Ready   Regression   Portal-Mobile   Sprint7   rebrand6
	Login iTruemart And Go To Portal rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_04370 Verify Tab Menu - Return Policy is available
	[Tags]   TC_ITMWM_04370  Ready   Regression   Portal-Mobile   Sprint7   rebrand6
	Open Portal iTrueMart Mobile rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Return Policy link For Test iTruemart Header

TC_ITMWM_04371 Verify Tab Menu - Shipment Policy is available
	[Tags]   TC_ITMWM_04371  Ready   Regression   Portal-Mobile   Sprint7   rebrand6
	Open Portal iTrueMart Mobile without resize rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_04372 Verify Tab Menu - Refund Policy is available
	[Tags]   TC_ITMWM_04372  Ready   Regression   Portal-Mobile   Sprint7   rebrand6
	Open Portal iTrueMart Mobile without resize rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_04373 Verify Tab Menu - Discount Code is available
	[Tags]   TC_ITMWM_04373  Ready   Regression    Portal-Mobile   Sprint7   rebrand6
	Open Portal iTrueMart Mobile without resize rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Discount Code link For Test iTruemart Header

TC_ITMWM_04374 Verify Tab Menu - Contact Us is available
	[Tags]   TC_ITMWM_04374  Ready   Regression   Portal-Mobile   Sprint7   rebrand6
	Open Portal iTrueMart Mobile without resize rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Contact Us link For Test iTruemart Header

TC_ITMWM_04375 Verify Tab Menu - Select THAI language is available
	[Tags]   TC_ITMWM_04375  Ready    Portal-Mobile   Sprint7   rebrand6
	Open Portal iTrueMart Mobile without resize rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Thai language For Test iTruemart Header rebrand    cart

TC_ITMWM_04376 Verify Tab Menu - Select ENGLISH language is available
	[Tags]   TC_ITMWM_04376  Ready    Portal-Mobile   Sprint7   rebrand6
	Open Portal iTrueMart Mobile without resize rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify English language For Test iTruemart Header rebrand    cart

TC_ITMWM_04377 Verify Search have auto suggestion when type keyword on Search field
	[Tags]   TC_ITMWM_04377   Portal-Mobile       Regression   Ready   Sprint7   rebrand6
    Open Portal iTrueMart Mobile rebrand    cart
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_04378 Verify Search Function when not found item
	[Tags]  TC_ITMWM_04378   Portal-Mobile       Regression   Ready   Sprint7   rebrand6
    Open Portal iTrueMart Mobile rebrand    cart
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_04379 Verify Cancle Button In Search Page
	[Tags]  TC_ITMWM_04379   Portal-Mobile       Regression   Ready   Sprint7   rebrand6
    Open Portal iTrueMart Mobile without resize rebrand    cart
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    cart

TC_ITMWM_04380 Verify WeMall icon Button
	[Tags]   TC_ITMWM_04380  Ready   Regression    Portal-Mobile   Sprint7   rebrand6
	Open Portal iTrueMart Mobile rebrand    cart
	Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_04381 Verify Header shop cart Button
	[Tags]   TC_ITMWM_04381  Ready   Regression   Portal-Mobile   Sprint7   rebrand6
	Login iTruemart And Go To Portal rebrand    cart
	Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header

############################## auth/login?continue=${WEMALL_MOBILE}/cart ###############################
TC_ITMWM_04382 Verify Mega Menu - “Register” is available
	[Tags]   TC_ITMWM_04382  Ready   Regression   Portal-Mobile   Sprint7   rebrand7
	Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Login link For Test iTruemart Header rebrand incase auth/login    auth/login?continue=${WEMALL_MOBILE}/cart

TC_ITMWM_04383 Verify Mega Menu - “Main Page” is available
	[Tags]   TC_ITMWM_04383  Ready    Portal-Mobile   Sprint7   rebrand7
	Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Home link For Test iTruemart Header

TC_ITMWM_04384 Verify Mega Menu - Everyday Wow is available
	[Tags]   TC_ITMWM_04384  Ready   Regression   Portal-Mobile   Sprint7   rebrand7
	Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_04385 Verify Mega Menu - Category is available
	[Tags]   TC_ITMWM_04385  Ready   Regression   Portal-Mobile   Sprint7   rebrand7
	Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_04386 Verify Mega Menu - "Category" display follow PCMS config
# 	[Tags]   TC_ITMWM_04386  Ready   Regression   Portal-Mobile   Sprint7   Waitfortest   rebrand7
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
# 	Compare Mega Menu Category In WeMall Mobile Site with PCMS

TC_ITMWM_04388 Verify Tab Menu - Promotion is available
	[Tags]   TC_ITMWM_04388  Ready   Regression   Portal-Mobile   Sprint7   rebrand7
	Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_04389 Verify Mega Menu - "Promotion" display follow PCMS config
# 	[Tags]   TC_ITMWM_04389  Ready   Regression   Portal-Mobile   Sprint7   rebrand7
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
# 	Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS

TC_ITMWM_04391 Verify Tab Menu - iTruemart is available
	[Tags]   TC_ITMWM_04391  Ready   Regression   Portal-Mobile   Sprint7   rebrand7
	Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Itruemart link For Test iTruemart Header

TC_ITMWM_04392 Verify Tab Menu - Cart is available
	[Tags]   TC_ITMWM_04392  Ready   Regression   Portal-Mobile   Sprint7   rebrand7
	Login iTruemart And Go To Portal rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Cart link For Test iTruemart Header

TC_ITMWM_04393 Verify Tab Menu - Order Tracking is available
	[Tags]   TC_ITMWM_04393  Ready   Regression   Portal-Mobile   Sprint7   rebrand7
	Login iTruemart And Go To Portal rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_04394 Verify Tab Menu - Return Policy is available
	[Tags]   TC_ITMWM_04394  Ready   Regression   Portal-Mobile   Sprint7   rebrand7
	Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Return Policy link For Test iTruemart Header

TC_ITMWM_04395 Verify Tab Menu - Shipment Policy is available
	[Tags]   TC_ITMWM_04395  Ready   Regression   Portal-Mobile   Sprint7   rebrand7
	Open Portal iTrueMart Mobile without resize rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_04396 Verify Tab Menu - Refund Policy is available
	[Tags]   TC_ITMWM_04396  Ready   Regression   Portal-Mobile   Sprint7   rebrand7
	Open Portal iTrueMart Mobile without resize rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_04397 Verify Tab Menu - Discount Code is available
	[Tags]   TC_ITMWM_04397  Ready   Regression    Portal-Mobile   Sprint7   rebrand7
	Open Portal iTrueMart Mobile without resize rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Discount Code link For Test iTruemart Header

TTC_ITMWM_04398 Verify Tab Menu - Contact Us is available
	[Tags]   TC_ITMWM_04398  Ready   Regression   Portal-Mobile   Sprint7   rebrand7
	Open Portal iTrueMart Mobile without resize rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Contact Us link For Test iTruemart Header

TC_ITMWM_04399 Verify Tab Menu - Select THAI language is available
	[Tags]   TC_ITMWM_04399  Ready    Portal-Mobile   Sprint7   rebrand7
	Open Portal iTrueMart Mobile without resize rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Thai language For Test iTruemart Header rebrand    auth/login?continue=${WEMALL_MOBILE}/cart

TC_ITMWM_04400 Verify Tab Menu - Select ENGLISH language is available
	[Tags]   TC_ITMWM_04400  Ready    Portal-Mobile   Sprint7   rebrand7
	Open Portal iTrueMart Mobile without resize rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify English language For Test iTruemart Header rebrand    auth/login?continue=${WEMALL_MOBILE}/cart

TC_ITMWM_04401 Verify Search have auto suggestion when type keyword on Search field
	[Tags]  TC_ITMWM_04401   Portal-Mobile       Regression   Ready   Sprint7   rebrand7
    Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_04402 Verify Search Function when not found item
	[Tags]  TC_ITMWM_04402   Portal-Mobile       Regression   Ready   Sprint7   rebrand7
    Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_04403 Verify Cancle Button In Search Page
	[Tags]  TC_ITMWM_04403   Portal-Mobile       Regression   Ready   Sprint7   rebrand7
    Open Portal iTrueMart Mobile without resize rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    auth/login?continue=${WEMALL_MOBILE}/cart

TC_ITMWM_04404 Verify WeMall icon Button
	[Tags]   TC_ITMWM_04404  Ready   Regression    Portal-Mobile   Sprint7   rebrand7
	Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_04405 Verify Header shop cart Button
	[Tags]   TC_ITMWM_04405  Ready   Regression   Portal-Mobile   Sprint7   rebrand7
	Login iTruemart And Go To Portal rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header


########################################### users/register #############################################################
TC_ITMWM_04406 Verify Mega Menu - “Register” is available
	[Tags]   TC_ITMWM_04406  Ready   Regression   Portal-Mobile   Sprint7   rebrand8
	Open Portal iTrueMart Mobile rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Login link For Test iTruemart Header rebrand incase auth/login    users/register

TC_ITMWM_04407 Verify Mega Menu - “Main Page” is available
	[Tags]   TC_ITMWM_04407  Ready    Portal-Mobile   Sprint7   rebrand8
	Open Portal iTrueMart Mobile rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Home link For Test iTruemart Header

TC_ITMWM_04408 Verify Mega Menu - Everyday Wow is available
	[Tags]   TC_ITMWM_04408  Ready   Regression   Portal-Mobile   Sprint7   rebrand8
	Open Portal iTrueMart Mobile rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_04409 Verify Mega Menu - Category is available
	[Tags]   TC_ITMWM_04409  Ready   Regression   Portal-Mobile   Sprint7   rebrand8
	Open Portal iTrueMart Mobile rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_04410 Verify Mega Menu - "Category" display follow PCMS config
# 	[Tags]   TC_ITMWM_04410  Ready   Regression   Portal-Mobile   Sprint7   Waitfortest   rebrand8
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    users/register
# 	Compare Mega Menu Category In WeMall Mobile Site with PCMS

TC_ITMWM_04412 Verify Tab Menu - Promotion is available
	[Tags]   TC_ITMWM_04412  Ready   Regression   Portal-Mobile   Sprint7   rebrand8
	Open Portal iTrueMart Mobile rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_04413 Verify Mega Menu - "Promotion" display follow PCMS config
# 	[Tags]   TC_ITMWM_04413  Ready   Regression   Portal-Mobile   Sprint7   rebrand8
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    users/register
# 	Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS

TC_ITMWM_04415 Verify Tab Menu - iTruemart is available
	[Tags]   TC_ITMWM_04415  Ready   Regression   Portal-Mobile   Sprint7   rebrand8
	Open Portal iTrueMart Mobile rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Itruemart link For Test iTruemart Header

TC_ITMWM_04416 Verify Tab Menu - Cart is available
	[Tags]   TC_ITMWM_04416  Ready   Regression   Portal-Mobile   Sprint7   rebrand8
	Login iTruemart And Go To Portal rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Cart link For Test iTruemart Header

TC_ITMWM_04417 Verify Tab Menu - Order Tracking is available
	[Tags]   TC_ITMWM_04417  Ready   Regression   Portal-Mobile   Sprint7   rebrand8
	Login iTruemart And Go To Portal rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_04418 Verify Tab Menu - Return Policy is available
	[Tags]   TC_ITMWM_04418  Ready   Regression   Portal-Mobile   Sprint7   rebrand8
	Open Portal iTrueMart Mobile rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Return Policy link For Test iTruemart Header

TC_ITMWM_04419 Verify Tab Menu - Shipment Policy is available
	[Tags]   TC_ITMWM_04419  Ready   Regression   Portal-Mobile   Sprint7   rebrand8
	Open Portal iTrueMart Mobile without resize rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_04420 Verify Tab Menu - Refund Policy is available
	[Tags]   TC_ITMWM_04420  Ready   Regression   Portal-Mobile   Sprint7   rebrand8
	Open Portal iTrueMart Mobile without resize rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_04421 Verify Tab Menu - Discount Code is available
	[Tags]   TC_ITMWM_04421  Ready   Regression    Portal-Mobile   Sprint7   rebrand8
	Open Portal iTrueMart Mobile without resize rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Discount Code link For Test iTruemart Header

TC_ITMWM_04422 Verify Tab Menu - Contact Us is available
	[Tags]   TC_ITMWM_04422  Ready   Regression   Portal-Mobile   Sprint7   rebrand8
	Open Portal iTrueMart Mobile without resize rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Contact Us link For Test iTruemart Header

TC_ITMWM_04423 Verify Tab Menu - Select THAI language is available
	[Tags]   TC_ITMWM_04423  Ready    Portal-Mobile   Sprint7   rebrand8
	Open Portal iTrueMart Mobile without resize rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Thai language For Test iTruemart Header rebrand    users/register

TC_ITMWM_04424 Verify Tab Menu - Select ENGLISH language is available
	[Tags]   TC_ITMWM_04424  Ready    Portal-Mobile   Sprint7   rebrand8
	Open Portal iTrueMart Mobile without resize rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify English language For Test iTruemart Header rebrand    users/register

TC_ITMWM_04425 Verify Search have auto suggestion when type keyword on Search field
	[Tags]  TC_ITMWM_04425   Portal-Mobile       Regression   Ready   Sprint7   rebrand8
    Open Portal iTrueMart Mobile rebrand    users/register
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_04426 Verify Search Function when not found item
	[Tags]  TC_ITMWM_04426   Portal-Mobile       Regression   Ready   Sprint7   rebrand8
    Open Portal iTrueMart Mobile rebrand    users/register
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_04427 Verify Cancle Button In Search Page
	[Tags]  TC_ITMWM_04427   Portal-Mobile       Regression   Ready   Sprint7   rebrand8
    Open Portal iTrueMart Mobile without resize rebrand    users/register
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    users/register

TC_ITMWM_04428 Verify WeMall icon Button
	[Tags]   TC_ITMWM_04428  Ready   Regression    Portal-Mobile   Sprint7   rebrand8
	Open Portal iTrueMart Mobile rebrand    users/register
	Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_04429 Verify Header shop cart Button
	[Tags]   TC_ITMWM_04429  Ready   Regression   Portal-Mobile   Sprint7   rebrand8
	Login iTruemart And Go To Portal rebrand    users/register
	Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header


########################################### Level D #############################################################
TC_ITMWM_04430 Verify Mega Menu - “Register” is available
    [Tags]   TC_ITMWM_04430  Ready   Regression   Portal-Mobile   Sprint7   rebrand9
    Open Portal iTrueMart Mobile rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Login link For Test iTruemart Header rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html

TC_ITMWM_04431 Verify Mega Menu - “Main Page” is available
    [Tags]   TC_ITMWM_04431  Ready    Portal-Mobile   Sprint7   rebrand9
    Open Portal iTrueMart Mobile rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Home link For Test iTruemart Header

TC_ITMWM_04432 Verify Mega Menu - Everyday Wow is available
    [Tags]   TC_ITMWM_04432  Ready   Regression   Portal-Mobile   Sprint7   rebrand9
    Open Portal iTrueMart Mobile rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_04433 Verify Mega Menu - Category is available
  [Tags]   TC_ITMWM_04433  Ready   Regression   Portal-Mobile   Sprint7   rebrand9
  Open Portal iTrueMart Mobile rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
  Click Main Menu In WeMall Mobile Sites
  Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_04434 Verify Mega Menu - "Category" display follow PCMS config
#   [Tags]   TC_ITMWM_04434  Ready   Regression   Portal-Mobile   Sprint7   Waitfortest   rebrand9
#   Open PCMS iTruemart
#   Verify Category Level 1
#   Open Portal iTrueMart Mobile without resize rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
#   Compare Mega Menu Category In WeMall Mobile Site with PCMS

TC_ITMWM_04436 Verify Tab Menu - Promotion is available
  [Tags]   TC_ITMWM_04436  Ready   Regression   Portal-Mobile   Sprint7   rebrand9
  Open Portal iTrueMart Mobile rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
  Click Main Menu In WeMall Mobile Sites
  Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_04437 Verify Mega Menu - "Promotion" display follow PCMS config
#   [Tags]   TC_ITMWM_04437  Ready   Regression   Portal-Mobile   Sprint7   rebrand9
#   Open PCMS iTruemart
#   Verify Category Level 1
#   Open Portal iTrueMart Mobile without resize rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
#   Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS

TC_ITMWM_04439 Verify Tab Menu - iTruemart is available
    [Tags]   TC_ITMWM_04439  Ready   Regression   Portal-Mobile   Sprint7   rebrand9
    Open Portal iTrueMart Mobile rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Itruemart link For Test iTruemart Header

TC_ITMWM_04440 Verify Tab Menu - Cart is available
    [Tags]   TC_ITMWM_04440  Ready   Regression   Portal-Mobile   Sprint7   rebrand9
    Login iTruemart And Go To Portal rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Cart link For Test iTruemart Header

TC_ITMWM_04441 Verify Tab Menu - Order Tracking is available
    [Tags]   TC_ITMWM_04441  Ready   Regression   Portal-Mobile   Sprint7   rebrand9
    Login iTruemart And Go To Portal rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_04442 Verify Tab Menu - Return Policy is available
    [Tags]   TC_ITMWM_04442  Ready   Regression   Portal-Mobile   Sprint7   rebrand9
    Open Portal iTrueMart Mobile rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Return Policy link For Test iTruemart Header

TC_ITMWM_04443 Verify Tab Menu - Shipment Policy is available
    [Tags]   TC_ITMWM_04443  Ready   Regression   Portal-Mobile   Sprint7   rebrand9
    Open Portal iTrueMart Mobile without resize rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_04444 Verify Tab Menu - Refund Policy is available
    [Tags]   TC_ITMWM_04444  Ready   Regression   Portal-Mobile   Sprint7   rebrand9
    Open Portal iTrueMart Mobile without resize rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_04445 Verify Tab Menu - Discount Code is available
    [Tags]   TC_ITMWM_04445  Ready   Regression    Portal-Mobile   Sprint7   rebrand9
    Open Portal iTrueMart Mobile without resize rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Discount Code link For Test iTruemart Header

TC_ITMWM_04446 Verify Tab Menu - Contact Us is available
    [Tags]   TC_ITMWM_04446  Ready   Regression   Portal-Mobile   Sprint7   rebrand9
    Open Portal iTrueMart Mobile without resize rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Contact Us link For Test iTruemart Header

TC_ITMWM_04447 Verify Tab Menu - Select THAI language is available
    [Tags]   TC_ITMWM_04447  Ready    Portal-Mobile   Sprint7   rebrand9
    Open Portal iTrueMart Mobile without resize rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Thai language For Test iTruemart Header rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html

TC_ITMWM_04448 Verify Tab Menu - Select ENGLISH language is available
    [Tags]   TC_ITMWM_04448  Ready    Portal-Mobile   Sprint7   rebrand9
    Open Portal iTrueMart Mobile without resize rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify English language For Test iTruemart Header rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html

TC_ITMWM_04449 Verify Search have auto suggestion when type keyword on Search field
    [Tags]  TC_ITMWM_04449   Portal-Mobile       Regression   Ready   Sprint7   rebrand9
    Open Portal iTrueMart Mobile rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_04450 Verify Search Function when not found item
    [Tags]  TC_ITMWM_04450   Portal-Mobile       Regression   Ready   Sprint7   rebrand9
    Open Portal iTrueMart Mobile rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_04451 Verify Cancle Button In Search Page
    [Tags]  TC_ITMWM_04451   Portal-Mobile       Regression   Ready   Sprint7   rebrand9
    Open Portal iTrueMart Mobile without resize rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html

TC_ITMWM_04452 Verify WeMall icon Button
    [Tags]   TC_ITMWM_04452  Ready   Regression    Portal-Mobile   Sprint7   rebrand9
    Open Portal iTrueMart Mobile rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_04453 Verify Header shop cart Button
    [Tags]   TC_ITMWM_04453  Ready   Regression   Portal-Mobile   Sprint7   rebrand9
    Login iTruemart And Go To Portal rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header

########################################### member/orders #############################################################
TC_ITMWM_04454 Verify Mega Menu - “Register” is available
    [Tags]   TC_ITMWM_04454  Ready   Regression   Portal-Mobile   Sprint13   rebrand10
    Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Login link For Test iTruemart Header rebrand incase auth/login    auth/login?continue=${WEMALL_MOBILE}/member/orders

TC_ITMWM_04455 Verify Mega Menu - “Main Page” is available
    [Tags]   TC_ITMWM_04455  Ready    Portal-Mobile   Sprint13   rebrand10
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Home link For Test iTruemart Header

TC_ITMWM_04456 Verify Mega Menu - Everyday Wow is available
    [Tags]   TC_ITMWM_04456  Ready   Regression   Portal-Mobile   Sprint13   rebrand10
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_04457 Verify Mega Menu - Category is available
  [Tags]   TC_ITMWM_04457  Ready   Regression   Portal-Mobile   Sprint13   rebrand10
  Login iTruemart And Go To Portal rebrand    member/orders
  Click Main Menu In WeMall Mobile Sites
  Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_04458 Verify Mega Menu - "Category" display follow PCMS config
#   [Tags]   TC_ITMWM_04458  Ready   Regression   Portal-Mobile   Sprint13   Waitfortest   rebrand10
#   Open PCMS iTruemart
#   Verify Category Level 1
#   Login iTruemart And Go To Portal rebrand    member/orders
#   Compare Mega Menu Category In WeMall Mobile Site with PCMS

TC_ITMWM_04460 Verify Tab Menu - Promotion is available
  [Tags]   TC_ITMWM_04460  Ready   Regression   Portal-Mobile   Sprint13   rebrand10
  Login iTruemart And Go To Portal rebrand    member/orders
  Click Main Menu In WeMall Mobile Sites
  Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_04461 Verify Mega Menu - "Promotion" display follow PCMS config
#   [Tags]   TC_ITMWM_04461  Ready   Regression   Portal-Mobile   Sprint13   rebrand10
#   Open PCMS iTruemart
#   Verify Category Level 1
#   Login iTruemart And Go To Portal rebrand    member/orders
#   Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS

TC_ITMWM_04463 Verify Tab Menu - iTruemart is available
    [Tags]   TC_ITMWM_04463  Ready   Regression   Portal-Mobile   Sprint13   rebrand10
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Itruemart link For Test iTruemart Header

TC_ITMWM_04464 Verify Tab Menu - Cart is available
    [Tags]   TC_ITMWM_04464  Ready   Regression   Portal-Mobile   Sprint13   rebrand10
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Cart link For Test iTruemart Header

TC_ITMWM_04465 Verify Tab Menu - Order Tracking is available
    [Tags]   TC_ITMWM_04465  Ready   Regression   Portal-Mobile   Sprint13   rebrand10
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_04466 Verify Tab Menu - Return Policy is available
    [Tags]   TC_ITMWM_04466  Ready   Regression   Portal-Mobile   Sprint13   rebrand10
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Return Policy link For Test iTruemart Header

TC_ITMWM_04467 Verify Tab Menu - Shipment Policy is available
    [Tags]   TC_ITMWM_04467  Ready   Regression   Portal-Mobile   Sprint13   rebrand10
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_04468 Verify Tab Menu - Refund Policy is available
    [Tags]   TC_ITMWM_04468  Ready   Regression   Portal-Mobile   Sprint13   rebrand10
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_04469 Verify Tab Menu - Discount Code is available
    [Tags]   TC_ITMWM_04469  Ready   Regression    Portal-Mobile   Sprint13   rebrand10
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Discount Code link For Test iTruemart Header

TC_ITMWM_04470 Verify Tab Menu - Contact Us is available
    [Tags]   TC_ITMWM_04470  Ready   Regression   Portal-Mobile   Sprint13   rebrand10
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Contact Us link For Test iTruemart Header

TC_ITMWM_04471 Verify Tab Menu - Select THAI language is available
    [Tags]   TC_ITMWM_04471  Ready    Portal-Mobile   Sprint13   rebrand10
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Thai language For Test iTruemart Header rebrand    member/orders

TC_ITMWM_04472 Verify Tab Menu - Select ENGLISH language is available
    [Tags]   TC_ITMWM_04472  Ready    Portal-Mobile   Sprint13   rebrand10
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify English language For Test iTruemart Header rebrand    member/orders

TC_ITMWM_04473 Verify Search have auto suggestion when type keyword on Search field
    [Tags]  TC_ITMWM_04473   Portal-Mobile       Regression   Ready   Sprint13   rebrand10
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_04474 Verify Search Function when not found item
    [Tags]  TC_ITMWM_04474   Portal-Mobile       Regression   Ready   Sprint13   rebrand10
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_04475 Verify Cancle Button In Search Page
    [Tags]  TC_ITMWM_04475   Portal-Mobile       Regression   Ready   Sprint13   rebrand10
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    member/orders

TC_ITMWM_04476 Verify WeMall icon Button
    [Tags]   TC_ITMWM_04476  Ready   Regression    Portal-Mobile   Sprint13   rebrand10
    Login iTruemart And Go To Portal rebrand    member/orders
    Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_04477 Verify Header shop cart Button
    [Tags]   TC_ITMWM_04477  Ready   Regression   Portal-Mobile   Sprint13   rebrand10
    Login iTruemart And Go To Portal rebrand    member/orders
    Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header

########################################### /member/profile #############################################################
TC_ITMWM_00677 Verify Mega Menu - “Register” is available
    [Tags]   TC_ITMWM_00677  Ready   Regression   Portal-Mobile   Sprint14   rebrand11
    Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/member/profile
	Click Main Menu In WeMall Mobile Sites
	Verify Login link For Test iTruemart Header rebrand incase auth/login    auth/login?continue=${WEMALL_MOBILE}/member/profile

TC_ITMWM_00678 Verify Mega Menu - “Main Page” is available
    [Tags]   TC_ITMWM_00678  Ready    Portal-Mobile   Sprint14   rebrand11
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Home link For Test iTruemart Header

TC_ITMWM_00679 Verify Mega Menu - Everyday Wow is available
    [Tags]   TC_ITMWM_00679  Ready   Regression   Portal-Mobile   Sprint14   rebrand11
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_00680 Verify Mega Menu - Category is available
  [Tags]   TC_ITMWM_00680  Ready   Regression   Portal-Mobile   Sprint14   rebrand11
  Login iTruemart And Go To Portal rebrand    member/profile
  Click Main Menu In WeMall Mobile Sites
  Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_00681 Verify Mega Menu - "Category" display follow PCMS config
#   [Tags]   TC_ITMWM_00681  Ready   Regression   Portal-Mobile   Sprint14   rebrand11
#   Open PCMS iTruemart
#   Verify Category Level 1
#   Login iTruemart And Go To Portal rebrand    member/profile
#   Compare Mega Menu Category In WeMall Mobile Site with PCMS

TC_ITMWM_00683 Verify Tab Menu - Promotion is available
  [Tags]   TC_ITMWM_00683  Ready   Regression   Portal-Mobile   Sprint14   rebrand11
  Login iTruemart And Go To Portal rebrand    member/profile
  Click Main Menu In WeMall Mobile Sites
  Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_00684 Verify Mega Menu - "Promotion" display follow PCMS config
#   [Tags]   TC_ITMWM_00684  Ready   Regression   Portal-Mobile   Sprint14   rebrand11
#   Open PCMS iTruemart
#   Verify Category Level 1
#   Login iTruemart And Go To Portal rebrand    member/profile
#   Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS

TC_ITMWM_00686 Verify Tab Menu - iTruemart is available
    [Tags]   TC_ITMWM_00686  Ready   Regression   Portal-Mobile   Sprint14   rebrand11
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Itruemart link For Test iTruemart Header

TC_ITMWM_00687 Verify Tab Menu - Cart is available
    [Tags]   TC_ITMWM_00687  Ready   Regression   Portal-Mobile   Sprint14   rebrand11
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Cart link For Test iTruemart Header

TC_ITMWM_00688 Verify Tab Menu - Order Tracking is available
    [Tags]   TC_ITMWM_00688  Ready   Regression   Portal-Mobile   Sprint14   rebrand11
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_00689 Verify Tab Menu - Return Policy is available
    [Tags]   TC_ITMWM_00689  Ready   Regression   Portal-Mobile   Sprint14   rebrand11
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Return Policy link For Test iTruemart Header

TC_ITMWM_00690 Verify Tab Menu - Shipment Policy is available
    [Tags]   TC_ITMWM_00690  Ready   Regression   Portal-Mobile   Sprint14   rebrand11
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_00691 Verify Tab Menu - Refund Policy is available
    [Tags]   TC_ITMWM_00691  Ready   Regression   Portal-Mobile   Sprint14   rebrand11
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_00692 Verify Tab Menu - Discount Code is available
    [Tags]   TC_ITMWM_00692  Ready   Regression    Portal-Mobile   Sprint14   rebrand11
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Discount Code link For Test iTruemart Header

TC_ITMWM_00693 Verify Tab Menu - Contact Us is available
    [Tags]   TC_ITMWM_00693  Ready   Regression   Portal-Mobile   Sprint14   rebrand11
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Contact Us link For Test iTruemart Header

TC_ITMWM_00694 Verify Tab Menu - Select THAI language is available
    [Tags]   TC_ITMWM_00694  Ready    Portal-Mobile   Sprint14   rebrand11
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Thai language For Test iTruemart Header rebrand    member/profile

TC_ITMWM_00695 Verify Tab Menu - Select ENGLISH language is available
    [Tags]   TC_ITMWM_00695  Ready    Portal-Mobile   Sprint14   rebrand11
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify English language For Test iTruemart Header rebrand    member/profile

TC_ITMWM_00696 Verify Search have auto suggestion when type keyword on Search field
    [Tags]  TC_ITMWM_00696   Portal-Mobile       Regression   Ready   Sprint14   rebrand11
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_00697 Verify Search Function when not found item
    [Tags]  TC_ITMWM_00697   Portal-Mobile       Regression   Ready   Sprint14   rebrand11
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_00698 Verify Cancle Button In Search Page
    [Tags]  TC_ITMWM_00698   Portal-Mobile       Regression   Ready   Sprint14   rebrand11
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    member/profile

TC_ITMWM_00699 Verify WeMall icon Button
    [Tags]   TC_ITMWM_00699  Ready   Regression    Portal-Mobile   Sprint14   rebrand11
    Login iTruemart And Go To Portal rebrand    member/profile
    Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_00700 Verify Header shop cart Button
    [Tags]   TC_ITMWM_00700  Ready   Regression   Portal-Mobile   Sprint14   rebrand11
    Login iTruemart And Go To Portal rebrand    member/profile
    Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header

















