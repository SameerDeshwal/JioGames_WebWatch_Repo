*** Settings ***
Library                      SeleniumLibrary
Resource                     ../../Resources/Common.robot 
Variables                    ../../Resources/Common_Variables.yaml
Resource                     ../Local_Keywords.robot
Variables                    ../../Tests/My_WatchList/My_WatchList.yaml  
Resource                    ../../Resources/My_Watchlist_PO/RedirectionToMyWatchList.robot

*** Keywords ***
Verification of MyWatchlist Page Redirection, UI & functionality
    User lands on "My Watchlist" page through the 'Profile icon' on the top right corner of the "Home Page"    
    Verify functionality of Report,Remove & Clear list 

User lands on "My Watchlist" page on clicking the page "URL"
#[110930,110928]
    Landing on MyWatchlist Page
    # Open the left panel by hovering the cursor on the left side of the page
    Mouse Over                               xpath= //div[@class="flex w-full cursor-pointer items-center"]
    #The left panel opens having options 
    # 1. Home,2. Live Now, 3. Videos,4. Categories,5. History,6. My Watchlist,7. My Channel
    FOR    ${index}    ${element}    IN ENUMERATE    @{CollapsMenuOptions}
        Wait For And Verify Element          xpath= //a[contains(normalize-space(),"${element}")] 
    END
    # Select the "My Watchlist" option from the left panel
    Landing on MyWatchlist Page
    # Click on the profile icon at the top right corner of JioGames web 
    Wait For And Click Element               xpath= //div[@class="w-10 h-10 flex relative"]
    # Copy page URL then log out from top right profile menu
    Wait For And Click Element               xpath= //div[@class="text-onSurface text-xs cursor-pointer flex mt-2"]//span[contains(normalize-space(),"Logout")]
    Sleep    500ms 
    # Paste the page URL on new tab and press Enter
    Go To    ${MyWatchListUrl}
    # User land on JioGames web login page 
    Wait For And Verify Content              xpath= //p[@class="font-JioTypeMedium text-[25px] leading-3 text-loginText"]    Welcome to JioGamesWatch
    Wait For And Verify Content              xpath= //p[@class="font-JioTypeMedium text-2xl leading-3 text-loginText"]    Sign In
    # Login to JioGames Web through "Password" or "OTP" 
    Login to Jio Games Web Watch
    # User directly lands on JioGames web "My Watchlist" page
    URL Validation    ${MyWatchListUrl}
#110933
    # Click on "JioGames" icon on the top left side of the screen 
    Wait For And Click Element               xpath= //img[@alt="JioGames"]
    # User redirected to the Home Page of the  JioGames web watch
    URL Validation    ${JioGamesWatchURL}
    Sleep    2s
#110949
    #New URL with extra alphabet at end
    Go To                                     ${Incorrect_URL1}
    #Verfying the message after entering wrong link
    Wait For And Verify Content               xpath=//h1[@class="max-6-xs text-6xl text-sky-700 font-thin uppercase my-16"]        NOT FOUND
    #New URL with 1 less alphabet at end
    Go To                                     ${Incorrect_URL2}
    #Verfying the message after entering wrong link
    Wait For And Verify Content               xpath=//h1[@class="max-6-xs text-6xl text-sky-700 font-thin uppercase my-16"]        NOT FOUND

