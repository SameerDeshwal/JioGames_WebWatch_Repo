*** Settings ***
Library                             SeleniumLibrary
Library                             ExcelLibrary
Library                             RequestsLibrary
Library                             String
Library                             Collections
Library                             Dialogs
Variables                           Common_Variables.yaml
*** Keywords ***
Begin Web Test
    Open Excel Document         filename=Resources/JioGames Watch.xlsx    doc_id=JioGames Watch
    Open Browser                about:blank     ${Browser}
    Maximize Browser Window
End Web Test
    Close All Excel Documents 
    Close Browser

Visit Jio Games Web Watch and Login
    Visit Jio Games Web Watch
    Login to Jio Games Web Watch

Visit Jio Games Web Watch
    Go To                                ${URL}
    Sleep                                500ms

Login to Jio Games Web Watch
    Wait For And Input Text              xpath=//input[@placeholder='Mobile Number']    ${Mobile}
    Wait For And Input Password          xpath=//input[@placeholder='Password']         ${Password}
    Wait For And Click Element           xpath=//div[@class="rounded-full px-4 py-1 border border-primary text-xs leading-4 bg-primary text-onSecondary font-JioTypeLight hover:bg-primary-900 cursor-pointer"]
    Sleep                                2s

Take Page Screenshot    
    [Arguments]     ${Sc_Name}
    Sleep   200ms
    TRY
        Capture Page Screenshot        ${Sc_Name}.png
    EXCEPT
        Log  Issue While Taking Screenshot!!
    END
Take Element Screenshot
    [Arguments]     ${locator}      ${SC_name}
    Sleep   200ms
    Capture Element Screenshot      ${locator}      ${SC_name}.png
    #Set Screenshot Directory    JioGames\Results\Screenshots
Redirection On Clicking
   [Arguments]       ${Button}          ${WebPageURL}    ${Sc_name}
    Scroll Down                         ${Button}
    Wait For And Click Element          ${Button}
    Sleep     1s
    URL Validation                      ${WebPageURL}
    Take Screenshot                     ${Sc_name}
    Go Back
    Log To Console                      ${Sc_name} Redirection Successful
Wait For And Click Element
    [Arguments]                             ${locator}
    Wait Until Element Is Visible           ${locator}
    Click Element                           ${locator}
    Sleep   50ms 
Wait For And Input Text
    [Arguments]                             ${locator}     ${text}
    Wait Until Element Is Visible           ${locator}
    Sleep    100ms
    Input Text                              ${locator}     ${text}
Wait For And Input Password
    [Arguments]                             ${locator}     ${password}
    Wait Until Element Is Visible           ${locator}
    Sleep    100ms
    Input Password                          ${locator}     ${password}
Wait For And Verify Content
    [Arguments]                             ${locator}      ${str}
    Wait Until Element Is Visible           ${locator}
    Sleep   200ms
    Element Should Contain                  ${locator}      ${str}
Wait For And Verify Element
    [Arguments]     ${locator}
    Wait Until Element Is Visible           ${locator}
    Wait Until Page Contains Element        ${locator}
URL Validation
    [Arguments]                 ${VURL}
    Sleep  500ms
    Wait Until Location Is      ${VURL}
Image Verification
    [Arguments]                                 ${locator}
    Wait Until Element Is Visible               ${locator}
    Page Should Contain Image                   ${locator}
    ${img src}=     Get element attribute       ${locator}      src
    Log To Console    --------${img src}
    Create Session      img     ${img src}
    ${resp_google}=   GET On Session  img  ${img src}     expected_status=200
Section Verification
    [Arguments]     ${locator}      ${name}
    Scroll Down                     ${locator}
    Wait For And Verify Element     ${locator}
    Sleep  0.5s
    Log To Console      ${name} Section is Visible
Scroll Down
    [Arguments]                         ${locator}
    Sleep   100ms
    Run Keyword And Ignore Error    Scroll Element Into View            ${locator}
Text Verification
    [Arguments]                             ${locator}          ${title}
    Wait Until Element Is Visible           ${locator}
    Element Text Should Be                  ${locator}          ${title}
CSS Verification
    [Arguments]    ${locator}    ${attribute name}  ${attribute_value}
    ${css}=         Get WebElement    ${locator}
    ${prop_val}=    Call Method       ${css}    value_of_css_property    ${attribute name}
    Should Be Equal As Strings    ${prop_val}    ${attribute_value}
Element Should Have Class
    [Arguments]                             ${element}    ${className}
    Wait Until Page Contains Element        ${element}\[contains(@class, '${className}')]
    Sleep    500ms
Wait For And Mouse Over Element
    [Arguments]                             ${locator}
    Wait Until Element Is Visible           ${locator}
    Mouse Over                              ${locator}
    Sleep   50ms
Save Password as Global Variable
    Set Log Level    None
    ${Password} =   Get Value From User    Input password    hidden=yes    default_value=Abc1234@
    Set Global Variable               ${Password}                                ${Password}
    Set Log Level    Info

Change Tab
    [Arguments]     ${title}
    Sleep   100ms
    Switch Window                       title=${title}
    Sleep   100ms

Reloading Page
    Reload Page
    Sleep  200ms

Scroll To
    [Arguments]                         ${locator}
    Sleep   100ms
    TRY
        Wait Until Keyword Succeeds     3 sec   0 sec   Scroll Element Into View            ${locator}
        Wait Until Element Is Visible           ${locator}
    EXCEPT
        Log  Issue While Scrolling!!
    END  

Take Element Text
    [Arguments]     ${Elocator}
    Wait Until Element Is Visible           ${Elocator}      timeout=5s
    ${temp}=    Get Text    ${Elocator}
    [Return]    ${temp}

Wait For And Long Press
    [Arguments]                             ${locator}
    Wait Until Element Is Visible           ${locator}
    Click Element                           ${locator}
    Sleep   1s
