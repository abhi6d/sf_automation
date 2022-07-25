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
@{ROBOTS}=      Su    Mo    Tu



*** Test Cases ***
TEST CASE 001
    [Documentation]    Validate Isi pulsa and beli paket
    Login to SMARTFERN UI  ${SmartFern_CREDENTIAL}[username]  ${SmartFern_CREDENTIAL}[password]
    Click Item     ${ADD_REFERENCE_KEY}[Apps]

    #${data}=  Fetch From Excel  ${SMARTFREN_TESTDATA}  SMARTFERN_OUTLET_CREATION  TC_001  TD_01
    #@{DAY}=  getData  ${data}  Day

    ${L2}=  ['Su', 'Mo' ]

    ${present}=  Run Keyword And Return Status    Element Should Be Visible   ${ADD_REFERENCE_KEY}[DMS]
    Run Keyword If    ${present}    Click Item  ${ADD_REFERENCE_KEY}[DMS]

    Click Item  //span[text()='Channel Partner']
    Click Item  //a[normalize-space()='Outlet Mangement']
    Click Item  //div[contains(text(),' Create')]

    Set Dropdown  (//div[@class='css-bg1rzq-control Select__control'])[1]  Retail
    #Set Dropdown  (//div[@class='css-bg1rzq-control Select__control'])[2]  E-Load

    #Click Item  (//div[@class='css-bg1rzq-control Select__control'])[2]

    #Click Item  //div[contains(text(),'Mo')]
    #Click Item  //div[contains(text(),'Su')]

    FOR    ${robot}    IN    ${L2}
        Click Item  //div[contains(text(),'${robot}')]
    END
    #Execute JavaScript    textarea.value += 'Appended text';
    Sleep  10s
    Log To Console  ${data}

#    Click Item  //div[@class='css-1hwfws3 Select__value-container']
#    Click Item  //div[contains(text(),'DMS')]
#    Click Item  //div[contains(text(),' Next')]
#    Click Item  //div[contains(text(),' Create')]
#    Set Input  //input[@id='name__id']  Test_7
#    Set Input  //input[@id='value__id']  Test_7
#    Click Item  (//div[contains(text(),' Create')])[2]





















    #Verify elements is visible and displayed    <div>Successfully Created Configuration</div>
