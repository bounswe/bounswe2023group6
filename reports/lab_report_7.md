# Project Development Weekly Progress Report

**Team Name:** Group 7 - Game Forum

**Date:** 22.11.2023

## Progress Summary
**This week** focused on developing user interfaces and creating related backend endpoints. In mobile and frontend, we implemented forum page and update our post page with respect to our mockups. In addition, we improved our UIs in order to make them similar to mockups:
- Creation and updating of game page.
- Initial implementation of forum post page.
- Profile Page enhancements.
- Game Page related endpoints.

**Our objective for the following week** will be to integrate game, forum and post pages.

## What was planned for the week? How did it go?

| Description | Issue | Assignee | Due | PR | Estimated Duration | Actual Duration | 
| -------- | ----- | -------- | --- | --- | --- | --- |
|[Mobile] Create/Update GamePage|[#386](https://github.com/bounswe/bounswe2023group6/issues/386)| Umut Demir | 21.11.2023 |  | 4hr|
|[Mobile] Forum Post Page Initial Implementation |[#387](https://github.com/bounswe/bounswe2023group6/issues/387)| Erkam Kavak | 21.11.2023 | [#408](https://github.com/bounswe/bounswe2023group6/pull/408) | 4hr| 4hr
|[Mobile] Profile page fix missing |[#388](https://github.com/bounswe/bounswe2023group6/issues/388)| Erkam Kavak | 21.11.2023 | | 1-1.5hr| 1hr|
| [Backend] Adding the CORS package | [#369](https://github.com/bounswe/bounswe2023group6/issues/369) | Ahmet Kudu | 14.11.2023 | [#432](https://github.com/bounswe/bounswe2023group6/pull/432) | 3hr | 2hr |
| [Backend] Adding the Flyway package | [#368](https://github.com/bounswe/bounswe2023group6/issues/368) | Ahmet Kudu | 14.11.2023  | [#412](https://github.com/bounswe/bounswe2023group6/pull/412) | 3hr | 4hr |
|[Backend] Gamepage related backend layers |[#393](https://github.com/bounswe/bounswe2023group6/issues/393)| Ahmet Kudu | 19.11.2023 |  | 3hr| - |
|[Backend] Researching AWS S3 for Image Storage |[#392](https://github.com/bounswe/bounswe2023group6/issues/392)| Emre Türker | 19.11.2023 |  | 3hr| 
|[Backend] Entity classes implementation |[#391](https://github.com/bounswe/bounswe2023group6/issues/391)| Ömer Bahadıroğlu | 17.11.2023 |  [#398](https://github.com/bounswe/bounswe2023group6/pull/398)| 3hr| 4hr
|[Frontend] Post Creation Section |[#389](https://github.com/bounswe/bounswe2023group6/issues/389)| Hüseyin Çivi | 21.11.2023 | | 4hr|
|[Frontend] Implementation of create game page |[#394](https://github.com/bounswe/bounswe2023group6/issues/394)| Halis Ayberk Erdem | 20.11.2023 | [#378](https://github.com/bounswe/bounswe2023group6/pull/378) | 4hr| 5hr
|[Frontend] Forum Page Implementation |[#390](https://github.com/bounswe/bounswe2023group6/issues/390)| Beyzanur Bektan | 21.11.2023 | [#410](https://github.com/bounswe/bounswe2023group6/pull/410) | 4hr | 4hr




## Completed tasks that were not planned for the week

| Description  | Issue | Assignee | Due | PR |
| -------- | ----- | -------- | --- | --- |
|  |  |  |  |  |

## Planned vs. Actual

## Scenarios For The Demo Day

### Scenario 1: Enhanced Profile Management

**Description:** Alex, a passionate gamer, decides to revamp their profile on the gaming platform for greater engagement. After logging in, Alex heads to their profile page and begins by updating their profile picture with a recent one. Next, they refine the 'About' section, highlighting their latest gaming interests and achievements. To further tailor their profile, Alex adds new tags that align with their favorite game genres and removes any that are no longer relevant. They spend some time reviewing their like history and examining the list of posts and LFGs (Looking for Group) they've created, contemplating updates that could boost their interaction with the community and enhance their social footprint on the platform.

**Satisfied Requirements:**
- **1.1.1.3**: Users shall be able to login and logout to the platform.
- **1.1.2.1**: Users shall be able to show their own profile pages.
- **1.1.2.4**: Users shall be able to edit their profile pictures on the profile page.
- **1.1.2.5**: Users shall be able to edit their about sections on the profile page.
- **1.1.2.8**: Users shall be able to have tags on the profile page.
- **1.1.2.10**: Users shall be able to show their like history on their profile page.
- **1.1.2.11**: Users shall be able to edit the tags on their profile.
- **1.1.2.12**: Users shall be able to show the posts, game pages, and LFGs that they own, on their profile.

### Scenario 2: Active Participation in the Forum
**Description:** Maria, an active member of the gaming community, engages deeply with the forum. After logging in, she reads through various posts and finds one that particularly interests her. She contributes a thoughtful comment and upvotes the post to acknowledge its quality. Inspired by this interaction, Maria decides to share her own gaming experiences in a new post, carefully adding relevant tags to ensure it reaches the right audience. Her post attracts several comments from other users. Maria actively responds to these comments, providing additional insights and updating her post based on the discussions. She also comes across a few comments that breach the community guidelines and takes the responsibility to report them.

**Satisfied Requirements:**
- **1.1.3.2.1**: Users shall be able to create posts.
- **1.1.3.2.2**: Users shall be able to update their posts.
- **1.1.3.2.4**: Users shall be able to create comments.
- **1.1.3.2.5**: Users shall be able to update their comments.
- **1.1.3.2.7**: Users shall be able to report posts.
- **1.1.3.2.8**: Users shall be able to report comments.
- **1.1.3.2.9**: Users shall be able to upvote posts.
- **1.1.3.2.13**: Users shall be able to add tags to their posts.
- **1.1.3.2.14**: Users shall be able to reply to posts.
- **1.1.3.2.15**: Users shall be able to reply to comments.
- **1.2.2.1**: Posts that are created by users shall be visible in the forum.
- **1.2.2.3**: Related tags of the posts shall be visible in the forum.
- **1.2.2.4**: Number of upvotes given to the posts shall be visible in the forum.
- **1.2.2.6**: Number of upvotes given to the comments shall be visible in the forum.

### Scenario 3: Game Page Management and Update

**Description:** John, a game developer, creates a page for his new RPG-Strategy game on the gaming platform. He enters details such as the game's genre (Role-Playing Games and Strategy), available platforms (PC and PlayStation), a detailed description of the futuristic universe, and its unique turn-based and real-time strategy mechanics. He also specifies that the game supports multiple players. John uploads a cover image for the game page. He carefully adds the game's release year, includes map information, and tags relevant to the game's theme and mechanics for better searchability. Over time, John updates the page with new content based on user feedback and keeps track of the upvotes and downvotes to gauge community reception and make further improvements.

**Satisfied Requirements:**
- **1.2.3.4**: Game pages shall include the game genre.
- **1.2.3.5**: Game pages shall include the platform(s) on which the game is available.
- **1.2.3.6**: Game pages shall include information about the in-game avatar.
- **1.2.3.7**: Game pages shall include the number of players indicating the supported number of players.
- **1.2.3.8**: Game pages shall include the release year.
- **1.2.3.9**: Game pages shall include universe information.
- **1.2.3.10**: Game pages shall include mechanics information.
- **1.2.3.12**: Game pages shall include the official title of the game.
- **1.2.3.13**: Game pages shall include map information.
- **1.2.3.14**: Game pages shall include a game poster.

## An User Test 

Preconditions:
User is registered and logged into the gaming platform.
Test Steps:
1. Log in to the gaming platform.
2. Navigate to the user's profile page.
3. Click on the "Edit Profile Picture" option.
4. Upload a new profile picture.
5. Save the changes.
6. Click on the "Edit About" option.
7. Update the about section with new gaming interests and achievements.
8. Save the changes.
9. Click on the "Edit Tags" option.
10. Add new tags and remove irrelevant ones.
11. Save the changes.
12. Click on the "Like History" section to view liked posts.
13. Click on the "Edit Tags" option on the profile page.
14. Edit tags associated with the user's profile.
15. Save the changes.
16. Explore and review owned posts, game pages, and LFGs on the profile page.

Expected Outputs:
The profile picture is updated successfully.
The about section reflects the latest gaming interests and achievements.
Tags are added or removed as per the user's selection.
Like history is visible and can be edited.
Tags associated with the profile are successfully edited.
Owned posts, game pages, and LFGs are displayed on the profile page.
Conclusion:
The user test is successful if all the expected outputs are achieved.

## Your plans for the next week
| Description | Issue | Assignee | Due | Estimated Duration |
| --- | --- | --- | --- | --- |
|[Mobile] Persistence Navigation Bar |[#431](https://github.com/bounswe/bounswe2023group6/issues/431)| Süleyman Melih Portakal | 28.11.2023 | 3hr|
|[Mobile] Game Page Get Service Integration |[#430](https://github.com/bounswe/bounswe2023group6/issues/430)| Süleyman Melih Portakal | 28.11.2023 | 3hr|
|[Mobile] Display Related Posts on Game Page Description |[#429](https://github.com/bounswe/bounswe2023group6/issues/429)| Süleyman Melih Portakal | 28.11.2023 | 3hr|
|[Mobile] SessionId Storage in Shared Preferences |[#428](https://github.com/bounswe/bounswe2023group6/issues/428)| Erkam Kavak | 28.11.2023 | 3hr|
|[Mobile] Update Game List Page |[#427](https://github.com/bounswe/bounswe2023group6/issues/427)| Umut Demir | 28.11.2023 | 3hr|
|[Mobile] Implement create/update gamepage service |[#426](https://github.com/bounswe/bounswe2023group6/issues/426)| Umut Demir | 28.11.2023 | 3hr|
|[Mobile] Profile Edit Page |[#425](https://github.com/bounswe/bounswe2023group6/issues/425)| Muhammet Mustafa Küçük | 28.11.2023 | 3hr|
|[Mobile] Post Page Reply Section |[#424](https://github.com/bounswe/bounswe2023group6/issues/424)| Erkam Kavak | 28.11.2023 | 3hr|
|[Mobile] Post Page Missing Parts: Tag, Related Game, Original Poster, User Information |[#423](https://github.com/bounswe/bounswe2023group6/issues/423)| Erkam Kavak | 28.11.2023 | 2hr|
|[Mobile] Post Page CRUD Operations and Service Connections |[#422](https://github.com/bounswe/bounswe2023group6/issues/422)| Erkam Kavak | 28.11.2023 | 3hr|
|[Frontend] Rate the game |[#421](https://github.com/bounswe/bounswe2023group6/issues/421)| Ömer Talip Akalın | 28.11.2023 | 4hr|
|[Frontend] Edit Game Page |[#420](https://github.com/bounswe/bounswe2023group6/issues/420)| Halis Ayberk Erdem | 28.11.2023 | 4hr|
|[Frontend] Add game page |[#419](https://github.com/bounswe/bounswe2023group6/issues/419)| Beyzanur Bektan | 28.11.2023 | 4hr|
|[Frontend] Add like/dislike functionality  |[#418](https://github.com/bounswe/bounswe2023group6/issues/418)| Hüseyin Çivi | 28.11.2023 | 4hr|
|[Frontend] Comment Addition Functionality |[#417](https://github.com/bounswe/bounswe2023group6/issues/417)| Halis Ayberk Erdem | 28.11.2023 | 4hr|
|[Frontend] Edit post page |[#416](https://github.com/bounswe/bounswe2023group6/issues/416)| Ömer Talip Akalın | 28.11.2023 | 4hr|
|[Frontend] Add post page popup |[#415](https://github.com/bounswe/bounswe2023group6/issues/415)| Hüseyin Çivi | 28.11.2023 | 4hr|
|[Frontend] Improve Forum Page |[#414](https://github.com/bounswe/bounswe2023group6/issues/414)| Ömer Talip Akalın | 28.11.2023 | 4hr|
|[Frontend] Add create game page |[#413](https://github.com/bounswe/bounswe2023group6/issues/413)| Halis Ayberk Erdem | 28.11.2023 | 4hr|
|[Frontend] Integrate profile page |[#411](https://github.com/bounswe/bounswe2023group6/issues/411)| Beyzanur Bektan | 28.11.2023 | 4hr|
|[Backend] Implementing Authentication and Authorization Middlewares |[#407](https://github.com/bounswe/bounswe2023group6/issues/407)| Ömer Bahadıroğlu | 28.11.2023 | 3hr|
|[Backend] Implementation of "Comments" Related Endpoints |[#406](https://github.com/bounswe/bounswe2023group6/issues/406)| Ömer Bahadıroğlu | 28.11.2023 | 3hr|
|[Backend] Implementing Posts (Forum) Related Endpoints |[#405](https://github.com/bounswe/bounswe2023group6/issues/405)| Ömer Bahadıroğlu | 28.11.2023 | 3hr|
|[Backend] Update Registration Endpoint |[#404](https://github.com/bounswe/bounswe2023group6/issues/404)| Emre Türker| 28.11.2023 | 3hr|
|[Backend] Implementing Profile Page Related Endpoints |[#403](https://github.com/bounswe/bounswe2023group6/issues/403)| Emre Türker | 28.11.2023 | 3hr|


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
- Ömer Talip Akalın