User lands on "My Watchlist" page through the 'Profile icon' on the top right corner of the "Home Page"
    #110934  
    #Scroll to video section 2
    Scroll Down                 xpath= (//div[@class="flex justify-between items-center pl-6 mr-6 mt-11"])[3]
    FOR    ${index}    IN RANGE    1    5
        # Click on kebab menu at the bottom right side of any video 
        #Kebab menu at the bottom right side of any video is not clickable most time in one attempt
         Wait For And Click Element               xpath= ((//div[@class=" horizontalScroll flex gap-x-4 py-10 px-7 overflow-x-scroll no-scrollbar w-full h-full "])[2]//div[@class="flex min-w-[10px] items-end justify-end w-full"])[${index}]

    ${PresenceOfVideoKebabMenu}=    Run Keyword And Return Status    Wait For And Verify Element   xpath= //div[@class="absolute bg-surface w-max p-2 rounded-md -right-24 -bottom-10 z-20 mr-auto"]
    IF    ${PresenceOfVideoKebabMenu} == False
       Wait For And Click Element            xpath= ((//div[@class=" horizontalScroll flex gap-x-4 py-10 px-7 overflow-x-scroll no-scrollbar w-full h-full "])[2]//div[@class="flex min-w-[10px] items-end justify-end w-full"])[${index}]
    END
           
    # Verify apperared options: Add to Watch later, Share Video, Report Video
    Wait For And Verify Element              xpath= //div[@class="absolute bg-surface w-max p-2 rounded-md -right-24 -bottom-10 z-20 mr-auto"]
    
    #${KebabOptns}=    Get Element Count    @${VideoTileKebabMenu}
    FOR    ${index}    IN RANGE    1    4
        Text Verification                    xpath= //div[@class="absolute bg-surface w-max p-2 rounded-md -right-24 -bottom-10 z-20 mr-auto"]//div[${index}]    ${VideoTileKebabMenu1}[${index}]
    END

    # Click on the "Add to Watch later" option 
    Double Click Element                     xpath= //div[@class="absolute bg-surface w-max p-2 rounded-md -right-24 -bottom-10 z-20 mr-auto"]//div[1] 
    # "Added to Watch later List" pop up appears at the top right side and the video is added to watchlist
    Sleep                                    500ms
    Toast Capture and Data Validation        xpath= //div[@class="animate-enter relative max-w-sm w-100 mt-12 bg-surface shadow-lg rounded-lg pointer-events-auto ring-1 ring-black ring-opacity-5 overflow-hidden"]   Added to Watch later toast   Added to watch later list
    
    END

    #110929
    #Click on the profile icon at the top right corner of JioGames web 
    Wait For And Click Element                xpath= //div[@class="w-10 h-10 flex relative"]
    
    #The tab opens having options :
    # 1. Username
    Wait For And Verify Element               xpath= //div[@class="text-onSurface text-xs cursor-pointer flex mt-2.5"]//img[@alt="user icon"]
    Wait For And Verify Element               xpath= //div[@class="text-onSurface text-xs cursor-pointer flex mt-2.5"]//span[@class="pl-2"]
    
    # 2. History, 3. My Watchlist, 4. My Channel, 5. Creator Console, 6. Settings, Logout
    FOR    ${index}    ${element}    IN ENUMERATE    @{ProfileMenuOptns}
        Wait For And Verify Element           xpath= //div[@class="text-onSurface text-xs cursor-pointer flex mt-2"]//span[contains(normalize-space(),"${element}")]
    END
    
    # Select the "My Watchlist" option from the dropdown menu 
    Wait For And Click Element                xpath= //div[@class="text-onSurface text-xs cursor-pointer flex mt-2"]//span[contains(normalize-space(),"My Watchlist")]

    #[110935]    
    #Verify UI of MyWatchList page
    # Keep watchlist tab in focus
    Wait For And Mouse Over Element          xpath= //div[@class="ml-5 mr-6 mt-6 mb-10 grid gap-x-4 no-scrollbar gap-y-12 grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 5-vod:grid-cols-5 2xl:grid-cols-6"]
    # Select the "My Watchlist" option from the dropdown menu 
    Wait For And Click Element                xpath=(//div[@class="flex w-full hover:bg-[#707070] rounded-full"])[6]
    Verify UI of Video tile
    # 5.There is horizontal video progress bar at bottom side of the video thumbnail if user watched that video earlier.
    ${WatchedVideo}=    Run Keyword And Return Status    Wait For And Verify Element     xpath= (//div[@class="absolute bottom-0 bg-redPrimary h-1.5 rounded-lg overflow-hidden max-w-full"])[1]
        IF    '${WatchedVideo}' == 'true' 
           Log To Console                    You have watched this video before 
        ELSE
           Log To Console                    You have not watched this video before 
        END
    #[110937]
    Verify UI of Playable Video

    
Verify UI of Playable Video
    #click on any video of my watchlist page
    Wait For And Click Element       xpath=//div[@class="flex p-4"]
    Scroll Element Into View         xpath=(//img[@alt="VideoThumbnail"])[1]   
    Wait For And Click Element       xpath=(//img[@alt="VideoThumbnail"])[1]
    Sleep    500ms
    
    #Verify comments section
    Wait For And Verify Element      xpath=//input[@placeholder='Write a comment']  

    #check video is playable
    Wait Until Element Is Visible    xpath=//div[@id="watch"]

    #Video will play
    Element Attribute Value Should Be        xpath=//video[@id="video"]    autoplay    true

    #pause video
    Wait For And Click Element       xpath=//video[@id="video"]

    #volume
    Wait For And Verify Element      xpath=//input[@title='volume']  

    #Backward and Forward
    Wait For And Verify Element      xpath=//div[@class='flex items-center pr-6 min-w-max min-h-max']

    #Full Screen button
    Wait For And Verify Element      xpath=//img[@alt='play video']
    Sleep    500ms 


Verify functionality of Report,Remove & Clear list 
    #[110940]
    Landing on MyWatchlist Page
    #Kebab menu at the bottom right side of any video is not clickable most time in one attempt
    Wait For And Click Element    ${Kebab_menu}

    ${PresenceOfVideoKebabMenu}=    Run Keyword And Return Status    Wait For And Verify Element   xpath= //div[@class="absolute bg-surface w-max p-2 rounded-md -right-24 -bottom-10 z-20 mr-auto"]
    IF    ${PresenceOfVideoKebabMenu} == False
       Wait For And Click Element            ${Kebab_menu}
    END
           
    #click on report video
    Wait For And Click Element    xpath=//div[contains(text(),'Report Video')]

    #verify cross icon
    Wait For And Verify Element   xpath=//img[@alt='close']

    #click on cross icon
    Wait For And Click Element    xpath=//img[@alt='close']

    #[110939]
    #Click on kebab menu 
    Wait For And Click Element    ${Kebab_menu}

    ${PresenceOfVideoKebabMenu}=    Run Keyword And Return Status    Wait For And Verify Element   xpath= //div[@class="absolute bg-surface w-max p-2 rounded-md -right-24 -bottom-10 z-20 mr-auto"]
    IF    ${PresenceOfVideoKebabMenu} == False
       Wait For And Click Element            ${Kebab_menu}
    END 

    #Click on report video              
    Wait For And Click Element              xpath=(//div[@class="text-xs text-onSurface font-JioTypeLight hover:bg-loginText hover:text-onSecondary hover:rounded-sm px-1"])[3]
    Sleep            1s

    #Verifying heading 
    Text Verification                       xpath=//h1[@class="text-xl md:text-2xl md:leading-3 leading-3 font-JioTypeMedium font-extralight text-onPrimary"]            Report Video

    #Verifying sub heading
    Text Verification                       xpath=//h3[@class="mt-6 text-base md:text-lg md:leading-4 leading-4 font-JioTypeLight text-onPrimary"]                       Tell us why you wish to report this video?  

    #Verifying options (Reasons) in tiles
    FOR    ${Reasons}    IN RANGE    1    11
        Text Verification                                  xpath=(//button[@class="w-fit bg-borderPrimary text-sm leading-4 text-white py-2 px-4 md:py-4 md:px-10 rounded-full whitespace-nowrap mt-2 ml-2 md:ml-4 md:mt-6"])[${Reasons}]        ${Report_Page}[${Reasons-1}]                   
    END

    #checking submit button is disabled
    Element Should Be Disabled                   xpath=//button[normalize-space()='Submit']
    
    #Click on any reason
    Wait For And Click Element               xpath=//button[normalize-space()='Offensive']

    #checking submit button is enabled
    Element Should Be Enabled                    xpath=//button[normalize-space()='Submit']

    #Click on submit button
    Wait For And Click Element               xpath=//button[normalize-space()='Submit']

    #Verifying Popup
    Toast Capture and Data Validation        xpath=//div[@class="animate-enter relative max-w-sm w-100 mt-12 bg-surface shadow-lg rounded-lg pointer-events-auto ring-1 ring-black ring-opacity-5 overflow-hidden"]        PopUp        Thanks for reporting video!

    #[110938]
    #Click on kebab menu 
    Wait For And Click Element    ${Kebab_menu}

    ${PresenceOfVideoKebabMenu}=    Run Keyword And Return Status    Wait For And Verify Element   xpath= //div[@class="absolute bg-surface w-max p-2 rounded-md -right-24 -bottom-10 z-20 mr-auto"]
    IF    ${PresenceOfVideoKebabMenu} == False
       Wait For And Click Element            ${Kebab_menu}
    END 

    #Verifying Removed from watch later list button is enabled
    Element Should Be Enabled               xpath=(//div[@class="text-xs text-onSurface font-JioTypeLight hover:bg-loginText hover:text-onSecondary hover:rounded-sm px-1"])[1]
    
    #Click on Removed from watch later list button
    Wait For And Click Element              xpath=(//div[@class="text-xs text-onSurface font-JioTypeLight hover:bg-loginText hover:text-onSecondary hover:rounded-sm px-1"])[1]
    Sleep            1s

    #Verify PopUp
    Toast Capture and Data Validation       xpath=//div[@class="animate-enter relative max-w-sm w-100 mt-12 bg-surface shadow-lg rounded-lg pointer-events-auto ring-1 ring-black ring-opacity-5 overflow-hidden"]        Pop_Up            Removed from watch later list 
    
    Sleep    1s
    #[110941]
    #verify clear list
    Wait For And Verify Element   ${Clear_list}
    #click on clear list
    Wait For And Click Element    ${Clear_list}
    #Verify pop up
    Wait For And Verify Element    xpath=//div[@class='absolute top-1/3 left-1/3 z-30 flex flex-col rounded-lg items-center justify-center bg-surface w-[40%]']
    #Verify Are you sure you want to clear your list?"
    Wait For And Verify Content    xpath=//div[contains(text(),'Are you sure you want to clear your list?')]    Are you sure you want to clear your list?
    #Verify This action cannot be undone
    Wait For And Verify Content    xpath=//div[contains(text(),'This action cannot be undone')]    This action cannot be undone    
    
    #[110942]
    #verify cancel button
    Wait For And Verify Content    xpath=//div[contains(text(),'Cancel')]    Cancel
    #Verify Clear Watch List
    Wait For And Verify Element    ${Clear_watch_list}
    #click Cancel buttton
    Wait For And Click Element     xpath=//div[contains(text(),'Cancel')]

    #[110943]
    #click clear list
    Wait For And Click Element    ${Clear_list}
    #click clear watch list
    Wait For And Click Element    ${Clear_watch_list}
    Sleep   1s
    #checking clear list button is disabled    
    Sleep    500ms
    Element Should Be Enabled     ${Clear_list}

    #[110931]
    # 2.At the top right corner "Clear list" option (disable state)
    Wait For And Verify Content              xpath= //div[@class="pr-4"]    Clear list
    CSS Verification                         xpath= //div[@class="border text-onBackground rounded-full px-4 py-1.5 cursor-not-allowed pointer-events-none border-borderPrimary text-[#878787] font-JioTypeLight"]    padding-right    16px
    CSS Verification                         xpath= //div[@class="border text-onBackground rounded-full px-4 py-1.5 cursor-not-allowed pointer-events-none border-borderPrimary text-[#878787] font-JioTypeLight"]     padding-left    16px
    
    # 3.At the center of page following message appears 
    CSS Verification                         xpath= //div[@class="w-[40%] h-full bg-surface flex flex-col justify-center items-center pt-6 rounded-2xl"]    justify-content    center
    
    #     i. No Videos! 
    Wait For And Verify Content              xpath= //div[@class="w-full h-full flex justify-center font-JioTypeMedium text-lg text-onSurface"]    No Videos!
    
    #    ii. Start adding videos to your watch list
    Wait For And Verify Content              xpath= //div[@class="w-full h-full flex justify-center font-JioTypeLight text-lg text-onSurface"]    Start adding videos to your watch list
    
    #   iii. "Find Popular Videos" option which is clickable.
    Wait For And Verify Content              xpath= //div[@class="text-onPrimary text-xs bg-primary rounded-full px-4 py-1.5 cursor-pointer mt-4 mb-8"]    Find Popular Videos 
    CSS Verification                         xpath= //div[@class="text-onPrimary text-xs bg-primary rounded-full px-4 py-1.5 cursor-pointer mt-4 mb-8"]    cursor    pointer

    #[110932]
    # Click on "Find Popular Videos" option
    Wait For And Click Element               xpath= //div[@class="text-onPrimary text-xs bg-primary rounded-full px-4 py-1.5 cursor-pointer mt-4 mb-8"]
    # User redirected to the Home Page of the  JioGames web watch
    URL Validation                           ${JioGamesWatchURL}