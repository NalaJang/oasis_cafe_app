# Oasis Cafe

스타벅스 앱과 같은 사이렌오더 기능을 갖춘 카페 어플리케이션입니다.

Oasis 카페 앱 프로젝트는 Flutter 프레임워크를 사용하여 개발된 모바일 애플리케이션으로 카페 주문을 효율적으로 관리하고 사용자에게 높은 수준의 편의성을 제공합니다.

**<기획 배경>**  
뉴질랜드에서 생활 당시, 외국인으로서 다른 나라의 생소한 음식을 글만으로 이해하기 어려웠습니다. 저와 같은 외국인도 새로운 문화에 쉽게 다가갈 수 있는 서비스를 만들고 싶었습니다.

<br></br>

## Table of content
* [General info](#general-info)
* [Tech stack](#tech-stack)
* [How to use](#how-to-use)
* [Menu tree](#menu-tree)
* [Screen shots](#screen-shots)
* [Folder Structure](#folder-structure)
* [Preview](#preview)

<br></br>

## General info
**1. 개발 기간**  
    > 2023.09 ~ 2024.01  <br></br>
**2. 개발 인원**  
    > 1명    <br></br>
**3. 사이렌 오더 시스템**  
    > Firebase Database를 이용하여 주문 데이터를 관리하며, 주문 상태를 업데이트합니다.  
    > LocalNotificatoin 알림으로 주문 진행 상태 알립니다.  
    > 사용자 기기의 알람 허용 여부를 확인 후 알림이 거부 되어있을 경우, 사용자를 기기 설정으로 유도합니다.  <br></br>
**4. MVVM 아키텍처 구현**  
    > Flutter Provider 패키지를 사용하여 MVVM 아키텍처를 적용하여 코드를 모듈화하고, 유지보수성을 높였습니다.  <br></br>
**5. 사용자 편의성 강조**  
    > Flutter의 풍부한 위젯 라이브러리를 활용하여 직관적이고 친화적인 UI를 위해 대중적인 스타벅스 앱을 클론하였습니다.  
    > 메뉴 커스텀 기능을 구현하였습니다.  
    > 전자 영수증 메뉴에서 선택된 기간에 대한 과거 주문 내역 확인 기능을 구현하였습니다.  <br></br>
**6. Firebase 인증 및 데이터베이스 연동**  
    > Firebase Authentication을 이용하여 사용자 인증을 처리합니다.  
    > FlutterSecureStorage로 사용자 정보를 저장하고 자동 로그인 구현하였습니다.  
    > Firebase Database를 이용하여 주문 데이터를 관리하고 주문 상태를 업데이트합니다.  <br></br>
**7. Localizaions**  
    > 한국어와 영어를 지원합니다. 사용자는 언제든지 선호하는 언어로 앱을 쉽게 이용할 수 있습니다.

<br></br>

## Tech stack
<img src="https://img.shields.io/badge/androidstudio-34A853?style=for-the-badge&logo=androidstudio&logoColor=white">
<img src="https://img.shields.io/badge/firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=white">
<img src="https://img.shields.io/badge/flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white">
<img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white">
<img src="https://img.shields.io/badge/git-F05032?style=for-the-badge&logo=git&logoColor=white">

<br></br>

## How to use
### step 1:
Clone this project.

    git clone https://github.com/NalaJang/oasis_cafe_app.git


### step 2:
Open the project folder with VS Code/Android Studio and execute the following command to install all dependencies packages.

    flutter pub get


### step 3:
Go to your [Firebase](https://console.firebase.google.com/u/0/) console. Create a new Firebase project.
Register your app. Complete the rest of the step require.

### step 4:
Try launch the app.

<br></br>


## Menu tree

* Customer app
<img width="649" alt="oasis_cafe_customer_menu_tree" src="https://github.com/NalaJang/oasis_cafe_app/assets/73895803/f245ad51-ea69-4516-84ca-4dced651fada">


## Screen shots
<img width="953" alt="oasis_app_customer_screen_shots" src="https://github.com/NalaJang/oasis_cafe_app/assets/73895803/e270f875-12db-41cd-9ea5-59857440b568">

<br></br>


## Folder Structure

    lib/
    |- config/ - contains configuration for widget views.
    |- model/ - contains all the plain data models.
    |- provider/ - contains all Provider models for each of the widget views.
    |- screens/ - the main folder that contains all UI.
    |- main.dart - the main.dart file for dev environment.

<br></br>

## Preview
* 메뉴 주문 및 확인

|메뉴 주문|주문 상태, 거래 내역 확인|
|-------|-------------------|
|![oasis_cafe_app_order](https://github.com/NalaJang/oasis_cafe_app/assets/73895803/4983955e-1776-4424-aa6a-98f1eee9f57e)|![oasis_cafe_app_order_status](https://github.com/NalaJang/oasis_cafe_app/assets/73895803/12f743c3-63c3-4f0e-98b1-e575b79f43ab)|

<br></br>

* 다국어 지원

|한국어|영어|
|----|---|
|![oasis_cafe_app_ko1](https://github.com/NalaJang/oasis_cafe_app/assets/73895803/b78f45e3-dd82-4ac7-999a-6b3739f4cdb3)|![oasis_cafe_app_en1](https://github.com/NalaJang/oasis_cafe_app/assets/73895803/1668eab6-0313-4c3c-a039-8c9248017245)|
|![oasis_cafe_app_ko2](https://github.com/NalaJang/oasis_cafe_app/assets/73895803/05e680a0-d187-4766-804c-de7e8f322443)|![oasis_cafe_app_en2](https://github.com/NalaJang/oasis_cafe_app/assets/73895803/0a7bc46f-7bba-4e4b-942d-b5a80f1ca17e)|
