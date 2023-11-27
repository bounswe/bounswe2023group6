# Project Development Weekly Progress Report

**Team Name:** Group 6 - Game Forum

**Date:** 14.11.2023

## Progress Summary
**This week** focused on developing user interfaces about our project. In mobile and frontend, we implemented profile page and update our home page with respect to our mockups. In addition, we improved our UIs in order to make them similar to mockups:
- Update profile page.
- Update wiki page.
- Start to implement gamepage on frontend and backend.
- Start to implement cors and database migration configurations.
- Update the logic about saving pages on database.

**Our objective for the following week** will be to developing gamepage, forum page and post page. In addition implementing profile and gamepage-related endpoints.

## What was planned for the week? How did it go?

| Description | Issue | Assignee | Due | PR | Estimated Duration | Actual Duration | 
| -------- | ----- | -------- | --- | --- | --- | --- |
| Determining proper components for the UI | [#356](https://github.com/bounswe/bounswe2023group6/issues/356) | All Frontend Team | 08.11.2023 | | 2hr | 1hr |
| Modifying sidebar logic & editing headers and footers | [#357](https://github.com/bounswe/bounswe2023group6/issues/357) | Halis Ayberk Erdem | 21.11.2023 | | 2hr | 2hr |
| Creating profile page for front-end  | [#358](https://github.com/bounswe/bounswe2023group6/issues/358) | Hüseyin Çivi | 21.11.2023 | | 3hr | 3hr|
| Editing Game Page | [#359](https://github.com/bounswe/bounswe2023group6/issues/359) | Beyzanur Bektan | 28.11.2023 | [#378](https://github.com/bounswe/bounswe2023group6/pull/378) | 3hr | 3hr|
| Home Page Styling | [#360](https://github.com/bounswe/bounswe2023group6/issues/360) | Ömer Talip Akalın | 21.11.2023 | | 3hr |  |
| Modifying Login/Register Pages | [#361](https://github.com/bounswe/bounswe2023group6/issues/361) | Melih Portakal | 14.11.2023 | | 3hr | 3hr |
| Editing Images on the Homepage | [#362](https://github.com/bounswe/bounswe2023group6/issues/362) | Beyzanur Bektan | 14.11.2023 | [#372](https://github.com/bounswe/bounswe2023group6/pull/372) | 3hr | 2hr |
| [Mobile] Profile Page initial implementation | [#363](https://github.com/bounswe/bounswe2023group6/issues/363) | Erkam Kavak | 14.11.2023 | [#371](https://github.com/bounswe/bounswe2023group6/pull/371) [#373](https://github.com/bounswe/bounswe2023group6/pull/373) | 4hr | 5hr  |
| [Mobile] Profile Photo Update Page implementation | [#366](https://github.com/bounswe/bounswe2023group6/issues/366) | Mustafa Küçük | 14.11.2023 | | 2hr | 3hr |
| [Mobile] Update Wiki Page | [#377](https://github.com/bounswe/bounswe2023group6/issues/377) | Umut Demir | 14.11.2023 |[#380](https://github.com/bounswe/bounswe2023group6/pull/380)|  4hr | 3hr |
| [Mobile] Update Navigation Bar  | [#374](https://github.com/bounswe/bounswe2023group6/issues/374) | Umut Demir | 14.11.2023 | [#381](https://github.com/bounswe/bounswe2023group6/pull/381) | 4hr | 2hr|
| [Backend] Changing in the registration - Milestone 1 Feedback | [#364](https://github.com/bounswe/bounswe2023group6/issues/364) | Emre Türker | 14.11.2023 |  | 2hr | - |
| [Backend] Changing the location of uploading an image - Milestone 1 Feedback | [#365](https://github.com/bounswe/bounswe2023group6/issues/365) | Emre Türker | 14.11.2023 |  | 2hr | - |
| [Backend] Doing a task sharing for implementing the profile page | [#367](https://github.com/bounswe/bounswe2023group6/issues/367) | All Backend Team | 12.11.2023 |  | 2hr | - |
| [Backend] Adding the Flyway package | [#368](https://github.com/bounswe/bounswe2023group6/issues/368) | Ahmet Kudu | 14.11.2023 |  | 4hr | - |
| [Backend] Adding the CORS package | [#369](https://github.com/bounswe/bounswe2023group6/issues/369) | Ahmet Kudu | 14.11.2023 |  | 4hr | - |


## Completed tasks that were not planned for the week

| Description  | Issue | Assignee | Due | PR |
| -------- | ----- | -------- | --- | --- |
|  |  |  |  |  |

## Planned vs. Actual

## Important UI/UX Features For Our Project

### Three features for our project 
**Feature 1: List and Grip Mode**

  - **Description:**  This feature introduces a versatile List and Grid mode, allowing users to seamlessly switch between a list-based and grid-based view for improved content exploration and organization.

  - **UI Component:** The UI component for this feature includes a toggle button or an option in the user interface that enables users to switch between List and Grid modes.

  - **UX Benefit:** Users gain flexibility in how they view and interact with content. List mode offers a detailed and sequential presentation, while Grid mode provides a visual overview, catering to different user preferences and improving the overall user experience.

**Feature 2: Bottom Navigation Bar**

  - **Description:** The Bottom Navigation Bar is a persistent UI element located at the bottom of the screen, offering quick access to primary app sections or features.

  - **UI Component:** The Bottom Navigation Bar is a visual element typically composed of icons or labels representing different app sections. Users can tap on these icons or labels to navigate directly to the corresponding section.

  - **UX Benefit:** Users benefit from improved navigation efficiency, as critical app functionalities are easily accessible with a single tap. This feature enhances overall user experience by reducing the effort required for navigation.

**Feature 3: Side Bar**

  - **Description:** The Side Bar is a slide-in menu or panel located at the side of the screen, providing access to secondary actions, settings, or additional content.

  - **UI Component:** The UI component for the Side Bar is a visually distinct panel that can be triggered by gestures or buttons, revealing additional options or information.

  - **UX Benefit:** The Side Bar optimizes screen space by offering a space-efficient way to access less frequently used features or settings. Users experience improved navigation and discoverability of app functionalities, contributing to a more user-friendly interface.

### Two features that would be nice to have 

**Feature 1: Dark Mode**

  - **Description:** Introduce a dark mode option for the platform's interface, allowing users to switch between a light and dark color scheme.

  - **UI Component:** Include a toggle switch in the user settings or as a quick-access button on the platform's main interface to enable/disable dark mode.

  - **UX Benefit:** Dark mode provides users with an alternative visual style that can be less straining on the eyes, especially in low-light environments. It enhances user comfort and accessibility, catering to a diverse user base with different preferences.

**Feature 2: Real-time Notifications**

  - **Description:** Implement real-time notifications to keep users informed about activities related to their profile, posts, or interactions within the platform.

  - **UI Component:** Integrate a notification icon or panel that displays the number of new notifications. Include a dropdown or modal to show detailed information about each notification.

  - **UX Benefit:** Real-time notifications improve user engagement by instantly notifying users about relevant activities, such as new followers, comments on their posts, or group invitations. This feature enhances the sense of community and ensures that users stay up-to-date with their platform interactions.

## Your plans for the next week
| Description | Issue | Assignee | Due | Estimated Duration |
| --- | --- | --- | --- | --- |
|[Mobile] Create/Update GamePage|[#386](https://github.com/bounswe/bounswe2023group6/issues/386)| Umut Demir | 21.11.2023 | 4hr|
|[Mobile] Forum Post Page Initial Implementation |[#387](https://github.com/bounswe/bounswe2023group6/issues/387)| Erkam Kavak | 21.11.2023 | 4hr|
|[Mobile] Profile page fix missing |[#388](https://github.com/bounswe/bounswe2023group6/issues/388)| Erkam Kavak | 21.11.2023 | 1-1.5hr|
|[Frontend] Forum Page Implementation |[#390](https://github.com/bounswe/bounswe2023group6/issues/390)| Beyzanur Bektan | 21.11.2023 | 4hr|
|[Backend] Gamepage related backend layers |[#393](https://github.com/bounswe/bounswe2023group6/issues/393)| Ahmet Kudu | 19.11.2023 | 3hr|
|[Backend] Researching AWS S3 for Image Storage |[#392](https://github.com/bounswe/bounswe2023group6/issues/392)| Emre Türker | 19.11.2023 | 3hr|
|[Backend] Entity classes implementation |[#391](https://github.com/bounswe/bounswe2023group6/issues/391)| Ömer Bahadıroğlu | 17.11.2023 | 3hr|
|[Frontend] Post Creation Section |[#389](https://github.com/bounswe/bounswe2023group6/issues/389)| Hüseyin Çivi | 21.11.2023 | 4hr|
|[Frontend] Implementation of create game page |[#394](https://github.com/bounswe/bounswe2023group6/issues/394)| Halis Ayberk Erdem | 20.11.2023 | 4hr|

## Participants
- Ahmet Kudu
- Beyzanur Bektan
- Emre Türker
- Erkam Kavak
- Halis Ayberk Erdem
- Hüseyin Çivi
- Muhammet Mustafa Küçük
- Ömer Bahadıroğlu
- Emre Sin
- Süleyman Melih Portakal
- Umut Demir

