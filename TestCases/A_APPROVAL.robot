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
${SmartFern_CREDENTIAL}     ${TestData}[USER][SmartFern_user_4]
${SMARTFREN_TESTDATA}     ${TestData}[SMARTFREN_TESTDATA]
${ISIPulsaDetailsPage}    ${wkd}[ISIPulsaDetailsPage]
${BeliPacketDetailsPage}    ${wkd}[BeliPacketDetailsPage]
${ADD_REFERENCE_KEY}  ${wkd}[ADD_REFERENCE_KEY]




*** Test Cases ***
TEST CASE 001
    [Documentation]    Validate Isi pulsa and beli paket
    Login to SMARTFERN UI  ${SmartFern_CREDENTIAL}[username]  ${SmartFern_CREDENTIAL}[password]
    Sleep  5s
    Click Item     ${ADD_REFERENCE_KEY}[Apps]

    #${data}=  Fetch From Excel  ${SMARTFREN_TESTDATA}  SMARTFERN_OUTLET_CREATION  TC_001  TD_01
    #@{DAY}=  getData  ${data}  Day


    ${present}=  Run Keyword And Return Status    Element Should Be Visible   ${ADD_REFERENCE_KEY}[DMS]
    Run Keyword If    ${present}    Click Item  ${ADD_REFERENCE_KEY}[DMS]


    Click Item  //span[text()='Approvals']
    Click Item  //a[normalize-space()='My Tasks']
    Click Item  (//span//img[@src='/sfdms/images/view.svg'])[1]
    Click Item  //div[normalize-space()='Approve']
    Set TextArea  //textarea[@id='rejectMessage__id']  Submit
    Click Item  (//div[normalize-space()='Confirm'])[2]
    Sleep  10s
