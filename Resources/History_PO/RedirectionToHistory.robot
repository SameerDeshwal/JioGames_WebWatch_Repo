*** Settings ***
Library                      SeleniumLibrary
Resource                     ../../Resources/Common.robot 
Variables                    ../../Resources/Common_Variables.yaml

*** Keywords ***

Landing on History Page                   
#Hover on the ">" icon at the top left and select "History" tab.
    Mouse Over                    xpath= //div[@class="flex w-full cursor-pointer items-center"]
    #Click on Collapse menu
    Sleep                            500ms
    #Wait For And Verify Element                xpath=//div[@class="flex flex-col w-76 h-full bg-surface"]
    Wait For And Click Element    xpath= //a[contains(normalize-space(),"History")]
    #User lands on MyWatchList Web "History" Page.
    URL Validation                https://watch-prod.api.engageapps.jio/history
    Wait For And Click Element                    xpath=//div[@class="flex p-4"]
    Set Screenshot Directory      ./Results/History/Screenshots
    Sleep    250ms    
