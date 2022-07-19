*** Settings ***
Library     OperatingSystem
Library     SeleniumLibrary
Library    Collections
Library    String

Variables    ../../Resource/PageObjects/PageObjects.yaml
Variables    ../../Resource/PageObjects/TestData.yaml
Resource     ../../Resource/PageKeywords/Common.robot

*** Variables ***
${URL}      ${TestData}[URL]
${Broswer}  ${TestData}[Browser]
${Environment}      ${TestData}[Environment]

${LoginPage}      ${WKD}[LoginPage]
${SSO}      ${WKD}[SSOPage]
${TimeOut}      60s
${Start}        1s



*** Keywords ***

Login to SMARTFERN UI
    [Arguments]  ${user}  ${pass}
    Sleep  5s
    Set Input  ${LoginPage}[UserName]      ${user}
    Click Item   ${LoginPage}[NextButton]
    Sleep  4s
    Set Input  ${LoginPage}[Password]      ${pass}
    Click Item   ${LoginPage}[Loginbtn]
    Verify elements is visible and displayed  //div[text()='Dashboard']



