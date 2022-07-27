*** Settings ***
Documentation   Sample TestCase For Automation FrameWork
Library     SeleniumLibrary
Library     OperatingSystem
Resource    ../Resource/PageKeywords/SF_Login_Keyword.robot
Resource    ../Resource/PageKeywords/SF_UI_Keywords.robot


Resource    ../Resource/PageKeywords/Read_TestData_Keyword.robot
Library  ../Resource/TestData/Provision_Functions.py
Library  ../Resource/TestData/ReadDataFromExcel.py

Variables    ../Resource/PageObjects/PageObjects.yaml
Variables    ../Resource/PageObjects/TestData.yaml
Resource     ../Resource/PageKeywords/Common.robot

Library  OperatingSystem


Test Setup        Execute Suite Setup as User
Test Teardown     Execute Suite Teardown

*** Variables ***

${SMARTFREN_TESTDATA}     ${TestData}[SMARTFREN_TESTDATA]
${SmartFern_CREDENTIAL}     ${TestData}[USER][SmartFern_user_2]
${SMARTFREN_TESTDATA}     ${TestData}[SMARTFREN_TESTDATA]
${ISIPulsaDetailsPage}    ${wkd}[ISIPulsaDetailsPage]
${BeliPacketDetailsPage}    ${wkd}[BeliPacketDetailsPage]
${ADD_REFERENCE_KEY}  ${wkd}[ADD_REFERENCE_KEY]




*** Test Cases ***
TEST CASE 001
    [Documentation]    Validate Isi pulsa and beli paket
    Login to SMARTFERN UI  ${SmartFern_CREDENTIAL}[username]  ${SmartFern_CREDENTIAL}[password]
    Sleep  10s
    Click Item     ${ADD_REFERENCE_KEY}[Apps]
    Sleep  10s

    Sleep  10s
    #${data}=  Fetch From Excel  ${SMARTFREN_TESTDATA}  SMARTFERN_OUTLET_CREATION  TC_001  TD_01
    #@{DAY}=  getData  ${data}  Day


    ${present}=  Run Keyword And Return Status    Element Should Be Visible   ${ADD_REFERENCE_KEY}[DMS]
    Run Keyword If    ${present}    Click Item  ${ADD_REFERENCE_KEY}[DMS]


    Click Item  //span[text()='Approvals']

    Click Item  //a[normalize-space()='My Tasks']
    Sleep  10s

#    Click Item  //span[text()='Sales Structure']
#    Click Item  //a[normalize-space()='Sales Territory']
#
#    Click Item  (//i[contains(@aria-hidden,'true')])[1]
#    Click Item  (//button[contains(@role,'menuitem')][normalize-space()='Create'])[1]
#    Set Input  //input[@id='greaterRegionCode__id']  0962
#    Set Input  //input[@id='locationName__id']  est_0962
#
#    Click Item  //div[contains(text(),' Save')]
#
#    ## ---------------------------------------- CREATING REGION-----------------------------------------------------
#
#    Click Item  (//i[contains(@class,'fa fa-ellipsis-h')])[7]
#
#    Sleep  10s

## ---------------------------------------------------------------------------------------------

#    Set Dropdown  (//div[@class='css-bg1rzq-control Select__control'])[1]  Retail
#    #Set Dropdown  (//div[@class='css-bg1rzq-control Select__control'])[2]  E-Load
#
#    #Click Item  (//div[@class='css-bg1rzq-control Select__control'])[2]
#
#    Click Item  //textarea[@id='address__id']
#    input value on text fields         //textarea[@id='address__id']     8765556777
#
#    #Execute JavaScript    textarea.value += 'Appended text';
#    Sleep  10s
#
#
#    Click Item  //div[@class='css-1hwfws3 Select__value-container']
#    Click Item  //div[contains(text(),'DMS')]
#    Click Item  //div[contains(text(),' Next')]
#    Click Item  //div[contains(text(),' Create')]
#    Set Input  //input[@id='name__id']  Test_7
#    Set Input  //input[@id='value__id']  Test_7
#    Click Item  (//div[contains(text(),' Create')])[2]
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#    Verify elements is visible and displayed    <div>Successfully Created Configuration</div>
