# Project Development Weekly Progress Report

**Team Name:** Group 6 - Game Forum

**Date:** 17.10.2023

## Progress Summary
**This week** we focused on making decisions on two major topics:
- Finalizing conventions & technologies that are going to be used in the project.
- Discussing our updates on the requirements, diagrams, and recommendation details (based on the feedbacks from instructors).

## What was planned for the week? How did it go?

| Description | Issue | Assignee | Due | PR | Estimated Duration | Actual Duration | 
| -------- | ----- | -------- | --- | --- | --- | --- |
| Deciding the design of the game page | [#249](https://github.com/bounswe/bounswe2023group6/issues/249) | Team | 17.10.2023 | | 2hr | 2hr |
| Refactor the requirements | [#238](https://github.com/bounswe/bounswe2023group6/issues/238) | Team | 24.10.2023 | | 2hr | 4hr| 
| Update the use case diagram w.r.t. the changes in the requirements | [#239](https://github.com/bounswe/bounswe2023group6/issues/239) | Team  | 24.10.2023 | | 2hr | 0.5hr | 
| Update the class diagram w.r.t. the changes in the requirements | [#240](https://github.com/bounswe/bounswe2023group6/issues/240) | Team  | 24.10.2023 |  | 2hr | 0.5hr| 
| Update the sequence diagram w.r.t. the changes in the requirements | [#241](https://github.com/bounswe/bounswe2023group6/issues/241) | Team | 24.10.2023 | | 2hr | 0.5hr| 
| Learn React framework for the front-end | [#256](https://github.com/bounswe/bounswe2023group6/issues/256) | Front-Team | 24.10.2023 | | 2hr | 1hr | |
| Learn Flutter framework for the mobile | [#258](https://github.com/bounswe/bounswe2023group6/issues/258) | Mobile-Team | 24.10.2023 | |2hr | 1hr| |
| Learn Kotlin & Spring Boot framework for the back-end | [#259](https://github.com/bounswe/bounswe2023group6/issues/259) | Back-Team | 24.10.2023 | |2hr | 1hr| |

## Completed tasks that were not planned for the week

| Description  | Issue | Assignee | Due | PR |
| -------- | ----- | -------- | --- | --- |
|  |  |  |  |  |
| Determine Backend Structure and Initialize the backend| [#254](https://github.com/bounswe/bounswe2023group6/issues/254) | Backend-Team | 17.10.2023 |[#273](https://github.com/bounswe/bounswe2023group6/pull/273)  |
| Create folder structure template for mobile | [#252](https://github.com/bounswe/bounswe2023group6/issues/252) | Mobile-Team | 17.10.2023 | [#253](https://github.com/bounswe/bounswe2023group6/pull/253) |
| Edit Issue Labels| [#257](https://github.com/bounswe/bounswe2023group6/issues/257) | Ömer Talip Akalin | 17.10.2023 | 

## Decisions Related to the Tech-Stack and Conventions of the Project

- As we talked previously, we decided on our tech stack for the project. 
    - Backend: Kotlin, Spring Boot, PostgreSQL
    - Mobile: Flutter
    - Frontend: HTML, CSS, ReactJS
    - CI/CD: Docker, Github Actions, AWS

- Tests & Coverage: 
    - There will be unit tests implemented for major functions.
    - Test should check all of the assumptions that are observable in the code.
    - As tests gets complex, they should be splitted into smaller components.
    - Coverage should be taken into account in terms of the success of the tests & codebase.
- CI/CD: 
    - CI/CD system should run on the dev and main branches for tests, lints, audits, and deployments.
    - Successful passes on dev and main branches should result in deployments to the relevant machines.
    - Other branches should run the formats & lints after each commit.
- Branching: 
    - Branches should have the following format:
        - \<team>/\<type>/\<task>-\<issue-number>
    - An example is the following: 
        - frontend/enhancement/login-page-#134
    - The "main" branch should be used for main deployments and codebase. This branch should only accept pull requests from "dev" branch, unless there's a hotfix situation.
    - The "dev" branch should be used for test deployments and codebase. It should be extensively used to test the combinations of the features.
    - PR's and commits should be rejected on the main and dev branches by the CI/CD system automatically, if they fail formatting and linter systems.
    - Force pushes should be avoided mainly, especially if it's going to be on top of other people's work.
- PR Details: 
    - Each PR should be reviewed by at least one person.
    - PR's should be extensively detailed in terms of the issues it closes, the people assigned, the people reviewed, the milestones.
    - PR's should be **objective**, meaning there should not be any sort of tolerance at the end product that will live in the main branch. Code quality must be prioritized.
    - PR's should be extensively tested and reviewed by the reviewers. No PR's should go by checking the code for a short time without testing.
    - Merge conflicts should be fixed in communication between team members.
    - Merges should be done in the form of "squash and merge".
- Module structure: 
    - As decided, the main files of the teams (i.e. mobile, frontend, backend) should live under the application folder of the repository.
    - Lab reports and other stuff are allowed outside of application folder in the repository.
    - The teams will decide the rest on their meetings. Examples can be seen here: 
        - [#252](https://github.com/bounswe/bounswe2023group6/issues/252)
        - [#254](https://github.com/bounswe/bounswe2023group6/issues/254)


## Your plans for the next week
| Description | Issue | Assignee | Due | Estimated Duration |
| --- | --- | --- | --- | --- |
| Refactor the requirements | [#238](https://github.com/bounswe/bounswe2023group6/issues/238) | Team | 24.10.2023 | 2hr/week|
| Update the use case diagram w.r.t. the changes in the requirements | [#239](https://github.com/bounswe/bounswe2023group6/issues/239) | Team | 24.10.2023 | 2hr/week |
| Update the class diagram w.r.t. the changes in the requirements | [#240](https://github.com/bounswe/bounswe2023group6/issues/240) | Team | 24.10.2023 | 2hr/week |
| Update the sequence diagram w.r.t. the changes in the requirements | [#241](https://github.com/bounswe/bounswe2023group6/issues/241) | Team | 24.10.2023 | 2hr/week |
| Learn React framework for the front-end | [#256](https://github.com/bounswe/bounswe2023group6/issues/256) | Frontend-Team | 24.10.2023 |2hr/week | 
| Learn Flutter framework to be used for the mobile | [#258](https://github.com/bounswe/bounswe2023group6/issues/258) | Mobile-Team | 24.10.2023 |2hr/week | 
| Learn Spring Boot framework for the back-end | [#259](https://github.com/bounswe/bounswe2023group6/issues/259) | Backend-Team | 24.10.2023 |2hr/week | 
| Add use case diagrams for the game page | [#260](https://github.com/bounswe/bounswe2023group6/issues/260) | Melih Portakal | 24.10.2023 | 1hr | 
| Decide the design of the Character Page| [#261](https://github.com/bounswe/bounswe2023group6/issues/261)| Team | 24.10.2023  | 1hr |
| Writing the determined Game Page fields into the requirements.| [#262](https://github.com/bounswe/bounswe2023group6/issues/262) | Ahmet Kudu | 24.10.2023  | 1hr |
| Implement the Forgot Password Endpoint | [#265](https://github.com/bounswe/bounswe2023group6/issues/265) | Emre Sin| 31.10.2023 | 1hr/this week |
| Implement the Change Password Endpoint | [#266](https://github.com/bounswe/bounswe2023group6/issues/266) | Ahmet Kudu | 31.10.2023 | 1hr/this week |
|User Login/Logout Endpoints | [#267](https://github.com/bounswe/bounswe2023group6/issues/267) | Emre Türker - Ömer Bahadıroğlu | 31.10.2023 | 1hr/this week |
| Implement Mobile Login Page| [#268](https://github.com/bounswe/bounswe2023group6/issues/267)| Melih Portakal - Erkam Kavak| 31.10.2023 | 1hr/this week |
| Implement Mobile Register Page| [#269](https://github.com/bounswe/bounswe2023group6/issues/268)| Mustafa Küçük - Umut Demir| 31.10.2023 | 1hr/this week |
| Setup Frontend | [#270](https://github.com/bounswe/bounswe2023group6/issues/270)|Talip Akalın - Ayberk Erdem| 24.10.2023 | 2hr |
| Implement Frontend Login Page| [#271](https://github.com/bounswe/bounswe2023group6/issues/271)| Talip Akalın - Beyzanur Bektan| 31.10.2023 | 1hr/this week |
| Implement Frontend Register Page| [#272](https://github.com/bounswe/bounswe2023group6/issues/272)| Hüseyin Çivi - Ayberk Erdem| 31.10.2023 | 1hr/this week |
| Branching and CI/CD configuration| [#273](https://github.com/bounswe/bounswe2023group6/issues/273) | Talip Akalın - Erkam Kavak - Mustafa Küçük| 31.10.2023 | 2hr |
## Participants
- Ahmet Kudu
- Beyzanur Bektan
- Emre Sin
- Emre Türker
- Erkam Kavak
- Halis Ayberk Erdem
- Hüseyin Çivi
- Muhammet Mustafa Küçük
- Ömer Bahadıroğlu
- Ömer Talip Akalın
- Süleyman Melih Portakal
- Umut Demir
