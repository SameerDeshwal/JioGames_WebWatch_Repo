*** Settings ***
Library                      SeleniumLibrary
Resource                     ../../Resources/Common.robot 
Variables                    ../../Resources/Common_Variables.yaml
Resource                     ../../Resources/Local_Keywords.robot
Variables                      ../../Tests/History/History.yaml
Resource                             ../../Resources/Excel_Activity.robot
Resource                        ../History_PO/RedirectionToHistory.robot

*** Keywords ***

History Page Redirection & Verifiation
    #[110905]
    Landing on History Page 
    Click on History from profile icon
    Confirm UI Verification of "History Page"
    Video duration seekbar represents the duration for which the video has been watched

#[110906,110909]
Click on History from profile icon
    #110906
    #Click on Profile icon 
    Wait For And Click Element                xpath= //div[@class="w-10 h-10 flex relative"] 

    #The tab opens having options :
    # 1. Username
    Wait For And Verify Element               xpath= //div[@class="text-onSurface text-xs cursor-pointer flex mt-2.5"]//img[@alt="user icon"]
    Wait For And Verify Element               xpath= //div[@class="text-onSurface text-xs cursor-pointer flex mt-2.5"]//span[@class="pl-2"]
    
    # 2. History, 3. My Watchlist, 4. My Channel, 5. Creator Console, 6. Settings, Logout
    FOR    ${index}    ${element}    IN ENUMERATE    @{ProfileMenuOptns}
        Wait For And Verify Element           xpath= //div[@class="text-onSurface text-xs cursor-pointer flex mt-2"]//span[contains(normalize-space(),"${element}")]
    END
    
    # Select the "History" option from the dropdown menu 
    Wait For And Click Element                xpath= //div[@class="text-onSurface text-xs cursor-pointer flex mt-2"]//span[contains(normalize-space(),"History")]

    Sleep    1s    
    #Verifying URL of History page   
    URL Validation                            ${URL_of_History} 

    # [110909]    
    #click on top left logo
    Click Image                               xpath://img[@alt="JioGames"]
    #Verify Home page content
    Wait For And Verify Content               xpath:(//p[@class="text-onPrimary text-[18px] font-JioTypeBold"])[1]             Top Live Streams

#[110910]
Verifying History Page  
    Wait For And Click Element                xpath=(//div[@class="flex w-full hover:bg-[#707070] rounded-full"])[1]
    #Verify Home page content
    Wait For And Verify Content               xpath:(//p[@class="text-onPrimary text-[18px] font-JioTypeBold"])[1]             Top Live Streams    
    #Collapse menu     
    Wait For And Click Element                xpath=//div[@class="flex p-4"]        
    #History tab 
    Wait For And Click Element                xpath=//img[contains(@alt,'History')]     
    #Verify the content History 
    Wait For And Verify Content               xpath=//div[@class="font-JioTypeMedium text-3xl text-onPrimary pl-8"]            History    
    #Verifying URL of History page   
    URL Validation                            ${URL_of_History}
    

#[110907]
Confirm UI Verification of "History Page"
    #[110907]
    #JioGames logo
    Wait For And Verify Element    xpath=//img[@alt='JioGames']
    #JioGames Text
    Wait For And Verify Content    xpath=//div[@class='text-onPrimary font-JioTypeBold text-lg pl-2']    JioGames
    #Get app
    Wait For And Verify Content    xpath=//a[normalize-space()='Get app']    Get app
    #Profile icon
    Wait For And Verify Element    xpath=//img[@class='rounded-full w-full h-full cursor-pointer appHeader']
    #collapse menu in collapse state verification
    Collapse Menu icons Verification
    #verifying UI and functionality of videos 
    Verify Videos in History page

Collapse Menu icons Verification
    # Open the left panel by hovering the cursor on the left side of the page
    Mouse Over                               xpath= //div[@class="flex w-full cursor-pointer items-center"]
    #The left panel opens having options 
    # 1. Home,2. Live Now, 3. Videos,4. Categories,5. History,6. My Watchlist,7. My Channel
    FOR    ${index}    ${element}    IN ENUMERATE    @{CollapsMenuOptions}
        Wait For And Verify Element          xpath= //a[contains(normalize-space(),"${element}")] 
        Image Verification                   xpath=//img[@alt='${element}']
    END

Verify Videos in History page
    #vertical bar on left side of "History" title.
    Wait For And Verify Element    xpath=//div[@class='bg-primary rounded-full w-2 h-9']

    #History text
    Sleep                            2s
    Text Verification              xpath=//div[@class='font-JioTypeMedium text-3xl text-onPrimary pl-8']    History
    #Clear history
    #History tab 
    Wait For And Click Element                xpath=//img[contains(@alt,'History')] 
    Wait For And Verify Element    xpath=//button[normalize-space()='Clear history']
    Verify UI of Video tile

#[110914,110918,110919,110920]
Video duration seekbar represents the duration for which the video has been watched
    #110919
    #Click on any video thumbnail available
    Wait For And Click Element                      xpath= (//img[@alt="VideoThumbnail"])[2]
    Sleep    1s
    #check video is playable
    Wait Until Element Is Visible            xpath=//div[@id="watch"]

    #Video will play
    Element Attribute Value Should Be        xpath=//video[@id="video"]    autoplay    true
    
    #pause video
    Wait For And Click Element               xpath=//video[@id="video"]
    #User is redirected to the watch video page.
    #URL Validation    
    #Watch the video for some time and note the duration for which it is watched. Go back to the "History" page and observe the length of seekbar in the thumbnail of that video.
    Sleep    10s
    Mouse Over                                      xpath= //video[@id="video"]
    ${VideoWatchedDuration}=    Get Text            xpath= //div[@class="w-max pr-3 text-xs mb-2 font-JioTypeBold false"]
    ${VideoWatchedDuration}=    Fetch From Right    ${VideoWatchedDuration}    / 
    ${VideoWatchedDuration}=    Strip String        ${VideoWatchedDuration}  
    
    Log To Console    ${VideoWatchedDuration}
    Go Back
    #The video duration seekbar corresponds to the duration for which the video had been watched.
    #Text Verification                               xpath= (//div[@class="absolute bottom-3 text-[10px] w-max right-2.5 text-right bg-surface text-onSurface px-2 py-1 rounded-lg font-JioTypeBold"])[2]    ${VideoWatchedDuration}



#[110915]
Add to watch later
    #Click on kebab menu
    Sleep                                    3s
    Wait For And Long Press                 xpath=(//div[@class="flex min-w-[10px] items-end justify-end w-full"]//img[1])[3]
    Wait For And Long Press                 xpath=(//div[@class="flex min-w-[10px] items-end justify-end w-full"]//img[1])[3]  

    #Click on Added to watch later option              
    Wait For And Click Element              xpath=(//div[@class="text-xs text-onSurface font-JioTypeLight hover:bg-loginText hover:text-onSecondary hover:rounded-sm px-1"])[1]
    
    #Verify PopUp
    Toast Capture and Data Validation       xpath=//div[@class="animate-enter relative max-w-sm w-100 mt-12 bg-surface shadow-lg rounded-lg pointer-events-auto ring-1 ring-black ring-opacity-5 overflow-hidden"]        Pop_Up     Added to watch later list   
    


#[110916]
Remove from watchlist 

    #Click on kebab menu
    Sleep                                3s
    Wait For And Long Press                 xpath=(//div[@class="flex min-w-[10px] items-end justify-end w-full"]//img[1])[3]
    Wait For And Long Press                 xpath=(//div[@class="flex min-w-[10px] items-end justify-end w-full"]//img[1])[3] 

    #Click on Added to watch later option              
    Wait For And Click Element              xpath=(//div[@class="text-xs text-onSurface font-JioTypeLight hover:bg-loginText hover:text-onSecondary hover:rounded-sm px-1"])[1]
    
    #Verify PopUp
    Toast Capture and Data Validation       xpath=//div[@class="animate-enter relative max-w-sm w-100 mt-12 bg-surface shadow-lg rounded-lg pointer-events-auto ring-1 ring-black ring-opacity-5 overflow-hidden"]        Pop_Up            Removed from watch later list      
    
#[110913]
Confirm if the user is able to clear history using the "Clear history" button.
    #verify clear history button
    Wait For And Verify Element    ${ClearHistory}
    sleep    2s

    #click on clear history
    Wait For And Click Element     ${ClearHistory}
    
    #pop up verify
    Wait Until Page Contains    Are you sure you want to clear your list?

    Take Page Screenshot    Clear_History.png

    #verify icon
    Wait For And Verify Element    xpath=//img[@class='mt-8']

    #Below icon Text
    Wait For And Verify Content    xpath=//div[contains(text(),'Are you sure you want to clear your list?')]    Are you sure you want to clear your list?

    #Below icon subtext
    Wait For And Verify Content    xpath=//div[contains(text(),'This action cannot be undone')]    This action cannot be undone

    #Cancel Button
    Wait For And Verify Content    xpath=//div[contains(text(),'Cancel')]    Cancel

    #verify Clear History Button 
    Wait For And Verify Content    xpath=//div[contains(text(),'Clear all history')]    Clear all history

    #click on clear history button
    Wait For And Click Element     xpath=//div[contains(text(),'Clear all history')]

#[110912,110911]

    #Checking Clear History button is disable
    #Element Should Be Disabled                ${Clear_history_button}
    #Verify pop up

    Wait For And Verify Content               xpath://div[@class="text-onPrimary text-xs bg-primary rounded-full px-4 py-1.5 cursor-pointer mt-4 mb-8"]                                                            Find Popular Videos

    #Click on Find Popular videos

    Wait For And Click Element                xpath://div[@class="text-onPrimary text-xs bg-primary rounded-full px-4 py-1.5 cursor-pointer mt-4 mb-8"]

    #Verify Content on the Home page

    Wait For And Verify Content               xpath:(//div[@class="flex justify-between items-center pl-6 mr-6 mt-11"])[1]    Top Live Streams

    Sleep    5s
#[110926]   
    #New URL with extra alphabet at end
    Go To                                    ${Incorrect_URL1}

    #Verfying the message after entering wrong link
    Wait For And Verify Content                        xpath=//h1[@class="max-6-xs text-6xl text-sky-700 font-thin uppercase my-16"]        NOT FOUND
    
    #New URL with 1 less alphabet at end
    Go To                                    ${Incorrect_URL2}
    
    #Verfying the message after entering wrong link
    Wait For And Verify Content                        xpath=//h1[@class="max-6-xs text-6xl text-sky-700 font-thin uppercase my-16"]        NOT FOUND
#[110908]

    #Copy the page URL and log out from JioGames Web
    #Profile logo
    Wait For And Click Element    ${Profile_logo_ontheright}                        
    #xpath of logout
    Wait For And Verify Content   ${Logout_logo}    Logout                          
    Wait For And Click Element    ${Logout_logo}        
    Go To                         ${URL_of_History}
    Sleep    5s 
