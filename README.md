# Oasis Cafe

This is a cafe application with a <b>Siren Order</b> function like the Starbucks app.

The Oasis cafe app project is a mobile application developed using the Flutter framework, implementing the MVVM (Model-View-ViewModel) architectural pattern. 
This application efficiently manages cafe orders and provides a high level of convenience to users.

</br>

## Table of content
* [General info](#general-info)
* [Tech stack](#tech-stack)
* [How to use](#how-to-use)
* [Menu tree](#menu-tree)
* [Screen shots](#screen-shots)
* [Folder Structure](#folder-structure)
* [Preview](#preview)

</br>

## General info
1. 개발 기간 : 2023.09 ~ 2024.01
2. 사이렌 오더 시스템 : Firebase Database를 이용하여 주문 데이터를 관리하며, 주문 상태를 업데이트합니다.  
3. MVVM 아키텍처 구현 : Flutter Provider 패키지를 사용하여 MVVM 아키텍처를 적용하여 코드를 모듈화하고, 유지보수성을 높였습니다.  
4. 사용자 편의성 강조 : Flutter의 풍부한 위젯 라이브러리를 활용하여 직관적이고 사용자 친화적인 UI를 구현하여 사용자 편의성을 강조하였습니다.  
5. Firebase 인증 및 데이터베이스 연동 : Firebase Authentication을 이용하여 사용자 인증을 처리하고, 주문 데이터를 Firebase Database에 저장하고 관리합니다.  

</br>

## Tech stack
<img src="https://img.shields.io/badge/androidstudio-34A853?style=for-the-badge&logo=androidstudio&logoColor=white">
<img src="https://img.shields.io/badge/firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=white">
<img src="https://img.shields.io/badge/flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white">
<img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white">
<img src="https://img.shields.io/badge/git-F05032?style=for-the-badge&logo=git&logoColor=white">

</br>

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

</br>


## Menu tree

* Customer app
<img width="649" alt="oasis_cafe_customer_menu_tree" src="https://github.com/NalaJang/oasis_cafe_app/assets/73895803/f245ad51-ea69-4516-84ca-4dced651fada">


## Screen shots
<img width="953" alt="oasis_app_customer_screen_shots" src="https://github.com/NalaJang/oasis_cafe_app/assets/73895803/e270f875-12db-41cd-9ea5-59857440b568">

</br>


## Folder Structure

    lib/
    |- config/ - contains configuration for widget views.
    |- model/ - contains all the plain data models.
    |- provider/ - contains all Provider models for each of the widget views.
    |- screens/ - the main folder that contains all UI.
    |- main.dart - the main.dart file for dev environment.

</br>

## Preview
|메뉴 주문|주문 상태, 거래 내역 확인|
|-------|-------------------|
|![oasis_cafe_app_order](https://github.com/NalaJang/oasis_cafe_app/assets/73895803/4983955e-1776-4424-aa6a-98f1eee9f57e)|![oasis_cafe_app_order_status](https://github.com/NalaJang/oasis_cafe_app/assets/73895803/12f743c3-63c3-4f0e-98b1-e575b79f43ab)|

