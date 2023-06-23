*** Settings ***
Library                      SeleniumLibrary
Resource                     ../../Resources/Common.robot 
Variables                    ../../Resources/Common_Variables.yaml
Variables                    ../../Tests/My_Watchlist/My_Watchlist.yaml
*** Keywords ***

Landing on MyWatchlist Page
#Hover on the ">" icon at the top left and select "History" tab.
    Mouse Over                    xpath= //div[@class="flex w-full cursor-pointer items-center"]
    #Click on Collapse menu
    Sleep                            500ms
    #Wait For And Verify Element                xpath=//div[@class="flex flex-col w-76 h-full bg-surface"]
    Wait For And Click Element    xpath= //a[contains(normalize-space(),"My Watchlist")]
    #User lands on MyWatchList Web "History" Page.
    URL Validation                https://watch-prod.api.engageapps.jio/watchlist
    Wait For And Click Element                    xpath=//div[@class="flex p-4"]
    Set Screenshot Directory      ./Results/My_WatchList/Screenshots
    Sleep    250ms    

