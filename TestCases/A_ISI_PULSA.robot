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
${SmartFern_CREDENTIAL}     ${TestData}[USER][SmartFern_user]
${SMARTFREN_TESTDATA}     ${TestData}[SMARTFREN_TESTDATA]
${ISIPulsaDetailsPage}    ${wkd}[ISIPulsaDetailsPage]
${BeliPacketDetailsPage}    ${wkd}[BeliPacketDetailsPage]

*** Test Cases ***
TEST CASE 001
    [Documentation]    Validate Isi pulsa and beli paket
    Login to SMARTFERN UI  ${SmartFern_CREDENTIAL}[username]  ${SmartFern_CREDENTIAL}[password]

    ${row}=  Read Number of Rows  ${SMARTFREN_TESTDATA}  SMARTFREN_ISI_PULSA

    Click Item     ${ISIPulsaDetailsPage}[Apps]
    Click Item     ${ISIPulsaDetailsPage}[POSApp]
    Click Item     ${ISIPulsaDetailsPage}[ISIPulsa]

    FOR  ${i}  IN RANGE  0  ${row}-1

        ${data}=  Fetch Row Data  ${SMARTFREN_TESTDATA}  SMARTFREN_ISI_PULSA  ${i}

        ${RP_Value}=  get_Value1  ${data}  RP_Value
        ${MDN_NUMBER}=  get_Value1  ${data}  MDN_Number
        ${PAYMENT_TYPE}=  get_Value1  ${data}  Payment_Type
        ${PIN_NUMBER_DIGIT1}=  get_Value1  ${data}  PIN_NUMBER_Digit1
        ${PIN_NUMBER_DIGIT2}=  get_Value1  ${data}  PIN_NUMBER_Digit2
        ${PIN_NUMBER_DIGIT3}=  get_Value1  ${data}  PIN_NUMBER_Digit3
        ${PIN_NUMBER_DIGIT4}=  get_Value1  ${data}  PIN_NUMBER_Digit4
        ${PIN_NUMBER_DIGIT5}=  get_Value1  ${data}  PIN_NUMBER_Digit5
        ${PIN_NUMBER_DIGIT6}=  get_Value1  ${data}  PIN_NUMBER_Digit6

#        Log To Console  -------------------------------
#        Log To Console  ${RP_Value}
#        Log To Console  ${MDN_NUMBER}
#        Log To Console  ${PAYMENT_TYPE}
#        Log To Console  ${PIN_NUMBER_DIGIT1}
#        Log To Console  ${PIN_NUMBER_DIGIT2}
#        Log To Console  ${PIN_NUMBER_DIGIT3}
#        Log To Console  ${PIN_NUMBER_DIGIT4}
#        Log To Console  ${PIN_NUMBER_DIGIT5}
#        Log To Console  ${PIN_NUMBER_DIGIT6}
#        Log To Console  -------------------------------

        Set Input      ${ISIPulsaDetailsPage}[InputMDN]  ${MDN_NUMBER}
        Click Item     ${ISIPulsaDetailsPage}[InputMDNProceedButton]
        Set Input      ${ISIPulsaDetailsPage}[InputRPValue]  ${RP_VALUE}
        Click Item     ${ISIPulsaDetailsPage}[RPValueAddButton]
        Set Dropdown3  ${ISIPulsaDetailsPage}[PaymentTypeDropdown]  ${PAYMENT_TYPE}
        Click Item     ${ISIPulsaDetailsPage}[FinalProccedButton]
        Set Input      ${ISIPulsaDetailsPage}[PINDigit1]   ${PIN_NUMBER_DIGIT1}
        Set Input      ${ISIPulsaDetailsPage}[PINDigit2]   ${PIN_NUMBER_DIGIT2}
        Set Input      ${ISIPulsaDetailsPage}[PINDigit3]   ${PIN_NUMBER_DIGIT3}
        Set Input      ${ISIPulsaDetailsPage}[PINDigit4]   ${PIN_NUMBER_DIGIT4}
        Set Input      ${ISIPulsaDetailsPage}[PINDigit5]   ${PIN_NUMBER_DIGIT5}
        Set Input      ${ISIPulsaDetailsPage}[PINDigit6]   ${PIN_NUMBER_DIGIT6}
        Click Item     ${ISIPulsaDetailsPage}[ConfirmButton]
        Verify elements is visible and displayed    ${ISIPulsaDetailsPage}[TranscationSuccessfulltext]
        capture page screenshot  ${SCREENSHOT_LOC}/Img_1.png
        ${TranscationStatus}=  get text    ${ISIPulsaDetailsPage}[TranscationSuccessfulltext]
        log to console   ${TranscationStatus}
        Verify elements is visible and displayed    ${ISIPulsaDetailsPage}[TranscationId]
        capture page screenshot  ${SCREENSHOT_LOC}/Img_2.png
        ${Transcationid}=  get text    ${ISIPulsaDetailsPage}[TranscationId]
        log to console   ${Transcationid}
        capture page screenshot  ${SCREENSHOT_LOC}/Img_3.png
        Click Item     ${ISIPulsaDetailsPage}[TranscationOk]
        capture page screenshot  ${SCREENSHOT_LOC}/Img_4.png

    END



