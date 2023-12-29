## Group Milestone Report

### 5 minutes video of the system
You can reach video from this [link](https://youtu.be/wdKH5d7lddA). 

### Executive summary 
The gaming platform has successfully implemented key features such as user registration, authentication, and profile management, allowing users to personalize their experience with profile pictures and about sections. For instance, users can seamlessly navigate through their own and others' profiles, fostering a sense of community within the platform.

Social interactions are robust, encompassing the creation, update, and deletion of posts, comments, game pages, and LFGs. This allows users to actively contribute to the platform's content. An example is the ability to tag posts, enhancing content organization and making it easily searchable for users interested in specific topics.

The search functionality empowers users to find relevant content, such as posts, LFGs, and game pages. For example, users can effortlessly search for posts or LFGs based on keywords, streamlining their access to specific information within the platform.

While the platform has prioritized security with HTTPS, SSL, and encryption for sensitive user data, there are opportunities for improvement. Clear communication of data policies and compliance with regulations, exemplified by GDPR and KVKK, will enhance user trust and privacy protection.

Administrative functions, including report viewing, user banning, and approval/rejection of game page requests, showcase a commitment to maintaining a healthy and secure gaming environment. However, continuous development is needed to address pending items such as daily database backups, response time optimization, and scalability for accommodating a larger user base.

In summary, the platform has laid a strong foundation for a thriving gaming community. Ongoing improvements, guided by examples such as enhanced regulatory compliance and refined search functionality, will further elevate the user experience and solidify the platform's position as a go-to destination for gamers.
______________
### Status of all Deliverables

| Name               | Status                      | Notes         |
|--------------------|-----------------------------|---------------|
| Group Milestone Report | Completed | - |
| Progress based on teamwork | Completed| - |
| API Endpoints| Completed | - |
| User Interface / User Experience| Completed | - |
| Annotations| Completed | - |
| Scenarios| Completed | - |
| Use and Maintanence| Completed | - |
| Project Artifacts| Completed | - |
| Software| Completed | - |
| Individual Milestone Reports| Completed | - |
 
### Final release notes 
### Management 

There have been several changes we have made taking the feedbacks we got from the previous milestones into account. The first one was our image system not functioning properly. At first we were not using a separate file system and storing the images as byte arrays in our database. However, this could’ve caused scaling problems since they are large and it takes time to deliver them. However, while doing so we made some mistakes regarding the naming of the pictures in the S3 bucket. We fixed that issue later on. This allowed us to, conveniently store images. We structured our bucket in a way that even after an additional content type, we could easily integrate it to the system. What we did was basically determining a naming convention and creating a folder system in the bucket.

Second, we got some criticism regarding our navigation bar design in the frontend. Our frontend team has worked on it and with some color adjustments it became significantly more appealing. The change in the UI offered users an overall better experience.

The CORS was also a huge pain. We haven’t been able to come up with a solution to this problem up until there was 3 weeks to the final milestone. Nonetheless, we were able to overcome this challenge as well. 

We also got feedback in that the game creation should not be exclusive to the admins, which was obviously against the goal of the project. We allowed registered users to create game requests and implemented an admin approval mechanism, with a user friendly admin panel. This way we believe that our project will serve its initial purpose better. Also the burden of creating games is relieved from the admins.

Guest and registered user separation was subtle, which was also mentioned in the second milestone. We created additional endpoints for recommendations to this end, offering customized content for registered users. This was another feature that basically made our application more appealing.

Regarding the reflections on the final milestone: we are pretty much pleased with the end result we put forward. We think that our customers are also pleased with the result.  We believe that we successfully demonstrated the potential use cases of our project on both platforms mobile and frontend. Showing both UIs side by side was a great choice which was also liked by the customers. One major criticism was that users were not able to annotate the same part of the content on the web app. Also another one was again related to the annotations, the image annotations especially. The UI for that functionality was not working quite right on the mobile and was not implemented in the frontend. We got criticism regarding our search and tag mechanisms not being semantic, so they could have been implemented that way.

In retrospect, we definitely see that there are some titles where we made poor choices:
1. We wasted a lot of time determining how to do things. We should have acted more quickly in this regard. We resisted change too much, leading to uncertainty, and as a result, we lost time and started implementation late. We should have accepted the change and continued on our way.
2. Classes in the backend should have been better defined. While implementing, we noticed that some things were still uncertain, and we had to come up with solutions on the fly, damaging synchronization with other teams. Some changes were not communicated properly, leading to the need for fixes in some cases, which resulted in time and effort loss.
3. The backend should have progressed earlier, allowing for a buffer zone with other teams.
4. Looking back, better planning could have been done in CmpE 352. Even though we believe we performed well as a team and it might not have been possible to foresee implementation issues at that time, more effort could have been made.

## Progress Based on Teamwork
### A Summary of work performed by each team member

#### Ahmet Kudu
- `Member:` Ahmet Kudu - 2016400402 - Group 6 - Backend Team
- `Responsibilities:` I worked on the password change at first. Then, I developed the CORS and database migration stuff to make the software consistent and robust. After that, I coded the game page with the fields, which helped to make the project domain-specific. Lastly, I made an effort on the admin panel to manage the software. 
- `Main contributions:` 
  - I have reviewed a part of the requirements/designs and updated them. 
  - I have implemented some endpoints with the beginning `/user` , `/game`, and `/admin`.
  - I have met the feedbacks given in the customer presentations.
  - I have helped resolve bugs and backend issues that have come up from the `backend - front/mobile` teams. 
  - `Code related significant issues:` [#266](https://github.com/bounswe/bounswe2023group6/issues/266) [#368](https://github.com/bounswe/bounswe2023group6/issues/368) [#369](https://github.com/bounswe/bounswe2023group6/issues/369) [#391](https://github.com/bounswe/bounswe2023group6/issues/391) [#393](https://github.com/bounswe/bounswe2023group6/issues/393) [#506](https://github.com/bounswe/bounswe2023group6/issues/506) [#508](https://github.com/bounswe/bounswe2023group6/issues/508) [#524](https://github.com/bounswe/bounswe2023group6/issues/524) [#550](https://github.com/bounswe/bounswe2023group6/issues/550) [#559](https://github.com/bounswe/bounswe2023group6/issues/559) [#596](https://github.com/bounswe/bounswe2023group6/issues/596)
  - `Management related significant issues:` [#240](https://github.com/bounswe/bounswe2023group6/issues/240) [#245](https://github.com/bounswe/bounswe2023group6/issues/245) [#246](https://github.com/bounswe/bounswe2023group6/issues/246) [#259](https://github.com/bounswe/bounswe2023group6/issues/259) [#262](https://github.com/bounswe/bounswe2023group6/issues/262) [#297](https://github.com/bounswe/bounswe2023group6/issues/297) [#347](https://github.com/bounswe/bounswe2023group6/issues/347) [#349](https://github.com/bounswe/bounswe2023group6/issues/349) [#491](https://github.com/bounswe/bounswe2023group6/issues/491) [#492](https://github.com/bounswe/bounswe2023group6/issues/492)
- `Pull requests:` [#299](https://github.com/bounswe/bounswe2023group6/pull/299) [#536](https://github.com/bounswe/bounswe2023group6/pull/536) [#537](https://github.com/bounswe/bounswe2023group6/pull/537) [#538](https://github.com/bounswe/bounswe2023group6/pull/538) [#572](https://github.com/bounswe/bounswe2023group6/pull/572) [#593](https://github.com/bounswe/bounswe2023group6/pull/593) [#630](https://github.com/bounswe/bounswe2023group6/pull/630) [#663](https://github.com/bounswe/bounswe2023group6/pull/663)
- `Unit tests:` [#597](https://github.com/bounswe/bounswe2023group6/issues/597)
   
#### Erkam Kavak
- `Member:` Erkam Kavak - 2020400174 - Group 6 - Mobile Team
- `Responsibilities:` I worked on many parts of the mobile app. I developed forum related pages, profile page and I have made additions other pages such as lfg page, home page and game page. I have also been active on developing service connections of mobile app. 
- `Main contributions:`
    - `Code related significant issues:` [258](https://github.com/bounswe/bounswe2023group6/issues/258) [274](https://github.com/bounswe/bounswe2023group6/issues/274) [276](https://github.com/bounswe/bounswe2023group6/issues/276) [280](https://github.com/bounswe/bounswe2023group6/issues/280) [293](https://github.com/bounswe/bounswe2023group6/issues/293) [363](https://github.com/bounswe/bounswe2023group6/issues/363) [387](https://github.com/bounswe/bounswe2023group6/issues/387) [388](https://github.com/bounswe/bounswe2023group6/issues/388) [422](https://github.com/bounswe/bounswe2023group6/issues/422) [423](https://github.com/bounswe/bounswe2023group6/issues/423) [424](https://github.com/bounswe/bounswe2023group6/issues/424) [428](https://github.com/bounswe/bounswe2023group6/issues/428) [519](https://github.com/bounswe/bounswe2023group6/issues/519) [520](https://github.com/bounswe/bounswe2023group6/issues/520) [521](https://github.com/bounswe/bounswe2023group6/issues/521) [556](https://github.com/bounswe/bounswe2023group6/issues/556) [557](https://github.com/bounswe/bounswe2023group6/issues/557) [558](https://github.com/bounswe/bounswe2023group6/issues/558) [588](https://github.com/bounswe/bounswe2023group6/issues/588) [589](https://github.com/bounswe/bounswe2023group6/issues/589) [590](https://github.com/bounswe/bounswe2023group6/issues/590) [591](https://github.com/bounswe/bounswe2023group6/issues/591)
    - `Management related significant issues:`
- `Pull requests:` [320](https://github.com/bounswe/bounswe2023group6/pull/320) [344](https://github.com/bounswe/bounswe2023group6/pull/344) [371](https://github.com/bounswe/bounswe2023group6/pull/371) [373](https://github.com/bounswe/bounswe2023group6/pull/373) [382](https://github.com/bounswe/bounswe2023group6/pull/382) [408](https://github.com/bounswe/bounswe2023group6/pull/408) [440](https://github.com/bounswe/bounswe2023group6/pull/440) [453](https://github.com/bounswe/bounswe2023group6/pull/453) [458](https://github.com/bounswe/bounswe2023group6/pull/458) [485](https://github.com/bounswe/bounswe2023group6/pull/485) [487](https://github.com/bounswe/bounswe2023group6/pull/487) [532](https://github.com/bounswe/bounswe2023group6/pull/532) [555](https://github.com/bounswe/bounswe2023group6/pull/555) [568](https://github.com/bounswe/bounswe2023group6/pull/568) [573](https://github.com/bounswe/bounswe2023group6/pull/573) [579](https://github.com/bounswe/bounswe2023group6/pull/579) [580](https://github.com/bounswe/bounswe2023group6/pull/580) [608](https://github.com/bounswe/bounswe2023group6/pull/608) [609](https://github.com/bounswe/bounswe2023group6/pull/609) [618](https://github.com/bounswe/bounswe2023group6/pull/618) [644](https://github.com/bounswe/bounswe2023group6/pull/644) [661](https://github.com/bounswe/bounswe2023group6/pull/661) [665](https://github.com/bounswe/bounswe2023group6/pull/665) [672](https://github.com/bounswe/bounswe2023group6/pull/672) [680](https://github.com/bounswe/bounswe2023group6/pull/680) 


#### Umut Demir
- `Member:` Umut Demir - 2019400219 - Group 6 - Mobile Team
- `Responsibilities:`
  - Active participation in the development of the mobile side of the project.
  - Key role in strategizing and planning weekly tasks during collaborative lab sessions.
  - Provision of valuable insights as an experienced software developer for planning and implementing requirements, pages, services, etc.
  - Execution of assigned tasks and implementation of necessary components for the mobile application.
  - Conducting comprehensive task reviews to identify and address potential issues.

- `Main contributions:`
  - Addressed code-related significant issues, including adding tag options, creating multiple-choice options, and updating pages and services for LFG and games.
  - Worked on software-related significant issues, such as adding a guest user option and refactoring the model class for groups.
  - Created and reviewed pull requests, implementing and updating various features in the mobile application.
  - Contributed to the project's progress by actively participating in planning, implementation, and code reviews, ensuring the robustness and quality of the mobile application.
  - `Code related significant issues:` [#594](https://github.com/bounswe/bounswe2023group6/issues/594) [#592](https://github.com/bounswe/bounswe2023group6/issues/592) [#552](https://github.com/bounswe/bounswe2023group6/issues/552) [#549](https://github.com/bounswe/bounswe2023group6/issues/549) [#548](https://github.com/bounswe/bounswe2023group6/issues/548) [#525](https://github.com/bounswe/bounswe2023group6/issues/525) [#518](https://github.com/bounswe/bounswe2023group6/issues/518)
  - `Management related significant issues:` [#587](https://github.com/bounswe/bounswe2023group6/issues/587) [#547](https://github.com/bounswe/bounswe2023group6/issues/547)
- `Pull requests:` [#678](https://github.com/bounswe/bounswe2023group6/pull/678) [#666](https://github.com/bounswe/bounswe2023group6/pull/666) [#658](https://github.com/bounswe/bounswe2023group6/pull/658) [#656](https://github.com/bounswe/bounswe2023group6/pull/656) [#647](https://github.com/bounswe/bounswe2023group6/pull/647) [#632](https://github.com/bounswe/bounswe2023group6/pull/632) [#576](https://github.com/bounswe/bounswe2023group6/pull/576) [#535](https://github.com/bounswe/bounswe2023group6/pull/535) [#533](https://github.com/bounswe/bounswe2023group6/pull/533)

#### Muhammet Mustafa Küçük
- `Member:` Muhammet Mustafa Küçük - 2016400111 - Group 6 - Mobile Team/CICD
- `Responsibilities:` I was responsible for managing the entire CI/CD pipeline, dockerization, and server configurations. Additionally, as a member of the mobile team, I contributed by implementing new features and addressing minor bugs.
- `Main contributions:` 
  - I have implemented github actions to automate the deployment of docker images to a remote server.
  - I have configured the ssl certification and nginx reverse proxy.
  - I have dockerized the annotation backend service and configured the database.
  - I have helped mobile team with sorting/filtering features of forms and posts.
  - `Code related significant issues:` [#509](https://github.com/bounswe/bounswe2023group6/issues/509) [#540](https://github.com/bounswe/bounswe2023group6/issues/540) [#544](https://github.com/bounswe/bounswe2023group6/issues/544) [#550](https://github.com/bounswe/bounswe2023group6/issues/550) [#553](https://github.com/bounswe/bounswe2023group6/issues/553) [#644](https://github.com/bounswe/bounswe2023group6/issues/644)
  - `Management related significant issues:` [#493](https://github.com/bounswe/bounswe2023group6/issues/493) [#502](https://github.com/bounswe/bounswe2023group6/issues/502) [#584](https://github.com/bounswe/bounswe2023group6/issues/584) [#262](https://github.com/bounswe/bounswe2023group6/issues/262) [#607](https://github.com/bounswe/bounswe2023group6/issues/607) [#347](https://github.com/bounswe/bounswe2023group6/issues/347) [#637](https://github.com/bounswe/bounswe2023group6/issues/637) [#491](https://github.com/bounswe/bounswe2023group6/issues/491) [#687](https://github.com/bounswe/bounswe2023group6/issues/687)
- `Pull requests:` [#467](https://github.com/bounswe/bounswe2023group6/pull/467) [#540](https://github.com/bounswe/bounswe2023group6/pull/540) [#544](https://github.com/bounswe/bounswe2023group6/pull/544) [#607](https://github.com/bounswe/bounswe2023group6/pull/607) [#637](https://github.com/bounswe/bounswe2023group6/pull/637)


#### Hüseyin Çivi
- `Member:` Hüseyin Çivi - Frontend Team
- **Responsibilities:** 
I was one of the frontend members responsible for the web part of our application. On the frontend side, I had large and small responsibilities in all aspects of the project.
- **Contributions:**
    - I created the homepage template. Subsequent homepage developments proceeded through this page.
    - I created the profile page template. Subsequent profile page developments proceeded through this page.
    - I created post create and edit components.
    - I made all the improvements regarding the lfg page, which is one of the 3 main features of the project.
	- Code related significant issues: 
[#284](https://github.com/bounswe/bounswe2023group6/issues/284)
[#358](https://github.com/bounswe/bounswe2023group6/issues/358)
[#389](https://github.com/bounswe/bounswe2023group6/issues/389)
[#416](https://github.com/bounswe/bounswe2023group6/issues/416)
[#503](https://github.com/bounswe/bounswe2023group6/issues/503)
[#554](https://github.com/bounswe/bounswe2023group6/issues/554)
[#598](https://github.com/bounswe/bounswe2023group6/issues/598)
[#599](https://github.com/bounswe/bounswe2023group6/issues/599)
[#640](https://github.com/bounswe/bounswe2023group6/issues/640)
[#650](https://github.com/bounswe/bounswe2023group6/issues/650)

- **Pull Requests:** 
[#384](https://github.com/bounswe/bounswe2023group6/pull/384) [#397](https://github.com/bounswe/bounswe2023group6/pull/397) [#477](https://github.com/bounswe/bounswe2023group6/pull/477) [#484](https://github.com/bounswe/bounswe2023group6/pull/484) [#539](https://github.com/bounswe/bounswe2023group6/pull/539) [#564](https://github.com/bounswe/bounswe2023group6/pull/564) [#570](https://github.com/bounswe/bounswe2023group6/pull/570) [#578](https://github.com/bounswe/bounswe2023group6/pull/578) [#583](https://github.com/bounswe/bounswe2023group6/pull/583) [#634](https://github.com/bounswe/bounswe2023group6/pull/634) [#641](https://github.com/bounswe/bounswe2023group6/pull/641) [#646](https://github.com/bounswe/bounswe2023group6/pull/646) [#651](https://github.com/bounswe/bounswe2023group6/pull/651) [#669](https://github.com/bounswe/bounswe2023group6/pull/669)

#### Emre Türker
- `Member:` Emre Türker – 2019400054 - Group 6 - Backend Team
- `Responsibilities:` During this milestone I mainly worked on recommendation feature and bug fixing. The bugs were related to S3 bucket and Game entity design. Also I provided the endpoints that were not planned to be implemented but requested from the mobile and frontend teams. The listed contributions only include the last milestone.
- `Main contributions:` 
  - Implemented the recommendation algorithm. 
  - Fixed major bugs related to entities and S3 bucket.
  - Provided some endpoints meeting the needs of mobile and frontend teams.
  - Refactored others codes as needed. 
  - `Code related significant issues:` [#266](https://github.com/bounswe/bounswe2023group6/issues/504) [#368](https://github.com/bounswe/bounswe2023group6/issues/507) [#369](https://github.com/bounswe/bounswe2023group6/issues/563) [#391](https://github.com/bounswe/bounswe2023group6/issues/565) [#393](https://github.com/bounswe/bounswe2023group6/issues/567) [#506](https://github.com/bounswe/bounswe2023group6/issues/612) [#508](https://github.com/bounswe/bounswe2023group6/issues/622) 
  - `Management related significant issues:` [#688](https://github.com/bounswe/bounswe2023group6/issues/688) 
- `Pull requests:` [#639](https://github.com/bounswe/bounswe2023group6/pull/639) [#636](https://github.com/bounswe/bounswe2023group6/pull/636) [#631](https://github.com/bounswe/bounswe2023group6/pull/631) [#625](https://github.com/bounswe/bounswe2023group6/pull/625) [#623](https://github.com/bounswe/bounswe2023group6/pull/623) [#611](https://github.com/bounswe/bounswe2023group6/pull/611) [#566](https://github.com/bounswe/bounswe2023group6/pull/566)

#### Ömer Huzeyfe Bahadıroğlu
- `Member:` Ömer Huzeyfe Bahadıroğlu- 2018400114 – Group 6 - Backend Team
- `Responsibilities:` My role in the backend team involved developing robust backend services, integrating them with the frontend, and implementing key features for an enhanced user experience. I worked on various elements including backend structure initialization, user authentication, and functionalities for forum and Looking for Group (LFG) sections. My efforts were focused on ensuring these features met the evolving requirements of the project.

- `Main contributions:` 
  - Initiated and structured the backend setup.
  - Developed user authentication endpoints and entity classes.
  - Established secure authentication and authorization processes.
  - Implemented and refined Forum, LFG, Comment related functionalities and others.
  - Introduced features like reporting, liking, and tagging for various contents.

- `Significant issues:` [#254](https://github.com/bounswe/bounswe2023group6/issues/254) [#267](https://github.com/bounswe/bounswe2023group6/issues/267) [#317](https://github.com/bounswe/bounswe2023group6/issues/317) [#391](https://github.com/bounswe/bounswe2023group6/issues/391) [#405](https://github.com/bounswe/bounswe2023group6/issues/405) [#406](https://github.com/bounswe/bounswe2023group6/issues/406) [#407](https://github.com/bounswe/bounswe2023group6/issues/407) [#437](https://github.com/bounswe/bounswe2023group6/issues/437) [#441](https://github.com/bounswe/bounswe2023group6/issues/441) [#448](https://github.com/bounswe/bounswe2023group6/issues/448) [#501](https://github.com/bounswe/bounswe2023group6/issues/501) [#561](https://github.com/bounswe/bounswe2023group6/issues/561) [#562](https://github.com/bounswe/bounswe2023group6/issues/562) [#633](https://github.com/bounswe/bounswe2023group6/issues/633) [#643](https://github.com/bounswe/bounswe2023group6/issues/643)

- `Pull requests:`  [#273](https://github.com/bounswe/bounswe2023group6/pull/273) [#288](https://github.com/bounswe/bounswe2023group6/pull/288) [#290](https://github.com/bounswe/bounswe2023group6/pull/290) [#435](https://github.com/bounswe/bounswe2023group6/pull/435) [#436](https://github.com/bounswe/bounswe2023group6/pull/436) [#438](https://github.com/bounswe/bounswe2023group6/pull/438) [#445](https://github.com/bounswe/bounswe2023group6/pull/445) [#451](https://github.com/bounswe/bounswe2023group6/pull/451) [#610](https://github.com/bounswe/bounswe2023group6/pull/610) [#621](https://github.com/bounswe/bounswe2023group6/pull/621) [#626](https://github.com/bounswe/bounswe2023group6/pull/626) [#627](https://github.com/bounswe/bounswe2023group6/pull/627) [#635](https://github.com/bounswe/bounswe2023group6/pull/635) [#645](https://github.com/bounswe/bounswe2023group6/pull/645)

- `Reviewed Pull Requests:` [#278](https://github.com/bounswe/bounswe2023group6/pull/278) [#398](https://github.com/bounswe/bounswe2023group6/pull/398) [#399](https://github.com/bounswe/bounswe2023group6/pull/399) [#412](https://github.com/bounswe/bounswe2023group6/pull/412) [#432](https://github.com/bounswe/bounswe2023group6/pull/432) [#434](https://github.com/bounswe/bounswe2023group6/pull/434) [#438](https://github.com/bounswe/bounswe2023group6/pull/438) [#442](https://github.com/bounswe/bounswe2023group6/pull/442) [#443](https://github.com/bounswe/bounswe2023group6/pull/443) [#447](https://github.com/bounswe/bounswe2023group6/pull/447) [#457](https://github.com/bounswe/bounswe2023group6/pull/457) [#537](https://github.com/bounswe/bounswe2023group6/pull/537) [#538](https://github.com/bounswe/bounswe2023group6/pull/538) [#566](https://github.com/bounswe/bounswe2023group6/pull/566) [#593](https://github.com/bounswe/bounswe2023group6/pull/593) [#611](https://github.com/bounswe/bounswe2023group6/pull/611) [#623](https://github.com/bounswe/bounswe2023group6/pull/623) [#625](https://github.com/bounswe/bounswe2023group6/pull/625) [#630](https://github.com/bounswe/bounswe2023group6/pull/630) [#639](https://github.com/bounswe/bounswe2023group6/pull/639)

- `Unit Tests:` Contributed to unit tests until milestone 1 in a peer coding session. Relevant issue: [#317](https://github.com/bounswe/bounswe2023group6/issues/317).

#### Emre Sin
- `Member:` Emre Sin - 2019400207 - Group 6 - Backend Team
- `Responsibilities:` In this milestone I was responsible for the annotations. I was responsible of doing the research about the annotations and the W3C annotations data model standart. I was also responsible the building the annotation service and db from the scratch.
 

- `Main contributions:`
  - Doing the research for the annotations and presenting them to my teammates to enable the team to build the annotations.
  - Analyzing the need of annotation for our application and deciding which subset of features to use from W3C annotation data model.
  - Implementing annotation service and its db from scratch and adding it to the project.
  - Documenting the annotation service in order to make it easier for other teams to implement the annotations.
  - Creating all the necessary unit tests for the annotation service.
  - Creating unit test reports of our project for the final report.
  - `Code related significant issues:` [652](https://github.com/bounswe/bounswe2023group6/issues/652) [624](https://github.com/bounswe/bounswe2023group6/issues/624) [541](https://github.com/bounswe/bounswe2023group6/issues/541)
  - `Management related significant issues:` [513](https://github.com/bounswe/bounswe2023group6/issues/513)
- `Pull requests:` [649](https://github.com/bounswe/bounswe2023group6/pull/649) [676](https://github.com/bounswe/bounswe2023group6/pull/676) 
- `Unit Tests:` [676](https://github.com/bounswe/bounswe2023group6/pull/676) [478](https://github.com/bounswe/bounswe2023group6/pull/478)

#### Beyzanur Bektan
- `Member:` Beyzanur Bektan - 2019400174 - Group 6 - Frontend Team
- `Responsibilities:` 
As a member of frontend team, I was responsible from implementing pages with proper styling and connecting them with backend services, serving a good user experience. 
- `Contributions:`
    - Created the forum page and added post filtering section.
    - Created the detailed post page.
    - Created all games page with game images and titles.
    - Created detailed game page.
    - Implemented other user's profile page with follow/unfollow functions.
    - Added liked posts/comments, created posts to the profile page.
	- `Code related significant issues:`
[#390](https://github.com/bounswe/bounswe2023group6/issues/390)
[#468](https://github.com/bounswe/bounswe2023group6/issues/468)
[#515](https://github.com/bounswe/bounswe2023group6/issues/515)
[#574](https://github.com/bounswe/bounswe2023group6/issues/574)
[#628](https://github.com/bounswe/bounswe2023group6/issues/628)
[#629](https://github.com/bounswe/bounswe2023group6/issues/629)
[#654](https://github.com/bounswe/bounswe2023group6/issues/654)

- `Pull requests:`
[#378](https://github.com/bounswe/bounswe2023group6/pull/378) [#410](https://github.com/bounswe/bounswe2023group6/pull/410) [#475](https://github.com/bounswe/bounswe2023group6/pull/475) [#546](https://github.com/bounswe/bounswe2023group6/pull/546) [#571](https://github.com/bounswe/bounswe2023group6/pull/571) [#582](https://github.com/bounswe/bounswe2023group6/pull/582) [#648](https://github.com/bounswe/bounswe2023group6/pull/648) [#653](https://github.com/bounswe/bounswe2023group6/pull/653) [#671](https://github.com/bounswe/bounswe2023group6/pull/671)

#### [Omer Talip Akalin]
- `Member:` Omer Talip Akalin - 2019400246 - Group 6 - Frontend Team
- `Responsibilities:` My role spanned the management of the frontend team, overseeing code development, and ensuring robust deployment and continuous integration. I've also collaborated on backend debugging, contributed to frontend functionalities, and led the project presentations.

- `Main Contributions:` 
  - Led the frontend team, delegating tasks and ensuring timely completion.
  - Instrumental in developing our logic.
  - Undertook the refactoring of the frontend codebase and the initial setup of the frontend tech stack.
  - Actively involved in debugging and interfacing with the backend team for seamless integration.
  - Conducted comprehensive code reviews and bug resolution to uphold project integrity.

- `Code Related Significant Issues:` 
    - Made significant contributions to the enhancement of the project, including annotation, game rating functionalities, user profile features, and admin panel development.
    - Issues: [#454](https://github.com/bounswe/bounswe2023group6/issues/454), [#421](https://github.com/bounswe/bounswe2023group6/issues/421), [#420](https://github.com/bounswe/bounswe2023group6/issues/420), [#419](https://github.com/bounswe/bounswe2023group6/issues/419), [#418](https://github.com/bounswe/bounswe2023group6/issues/418), [#417](https://github.com/bounswe/bounswe2023group6/issues/417), [#416](https://github.com/bounswe/bounswe2023group6/issues/416), [#414](https://github.com/bounswe/bounswe2023group6/issues/414), [#411](https://github.com/bounswe/bounswe2023group6/issues/411), [#616](https://github.com/bounswe/bounswe2023group6/issues/616), [#615](https://github.com/bounswe/bounswe2023group6/issues/615), [#614](https://github.com/bounswe/bounswe2023group6/issues/614), [#613](https://github.com/bounswe/bounswe2023group6/issues/613), [#505](https://github.com/bounswe/bounswe2023group6/issues/505), [#502](https://github.com/bounswe/bounswe2023group6/issues/502).

- `Management Related Significant Issues:` 
    - Played a pivotal role in UI component selection for uniformity across the platform.
    - Enhanced project management through GitHub label editing and project planning.
    - Issues: [#356](https://github.com/bounswe/bounswe2023group6/issues/356), [#257](https://github.com/bounswe/bounswe2023group6/issues/257), [#256](https://github.com/bounswe/bounswe2023group6/issues/256).

- `Pull Requests:` 
    - Key contributions include feature implementations and frontend enhancements, improving the overall user experience.
    - Pull Requests: [#490](https://github.com/bounswe/bounswe2023group6/pull/490), [#489](https://github.com/bounswe/bounswe2023group6/pull/489), [#488](https://github.com/bounswe/bounswe2023group6/pull/488), [#486](https://github.com/bounswe/bounswe2023group6/pull/486), [#452](https://github.com/bounswe/bounswe2023group6/pull/452), [#673](https://github.com/bounswe/bounswe2023group6/pull/673), [#653](https://github.com/bounswe/bounswe2023group6/pull/653), [#620](https://github.com/bounswe/bounswe2023group6/pull/620), [#619](https://github.com/bounswe/bounswe2023group6/pull/619), [#617](https://github.com/bounswe/bounswe2023group6/pull/617), [#560](https://github.com/bounswe/bounswe2023group6/pull/560).

#### Halis Ayberk Erdem
- `Member:` Halis Ayberk Erdem - 2019400099 - Group 6 - Frontend Team
- `Responsibilities:` I worked on many parts of the web app. I developed game page related parts, navigation bar and I have made guest restriction additions to other pages such as  home page and forum page. I have also been actively working on the improvement of the styling. 
- `Main contributions:`
    - Created the game page then Beyza make styling changes.
    - Connected the game page to backend.
    - Created edit game page.
    - Created navbar.
    - I implemented the searchbar.
    - I implemented the guest restrictions to web page.
    - `Code related significant issues:` [684](https://github.com/bounswe/bounswe2023group6/issues/684) [683](https://github.com/bounswe/bounswe2023group6/issues/683) [586](https://github.com/bounswe/bounswe2023group6/issues/586) [543](https://github.com/bounswe/bounswe2023group6/issues/543) [514](https://github.com/bounswe/bounswe2023group6/issues/514) [512](https://github.com/bounswe/bounswe2023group6/issues/512) 
    - `Management related significant issues:`
[585](https://github.com/bounswe/bounswe2023group6/issues/585)

- `Pull requests:` [685](https://github.com/bounswe/bounswe2023group6/pull/685) [682](https://github.com/bounswe/bounswe2023group6/pull/682) [668](https://github.com/bounswe/bounswe2023group6/pull/668) [662](https://github.com/bounswe/bounswe2023group6/pull/662) [660](https://github.com/bounswe/bounswe2023group6/pull/660) [601](https://github.com/bounswe/bounswe2023group6/pull/601) [542](https://github.com/bounswe/bounswe2023group6/pull/542) 

#### Süleyman Melih Portakal

- `Member:` Süleyman Melih Portakal - 2019400240 - Group 6 - Mobile Team
    
- `Responsibilities:` I have taken on the responsibilities of creating and designing the game page, creating and designing some part of the lfg page, establishing and linking game-related services, establishing and linking some lfg-related services, creating admin panel to approve game creation and evaluate post reports, designing the homepage, developing a cache manager, creating the bottom navigation bar, and creating a navigator to ensure page persistence and efficient routing across various pages. Moreover, I have been actively identifying and fixing bugs, and reviewing pull requests to enhance overall functionality.
    
- `Main contributions:`
    
    - `Code related significant issues:` [258](https://github.com/bounswe/bounswe2023group6/issues/258) [285](https://github.com/bounswe/bounswe2023group6/issues/285) [291](https://github.com/bounswe/bounswe2023group6/issues/291) [361](https://github.com/bounswe/bounswe2023group6/issues/361) [375](https://github.com/bounswe/bounswe2023group6/issues/375) [385](https://github.com/bounswe/bounswe2023group6/issues/385) [400](https://github.com/bounswe/bounswe2023group6/issues/400) [361](https://github.com/bounswe/bounswe2023group6/issues/361) [429](https://github.com/bounswe/bounswe2023group6/issues/429) [430](https://github.com/bounswe/bounswe2023group6/issues/430) [431](https://github.com/bounswe/bounswe2023group6/issues/431) [459](https://github.com/bounswe/bounswe2023group6/issues/459) [516](https://github.com/bounswe/bounswe2023group6/issues/516) [526](https://github.com/bounswe/bounswe2023group6/issues/526) [545](https://github.com/bounswe/bounswe2023group6/issues/545) [551](https://github.com/bounswe/bounswe2023group6/issues/551) [603](https://github.com/bounswe/bounswe2023group6/issues/603) [604](https://github.com/bounswe/bounswe2023group6/issues/604) [605](https://github.com/bounswe/bounswe2023group6/issues/605)
    - `Management related significant issues:`
- `Pull requests:` [301](https://github.com/bounswe/bounswe2023group6/pull/301) [316](https://github.com/bounswe/bounswe2023group6/pull/316) [342](https://github.com/bounswe/bounswe2023group6/pull/342) [379](https://github.com/bounswe/bounswe2023group6/pull/379) [383](https://github.com/bounswe/bounswe2023group6/pull/383) [439](https://github.com/bounswe/bounswe2023group6/pull/439) [444](https://github.com/bounswe/bounswe2023group6/pull/444) [449](https://github.com/bounswe/bounswe2023group6/pull/449) [450](https://github.com/bounswe/bounswe2023group6/pull/450) [455](https://github.com/bounswe/bounswe2023group6/pull/455) [466](https://github.com/bounswe/bounswe2023group6/pull/466) [472](https://github.com/bounswe/bounswe2023group6/pull/472) [483](https://github.com/bounswe/bounswe2023group6/pull/483) [569](https://github.com/bounswe/bounswe2023group6/pull/569) [575](https://github.com/bounswe/bounswe2023group6/pull/575) [581](https://github.com/bounswe/bounswe2023group6/pull/581) [638](https://github.com/bounswe/bounswe2023group6/pull/638) [642](https://github.com/bounswe/bounswe2023group6/pull/642) [664](https://github.com/bounswe/bounswe2023group6/pull/664) [674](https://github.com/bounswe/bounswe2023group6/pull/674) [677](https://github.com/bounswe/bounswe2023group6/pull/677) [679](https://github.com/bounswe/bounswe2023group6/pull/679)
    
- `Pull requests:` [685](https://github.com/bounswe/bounswe2023group6/pull/685) [682](https://github.com/bounswe/bounswe2023group6/pull/682) [668](https://github.com/bounswe/bounswe2023group6/pull/668) [662](https://github.com/bounswe/bounswe2023group6/pull/662) [660](https://github.com/bounswe/bounswe2023group6/pull/660) [601](https://github.com/bounswe/bounswe2023group6/pull/601) [542](https://github.com/bounswe/bounswe2023group6/pull/542)

### Requirements Coverage
| ID | Name | Backend Status | Mobile Status | Frontend Status |
| -- | ---- | -------------- | --------------- | ------------- |
| 1.1.1.1 | Guests shall provide their full name, a valid username, an unregistered, a valid password to sign up. |  completed | completed | completed |
| 1.1.1.2 | Guests shall verify their email addresses. |  completed | completed | completed |
| 1.1.1.3 | Users shall be able to login and logout to platform. |  completed | completed | completed |
| 1.1.1.4 | Users shall be able to reset, and change their passwords. |  completed | not done | not done |
| 1.1.2.1 | Users shall be able to show their own profile pages. |  completed | completed | completed |
| 1.1.2.2 | Users shall be able to view other profile pages which are visible. | completed | completed | completed |
| 1.1.2.3 | Users shall be able to delete their own profile pages. | completed | not done | not done |
| 1.1.2.4 | Users shall be able to edit their profile pictures on the profile page. | completed | completed | completed |
| 1.1.2.5 | Users shall be able to edit their about sections on the profile page. | completed | completed | completed | 
| 1.1.2.6 | Users shall be able to show their own roles on the profile page. | completed | completed | completed |
| 1.1.2.7 | Users shall be able to edit their profile status (visibility) to others on the profile page. | completed |completed | not done |
| 1.1.2.8 | Users shall be able to have tags on the profile page. | completed | completed| completed |
| 1.1.2.9 | Users shall be able to write titles that are members of company on the profile page. | completed | completed| completed |
| 1.1.2.10 | Users shall be able to show their like history on their profile page. | completed | completed| completed |  
| 1.1.2.11 | Users shall be able to edit the tags on their profile. | not done | not done | not done|
| 1.1.2.12 | Users shall be able to show the posts, game pages, and LFGs that they own on their profile. | completed |partially completed |partially completed | 
| 1.1.3.1.1 | Users shall be able to view profiles of other users. | completed | completed| completed |
| 1.1.3.1.2 | Users shall be able to follow other users. | completed | completed| completed |
| 1.1.3.2.1 |  Users shall be able to create posts. | completed | completed| completed |
| 1.1.3.2.2 |  Users shall be able to update their posts. | completed | completed| completed |
| 1.1.3.2.3 |  Users shall be able to delete their posts. | completed | completed| completed |
| 1.1.3.2.4 |  Users shall be able to create comments. | completed | completed| completed |
| 1.1.3.2.5 |  Users shall be able to update their comments. | completed | completed| not done|
| 1.1.3.2.6 |  Users shall be able to delete their comments. | completed | completed| completed |
| 1.1.3.2.7 |  Users shall be able to report posts. | completed | completed| completed |
| 1.1.3.2.8 |  Users shall be able to report comments. | completed | completed| not done|
| 1.1.3.2.9 |  Users shall be able to upvote posts. | completed | completed| completed |
| 1.1.3.2.10 |  Users shall be able to downvote posts. | completed | completed| completed |
| 1.1.3.2.11 |  Users shall be able to upvote comments. | completed | completed| completed |
| 1.1.3.2.12 |  Users shall be able to downvote comments. | completed | completed| completed |
| 1.1.3.2.13 |  Users shall be able to add tags to their posts. | completed | completed| completed |
| 1.1.3.2.14 |  Users shall be able to reply to posts. | completed | completed| completed |
| 1.1.3.2.15 |  Users shall be able to reply to comments. | completed | completed| completed | 
| 1.1.3.2.16 |  Users shall be able to select the type of their post categories. | completed | completed| completed | 
| 1.1.3.2.17 |  Users shall be able to filter post categories in the forum according to their types. | completed | completed| completed | 
| 1.1.3.2.18 |  Users shall be able to view the names of the post owners in the forum. | completed | completed| completed |
| 1.1.3.2.19 |  Users shall be able to add related game page to posts. | completed | completed| not done| 
| 1.1.3.2.20 |  Users shall be able to add annotations to posts. | completed | completed| completed |
| 1.1.3.3.1 | Users shall be able to request creating game pages. | completed | completed| completed |
| 1.1.3.3.2 | Users shall be able to request updating game pages and adding/deleting details. | completed | not completed| completed |
| 1.1.3.3.3 | Users shall be able to display game pages. | completed | completed| completed |
| 1.1.3.3.4 | Users shall be able to upvote game pages. | completed | completed| completed |
| 1.1.3.3.5 | Users shall be able to downvote game pages. | completed | completed| completed |
| 1.1.3.3.6 | Users shall be able to navigate through recommended topics. | completed | completed| completed |
| 1.1.3.3.7 | Users shall be able to report game pages. | completed | completed| not done |
| 1.1.3.3.8 | Users shall be able to add annotation to game pages. | completed | partially completed| not done |
| 1.1.3.4.1 | Users shall be able to create LFGs. | completed | completed| completed |
| 1.1.3.4.2 | Users shall be able to update LFGs. | completed | completed| completed |
| 1.1.3.4.3 | Users shall be able to delete LFGs. | completed | not done | completed |
| 1.1.3.4.4 | Users shall be able to join LFGs. | completed | completed| completed |
| 1.1.3.4.5 | Users shall be able to add details name of the game, title, required platform, required language, mic/cam required and member capacity information to LFG during the creation. | completed | completed| completed |
| 1.1.3.4.6 | Users shall be able to comment on the LFGs. | completed | completed| completed |
| 1.1.3.4.7 | Users shall be able to upvote comments on LFGs. | completed | completed| completed |
| 1.1.3.4.8 | Users shall be able to downvote comments on LFGs. | completed | completed| completed |
| 1.1.3.4.9 | Users shall be able to add annotations to LFGs. | not done | not done |not done |
| 1.1.3.5.1 | Users shall be able to search for post titles according to the key provided. | completed | completed| completed |
| 1.1.3.5.2 | Users shall be able to search for LFG titles according to the key provided. | completed | completed| completed |
| 1.1.3.5.3 | Users shall be able to search for other users according to the key provided. | not done | completed| not done |
| 1.1.3.5.4 | Users shall be able to see their search history. | not done | not done | not done |
| 1.1.4.1 | Admins shall be able to see reports with the related forums. | completed | completed| not done |
| 1.1.4.2 | Admins shall be able to see reports with the related LFGs. | completed | completed| not done|
| 1.1.4.3 | Admins shall be able to see reports with the related game pages. | completed | completed| not done |
| 1.1.4.4 | Admins shall be able to ban users. | completed | completed| not done |
| 1.1.4.5 | Admins shall be able to see approve/reject game page requests from users. | completed | completed| completed |
| 1.1.4.6 | Admins shall be able to apply any kind of necessary delete operation to the contents of the platform. | completed | completed| not done|
| 1.1.5.1.1 | Guests shall be able to view the profiles of registered users. | completed | not done| completed |
| 1.1.5.2.1 | Guests shall be able to view the posts in the forum. | completed | not done| completed |
| 1.1.5.2.2 | Guests shall be able to filter post categories in the forum according to their types. | completed | completed| completed |
| 1.1.5.2.3 | Guests shall be able to view the names of the post owners in the forum. | completed | completed| completed |
| 1.1.5.3.1 | Guests shall be able to view game pages and their details(see 1.2.3). | completed | completed| completed |
| 1.1.5.4.1 | Guests shall be able to view LFGs and their details(see 1.2.4). | completed | not done| completed |
| 1.1.5.5.1 | Guests shall be able to search for post titles according to the key provided. | completed | completed| completed |
| 1.1.5.5.2 | Guests shall be able to search for game page titles according to the key provided. | completed | completed| completed |
| 1.1.5.5.3 | Guests shall be able to search for LFG titles according to the key provided. | completed | completed| completed |
| 1.1.5.5.4 | Guests shall be able to search for other users according to the key provided. | not done | not done| not done |
| 1.2.1.1 | The platform shall provide recommendations based on the recommendation logic. | completed | completed| completed |
| 1.2.1.2 | The recommendations provided by the platform shall be able to be visible on relevant places. | completed | completed| completed |
| 1.2.2.1 | Posts that are created by users shall be visible in the forum. | completed | completed| completed |
| 1.2.2.2 | Creating dates of the posts shall be visible in the forum. | completed | completed| completed |
| 1.2.2.3 | Related tags of the posts shall be visible in the forum. | completed | completed| completed |
| 1.2.2.4 | Number of upvotes given to the posts shall be visible in the forum. | completed | completed| completed |
| 1.2.2.5 | Number of downvotes given to the posts shall be visible in the forum. | completed | completed| completed |
| 1.2.2.6 | Number of upvotes given to the comments shall be visible in the forum. | completed | completed| completed |
| 1.2.2.7 | Number of downvotes given to the comments shall be visible in the forum. | completed | completed| completed |
| 1.2.2.8 | The platform shall mark posts of the post owners as "Original Poster". | completed | completed| not done |
| 1.2.2.9 | The platform shall mark comments of the post owners as "Original Poster". | completed | completed|not done |
| 1.2.2.10 | The platform shall sort posts in the forum according to their creating dates. | completed | completed| completed |
| 1.2.3.1 | Admin-approved game pages that are created/updated by users shall be public. | completed | completed| completed |
| 1.2.3.2 | Creating dates of the game pages shall be visible in the interface. | completed | completed| completed |
| 1.2.3.3 | Games pages shall be searchable by the users. | completed | completed| completed |
| 1.2.3.4 | Game pages shall include the game genre chosen from the options - Role-Playing Games (RPG), Strategy, Shooter, Sports and Racing, Fighting, and MOBA (Multiplayer Online Battle Arena). | completed | completed| completed |
| 1.2.3.5 | Game pages shall include the platform(s) on which the game is available, selected from Xbox, Computer, PS (PlayStation), and OnBoard. | completed | completed| completed |
| 1.2.3.6 | Game pages shall include information about the in-game avatar, including the GameID, Name, and Description. | completed  | completed| completed |
| 1.2.3.7 | Game pages shall include the number of players indicating the supported number of players, which can be Single, Multiple, or MMO (Massively Multiplayer Online). | completed | completed| completed |
| 1.2.3.8 | Game pages shall include the release year in which the game was released. | completed | completed| completed |
| 1.2.3.9 | Game pages shall include universe information, which is the setting or theme of the game, similar to "Medieval" for example. | completed | completed| completed |
| 1.2.3.10 | Game pages shall include mechanics information describing the gameplay mechanics used in the game, which can include Turn-Based, Chance-Based, etc. | completed | completed| completed |
| 1.2.3.11 | Game pages shall include playtime specifying the estimated duration of a game session or how long a game typically lasts. | completed  | completed| completed |
| 1.2.3.12 | Game pages shall include the official title of the game. | completed | completed| completed |
| 1.2.3.13 | Game pages shall include map information. | not done | not done| not done |
| 1.2.3.14 | Game pages shall include a game poster. | completed | completed| completed |
| 1.2.4.1 | LFG that are created by users shall be visible in the groups. | completed | completed| completed |
| 1.2.4.2 | Title of the LFG shall be visible in the groups. | completed | completed| completed |
| 1.2.4.3 | Creator of the LFG shall be visible in the groups. | completed | completed| completed |
| 1.2.4.4 | Creation date of the LFG shall be visible in the groups. | completed | completed| completed |
| 1.2.4.5 | Related tags of the LFG shall be visible in the groups. | completed | completed| completed |
| 1.2.4.6 | LFGs shall contain the name of the game, title, required platform, required language, mic/cam required and member capacity informations. | completed | completed| completed |
| 1.2.4.7 | LFGs shall contain a brief description. | completed | completed| completed |
| 1.2.4.8 | LFGs shall be searchable by the users. | completed | completed| completed |
| 1.2.4.9 | LFGs shall be able to contain tags. | completed | completed| completed |
| 1.2.4.10 | Number of upvotes given to the comments on LFG, shall be visible. | completed | completed| completed |
| 1.2.4.11 | Number of downvotes given to the comments on LFG, shall be visible. | completed | completed| completed |
| 1.2.5.1 | Texts shall be annotated in the platform. | completed | completed| completed |
| 1.2.5.2 | URL shall be annotated in the platform. | not done | not done| not done|
| 1.2.5.3 | Images shall be annotated in the platform. | completed | completed| not done |
| 1.2.6.1 | Search shall be semantic. | not done | not done| not done |
| 2.1.1 | The platform shall use HTTPS protocol. | completed | completed| completed |
| 2.1.2 | The platform shall meet the modern SSL requirements. | completed | completed| completed |
| 2.1.3 | All sensitive user data, such as passwords, shall be encrypted using a salted hashing algorithm(such as SHA-256). | completed | completed| completed |
| 2.2.1 | The platform shall strictly adhere to the regulations of GDPR and KVKK. | not done | not done| not done|
| 2.2.2 | The data usage of the users shall be clearly stated in platform’s policies. | not done | not done | not done|
| 2.2.3 | Users shall be notified when the data policies change. | not done | not done| not done|
| 2.2.4 | The privacy policy and user agreement shall be made available for users to read, accept, or decline. | not done | not done |not done |
| 2.2.5 | Users should have the ability to get their personal data as allowed by the regulations. | not done | not done|not done |
| 2.3.1 | Language of the platform shall be English.  | completed | completed| completed|
| 2.3.2 | The web interface and the android application shall support the same functionality. | completed | completed| completed |
| 2.3.3 | The platform should support [UTF-8](https://en.wikipedia.org/wiki/UTF-8) character encoding. | completed | completed| completed |
| 2.3.4 | Annotations should comply to the [W3 Web Annotation Data Model](https://www.w3.org/TR/annotation-model/#annotations) | completed| completed| completed |
| 2.4.1 | The platform shall respond to any request in at most 1 second. | not done | not done |not done |
| 2.4.2 | The platform shall support at least 10000 user accounts. | not done | not done |not done |
| 2.4.3 | The platform shall take a backup of the database every day. | not done | not done | not done|

______________
## API

### Service Endpoints Mapping

Here's a list of the service endpoints and their corresponding IP addresses and ports, along with the services they represent:

| Service Name | Domain Endpoint       | IP Address and Port        | Description  |
|--------------|-----------------------|----------------------------|--------------|
| Frontend     | game-lounge.com       | http://167.99.242.175:3000 | Frontend service |
| PgAdmin      | game-lounge.com:5000  | http://167.99.242.175:4000 | PostgreSQL admin interface |
| Backend      | game-lounge.com:9090  | http://167.99.242.175:8080 | Backend service |
| Annotation   | game-lounge.com:9091  | http://167.99.242.175:8081 | Annotation service |

### API Documentation
[Link to the swagger api documentation](https://game-lounge.com:9090/swagger-ui/index.html)

### Postman Collection
[Link to the postman collection
](https://solar-water-407923.postman.co/workspace/game-lounge-dev-team~93ec1e7a-63e8-420e-aa8a-b0bf66e5b2fe/collection/27281552-0da45587-c383-4cd0-914b-7f6371ecedee?action=share&creator=27281552)
### Game create request endpoint

#### HTTP Request
`POST http://167.99.242.175:8080/game`

#### Headers
- Content-Type: `multipart/form-data`

#### Body
Use `form-data` for sending the data. Enter the following key-value pairs:

- **Key:** `request` - **Type:** Text
- **Key:** `image` -  **Type:** File

For the 'request' you can use below json text as value:

```json
{
  "title": "Undertale",
  "description": "A unique RPG where players have the power to spare or defeat monsters in a story-rich underground world.",
  "genres": ["Adventure"],
  "platforms": ["Computer", "PS", "XBOX"],
  "playerNumber": "Single",
  "releaseYear": 2015,
  "universe": "Fantasy",
  "mechanics": "Empty",
  "playtime": "6",
  "totalRating": 0,
  "countRating": 0,
  "averageRating": 0.0
}
```

#### Sending the Request in Postman

1. Open Postman.
2. Set the method to `POST`.
3. Enter the URL `http://167.99.242.175:8080/game`.
4. Go to the `Headers` tab:
   - Ensure `Content-Type` is set to `multipart/form-data`.
5. Go to the `Body` tab:
   - Select `form-data`.
   - Enter the key-value pairs as specified above.
   - For the `image` key, select the image file to upload.
6. Click `Send` to make the request.


### Creating Looking for Group (LFG) endpoint

#### HTTP Request
`POST http://167.99.242.175:8080/lfg`

#### Headers
- Content-Type: `application/json`

#### Body
Select `raw` and `JSON` format, and input the following JSON object:

```json
{
  "title": "Looking for pro players",
  "description": "We need a midlaner and toplaner for the LOL",
  "requiredPlatform": "PC",
  "requiredLanguage": "English",
  "micCamRequirement": true,
  "memberCapacity": 5,
  "gameId": null,
  "tags": ["LOL", "Moba"]
}
```

### Creating a forum post endpoint

#### HTTP Request
`POST http://167.99.242.175:8080/forum/posts`

#### Headers
- Content-Type: `application/json`

#### Body
Select `raw` and `JSON` format, and enter the following JSON object:

```json
{
  "title": "Mastering Fortnite Building: A Beginner's Guide",
  "content": "New to Fortnite or struggling with building? This guide breaks down the basics of building structures, advanced techniques, and how to gain the high ground in intense battles.",
  "category": "GUIDE",
  "tags": ["fortnite", "guide"]
}
```
______________


## User Interface / User Experience
### Frontend
#### Homepage

[Source Code](https://github.com/bounswe/bounswe2023group6/tree/develop/app/frontend/src/pages/HomePage)

<img width="1440" alt="Ekran Resmi 2023-12-29 00 33 14" src="https://github.com/bounswe/bounswe2023group6/assets/123978913/9d9e719a-e4df-4d1e-b54a-fc35b6f49afc">


#### Game Forum Page

[Source Code](https://github.com/bounswe/bounswe2023group6/tree/develop/app/frontend/src/pages/GameForum)

<img width="1440" alt="Ekran Resmi 2023-12-29 00 46 54" src="https://github.com/bounswe/bounswe2023group6/assets/123978913/0f13ae8a-0f37-472e-99dd-c4a7c29364a4">

<img width="1435" alt="Ekran Resmi 2023-12-29 01 16 40" src="https://github.com/bounswe/bounswe2023group6/assets/123978913/995f8fd4-7b09-406c-97d1-3fc208a08b22">


#### Post Forum Page

[Source Code](https://github.com/bounswe/bounswe2023group6/tree/develop/app/frontend/src/pages/ForumPage)

<img width="1440" alt="Ekran Resmi 2023-12-29 00 47 10" src="https://github.com/bounswe/bounswe2023group6/assets/123978913/6f7b60f1-5e41-442b-986c-99e80f187101">

#### LFG Forum Page

[Source Code](https://github.com/bounswe/bounswe2023group6/tree/develop/app/frontend/src/pages/LfgPage)

<img width="1440" alt="Ekran Resmi 2023-12-29 00 47 38" src="https://github.com/bounswe/bounswe2023group6/assets/123978913/ff24ba64-76a5-4b31-a014-bb700e221632">

#### Profile Page

[Source Code](https://github.com/bounswe/bounswe2023group6/tree/develop/app/frontend/src/pages/Profile)

<img width="1440" alt="Ekran Resmi 2023-12-29 00 54 13" src="https://github.com/bounswe/bounswe2023group6/assets/123978913/ffb94517-377b-4dec-882f-9a95d3ff9644">

#### Game Details Page

[Source Code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/frontend/src/pages/GamePage/GamePage.js)

<img width="1440" alt="Ekran Resmi 2023-12-29 15 44 02" src="https://github.com/bounswe/bounswe2023group6/assets/123978913/1dc2db78-816d-4e9a-b5ae-7c4a3a3f3786">

#### Game Creation Popup

[Source Code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/frontend/src/pages/GameForum/CreateGame.js)

<img width="1440" alt="Ekran Resmi 2023-12-29 00 56 57" src="https://github.com/bounswe/bounswe2023group6/assets/123978913/16829016-6a7c-454a-a40d-d0d6ab4fb482">

#### Post Comments Page with Annotation

[Source Code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/frontend/src/pages/PostPage/PostPage.js)

<img width="1437" alt="Ekran Resmi 2023-12-29 00 49 56" src="https://github.com/bounswe/bounswe2023group6/assets/123978913/bb7cf2e1-dddd-4650-ae70-b0c6d452196d">

#### Post Creation Popup

[Source Code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/frontend/src/pages/ForumPage/CreatePost.js)

<img width="1440" alt="Ekran Resmi 2023-12-29 00 57 11" src="https://github.com/bounswe/bounswe2023group6/assets/123978913/1426e35b-3485-4edb-bcb6-76276146f51c">

#### Signup

[Source Code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/frontend/src/pages/Auth/Signup.js)

<img width="960" alt="Ekran Resmi 2023-12-29 00 36 30" src="https://github.com/bounswe/bounswe2023group6/assets/123978913/7b4528b5-330b-4b43-8ab2-843e76e750e8">

#### Login

[Source Code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/frontend/src/pages/Auth/Login.js)

<img width="960" alt="Ekran Resmi 2023-12-29 00 40 36" src="https://github.com/bounswe/bounswe2023group6/assets/123978913/a53bc5dd-db76-4430-89bf-4aeb68f23d8c">

#### Forgot Password

[Source Code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/frontend/src/pages/Auth/ForgotPassword.js)

<img width="960" alt="Ekran Resmi 2023-12-29 00 40 55" src="https://github.com/bounswe/bounswe2023group6/assets/123978913/59d08fd5-494b-4dd3-ba23-f431d8ccc4bc">

#### Admin Panel

[Source Code](https://github.com/bounswe/bounswe2023group6/tree/develop/app/frontend/src/pages/AdminPanel)

<img width="1440" alt="Ekran Resmi 2023-12-29 01 09 07" src="https://github.com/bounswe/bounswe2023group6/assets/123978913/fe84cb12-7efe-4c25-aba5-48b717430e37">

#### Search Results Page

[Source Code](https://github.com/bounswe/bounswe2023group6/tree/develop/app/frontend/src/pages/Search)

<img width="1440" alt="Ekran Resmi 2023-12-29 16 29 17" src="https://github.com/bounswe/bounswe2023group6/assets/123978913/d573be6d-b71d-4d10-b6d2-180ee3548a39">

### Mobile

#### Home Page
![image](https://github.com/bounswe/bounswe2023group6/assets/70749779/e3e74bd5-910c-4d9e-864a-54832db199f8)

[Source code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/mobile/lib/presentation/pages/home_page.dart)

#### Search Page
![image](https://github.com/bounswe/bounswe2023group6/assets/70749779/dcbcd519-2fc2-4997-bbc5-51bba5e724ac)

[Source code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/mobile/lib/presentation/widgets/searchbar_widget.dart)


#### Forum Page
![image](https://github.com/bounswe/bounswe2023group6/assets/70749779/b602db8f-9518-4537-b15c-544c4e3ddcba )

[Source code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/mobile/lib/presentation/pages/forum_page.dart)

#### Create Post Page
![image](https://github.com/bounswe/bounswe2023group6/assets/70749779/b52a3c07-4168-4798-8a91-eb78b09090b2)

[Source code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/mobile/lib/presentation/pages/post/post_create_page.dart)

#### Post Page
![image](https://github.com/bounswe/bounswe2023group6/assets/70749779/750f298d-97d8-4d48-ac39-7bc1b0f534d9)

[Source code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/mobile/lib/presentation/pages/post/post_page.dart)

Other related codes: 
- [Card widget source code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/mobile/lib/presentation/pages/post/content_card_widget.dart)
- [Report widget source code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/mobile/lib/presentation/pages/post/report_widget.dart)
- [Update widget source code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/mobile/lib/presentation/pages/post/update_widget.dart)

#### Games Page

<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/a7d79c87-d064-43fa-be2d-bb348e018666" width="360" >

[Source code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/mobile/lib/presentation/pages/game_page.dart)

#### Create Game Page

<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/8e4c7379-8083-4232-b4e1-cd8881371492" width="360" >

[Source code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/mobile/lib/presentation/pages/game_page_create.dart)

#### Game Page

<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/09350588-cb1a-46eb-a6e3-88568927fe54" width="360" >
<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/22926c15-eff7-4e09-9da1-8fbb804a66b6" width="360" >
<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/f471f1a8-11bb-4a14-8473-4935af868fb8" width="360" >

[Source code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/mobile/lib/presentation/pages/game_wiki_page.dart)

#### LFGs Page

<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/bc922253-06a8-403c-817a-2a1944963619" width="360" >

[Source code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/mobile/lib/presentation/pages/lfg_page.dart)

#### Create/Update LFG Page

<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/ad9da35e-996c-4a21-ab71-67f120db0267" width="360" >

[Source code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/mobile/lib/presentation/pages/lfg_page_create.dart)

#### LFG Page

<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/8123ba49-a117-42f8-bfde-0a420869786b" width="360" >

[Source code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/mobile/lib/presentation/pages/group_page.dart)

#### Profile Page

<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/96771bc3-8940-4d72-a76a-71ec02177244" width="360" >

[Source code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/mobile/lib/presentation/pages/profile_page.dart)

#### Admin Panel Page

<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/30e0bac9-9650-4887-964d-10be23354eb0" width="360" >

[Source code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/mobile/lib/presentation/pages/admin_panel.dart)

#### Game Approve Page

<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/c46fe213-4cc3-4230-a185-ed4038e9e3ec" width="360" >

[Source code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/mobile/lib/presentation/pages/admin/admin_game_page.dart)

#### Post Reports Page

<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/bc0c3970-0216-4952-ac77-38667110c16b" width="360" >

[Source code](https://github.com/bounswe/bounswe2023group6/blob/develop/app/mobile/lib/presentation/pages/admin/admin_post_page.dart)



### Annotations
#### Status:
- **Image annotation** is implemented on the **mobile** only.
- **Text annotation** is implemented on both **mobile** and **web**.
#### Compliance with W3C WADM:
- The parts that we have implemented are fully complies with the W3C standarts. 
- Our implementation has subset of the futures that are described in W3C Annotation Data Model. This subset of futures are tailored specifically for our applications needs. 
- To make it more discrete by giving examples, we opted for having two selectors only, since the rest of the selectors defined in W3C Annotation Data Model had no meaningful use case in our implementation.
- We made annotation consisting of multiple bodies possible but limited the number of target exactly to one. Though else is possible and implemented in the backend we created one annotation at a time for a pair of body and target (for our application that was the only meaningful use case).
- Examples below demostrates the all possible fields in an annotation. In order to determine which fields to make required and which fields to make optional we followed the W3C annotation data model and made all fields indicated as 'must' which the meaning and scope of it described in [rfc2129](https://datatracker.ietf.org/doc/html/rfc2119).

#### Implementation description
- We have implemented our annotation server as a separate service which has its own docker image and database. Even though it runs on the same machine they are different application which listens to different ports.
- For annotation service we utilized a postgresql db do model our annotation data model that complies with W3C standarts.
- For both mobile and frontend no libraries are used directly to implement the annotations. Our team developed the necessary infrastructure to annotate contents for themselves.

#### API calls examples to annotation server:
Image annotation creation:
```http
POST /annotation/create HTTP/1.1
Host: game-lounge.com:9091
Content-Type: application/json
Content-Length: 768

{
    "context": "http://www.w3.org/ns/anno.jsonld",
    "id": "YourAnnotationId",
    "type": "Annotation",
    "motivation": [
        "commenting",
        "annotating"
    ],
    "creator": "backendUser",
    "created": "2023-03-01T12:00:00",
    "body": [
        {
            "id": "YourBodyId",
            "type": "TextualBody",
            "value": "This is a post!",
            "format": "text/plain",
            "language": "en",
            "purpose": "commenting"
        }
    ],
    "target": {
        "id": "https://game-lounge-storage.s3.eu-north-1.amazonaws.com/game-pictures/7",
        "format": "text/html",
        "language": "tr",
        "selector": {
            "type": "Text",
            "value": "xywh=10,20,150,200"
        }
    }
}
```
Textual annotation creation:
```http
POST /annotation/create HTTP/1.1
Host: game-lounge.com:9091
Content-Type: application/json
Content-Length: 742

{
    "context": "http://www.w3.org/ns/anno.jsonld",
    "id": "YourAnnotationId",
    "type": "Annotation",
    "motivation": [
        "commenting",
        "annotating"
    ],
    "creator": "backendUser",
    "created": "2023-03-01T12:00:00",
    "body": [
        {
            "id": "YourBodyId",
            "type": "TextualBody",
            "value": "This is a post!",
            "format": "text/plain",
            "language": "en",
            "purpose": "commenting"
        }
    ],
    "target": {
        "id": "http://167.99.242.175:8080/post/1",
        "format": "text/html",
        "language": "tr",
        "selector": {
            "type": "FragmentSelector",
            "value": "xywh=10,20,150,200"
        }
    }
}
```
Annotation retrieval by annotation id:
```http
GET /annotation/your-annotation-id HTTP/1.1
Host: game-lounge.com:9091
```
Annotation retrieval by target id:
```http
POST /annotation/get-annotations-by-target HTTP/1.1
Host: game-lounge.com:9091
Content-Type: application/json
Content-Length: 55

{
    "targetId": "http://167.99.242.175:8080/post/1"
}
```


## Scenario

#### Mauro Oblak

![Mauro](https://github.com/bounswe/bounswe2023group6/assets/113240964/d6028cad-83bd-4525-b20c-f2d940e3c14c)


#### User Info

User Type: Gamer

User Tags: MMORPG, Affliction Warlock, Witcher, Red Dead Redemption, Baldur's Gate

About me: Hey there! I'm Mauro, a university student with an insatiable passion for games. Whether I'm navigating virtual realms or unraveling the intricate plots of my favorite titles, the world of gaming is my playground. Beyond the screen, I'm on a quest to make new friends who share my enthusiasm for gaming. Curiosity is my guide, and forums are my digital campfire, where I love diving into discussions, seeking insights, and sharing tales of epic victories. Join me in this adventure, where pixels come to life, friendships are forged, and every game is a new chapter waiting to be written! 🎮✨

#### Story

Mauro, a spirited university student immersed in the world of games, set out on a quest to find a gaming platform that transcended the ordinary. In his virtual exploration, he stumbled upon a unique haven—an inviting realm that promised more than just gameplay. As he entered, he found a vibrant community where pixels transformed into shared stories, victories became communal celebrations, and a colorful tapestry of experiences awaited. This enchanting platform wasn't just a space for games; it was a digital sanctuary where friendships blossomed, knowledge flowed, and the thrill of victory was only rivaled by the shared passion of a diverse gaming family. In this realm, Mauro discovered that his gaming journey had evolved into an odyssey of connections, shared experiences, and the unwritten tales of countless adventures yet to unfold.

#### Goals

Mauro's aspirations within this captivating gaming realm are both diverse and dynamic. His foremost ambition is to forge new friendships, connecting with kindred spirits who share his fervor for gaming. Eager to deepen his understanding of various games, Mauro's second goal is to immerse himself in a wealth of gaming knowledge, discovering the intricacies of different virtual worlds. Additionally, he aims to transform his questions and curiosities about games into vibrant discussions by actively participating in forums—a space where he can seek answers, share insights, and engage in lively conversations with fellow gamers. Through these goals, Mauro envisions not just a gaming platform but a thriving community where friendships flourish, knowledge flows, and the collective passion for gaming forms the foundation of an unforgettable digital odyssey.

#### Preconditions

* Mauro Oblak is a registered user

#### Actions 

* He is on the login page.
* He enters his credentials and signs in.
* He goes to the game page.
* He enters the Elder's Ring gamepage.
* He gives rate to the game.
* He search casual event group.
* He joins casual event group.
* He add a comment.
* He goes to ahmetalperoğlu profile and follow him.
* He goes to the forum page.
* He enters Witcher's post.
* He adds a comment and dislikes the post.
* He adds an annotation.
* He goes to the groups page.
* He create a new lfg.
* He logs out of his account.

#### Acceptance Criteria

* 1.1.1.3 Users shall be able to login and logout to platform.
* 1.1.2.2 Users shall be able to view other profile pages which are visible.
* 1.1.3.1.1 Users shall be able to view profiles of other users.
* 1.1.3.1.2 Users shall be able to follow other users.
* 1.1.3.2.4 Users shall be able to create comments.
* 1.1.3.2.9 Users shall be able to upvote posts.
* 1.1.3.2.10 Users shall be able to downvote posts.
* 1.1.3.2.11 Users shall be able to upvote comments.
* 1.1.3.2.13 Users shall be able to add tags to their posts.
* 1.1.3.2.14 Users shall be able to reply to posts.
* 1.1.3.2.18 Users shall be able to view the names of the post owners in the forum.
* 1.1.3.2.20 Users shall be able to add annotations to posts.
* 1.1.3.3.3 Users shall be able to display game pages.
* 1.1.3.3.4 Users shall be able to upvote game pages.
* 1.1.3.4.1 Users shall be able to create LFGs.
* 1.1.3.4.4 Users shall be able to join LFGs.
* 1.1.3.4.5 Users shall be able to add details name of the game, title, required platform, required language, mic/cam required and member capacity information to LFG during the creation.
* 1.1.3.4.6 Users shall be able to comment on the LFGs.
* 1.1.3.5.2 Users shall be able to search for LFG titles according to the key provided.
* 1.1.5.2.1 Guests shall be able to view the posts in the forum.
* 1.1.5.3.1 Guests shall be able to view game pages and their details(see 1.2.3).
* 1.1.5.4.1 Guests shall be able to view LFGs and their details(see 1.2.4).
* 1.1.3.4.4 Users shall be able to join LFGs
* 1.1.3.4.6 Users shall be able to comment on LFG
* 1.2.4.1 LFG that are created by users shall be visible in the groups.
* 1.2.4.2 Title of the LFG shall be visible in the groups.
* 1.2.4.3 Creator of the LFG shall be visible in the groups.
* 1.2.4.4 Creation date of the LFG shall be visible in the groups.
* 1.2.4.5 Related tags of the LFG shall be visible in the groups.
* 1.2.4.6 LFGs shall contain the name of the game, title, required platform, required language, mic/cam required and member capacity informations.
* 1.2.4.7 LFGs shall contain a brief description.
* 1.2.4.9 LFGs shall be able to contain tags.

#### Mockups
1- He enters his credentials and signs in.
![image](https://github.com/bounswe/bounswe2023group6/assets/113240964/a6b81e97-7a7c-4b1d-9332-71d3b3a78673)

2- He see homepage.
![image](https://github.com/bounswe/bounswe2023group6/assets/113240964/afe0bcec-8bd1-4422-8809-e387fdddd44b)

3- He goes to the game page.
![image](https://github.com/bounswe/bounswe2023group6/assets/113240964/5bd4e8a4-3a04-45e2-8e2a-c9a755c01094)

4- He enters the Elder's Ring gamepage and gives rating.
![image](https://github.com/bounswe/bounswe2023group6/assets/113240964/f1abd64a-34af-4631-afc3-e066176ebb5e)

5- He search casual event group, joins the lfg, and adds a comment.
![image](https://github.com/bounswe/bounswe2023group6/assets/113240964/a69774a9-314f-4431-894e-c41fb550149e)
![image](https://github.com/bounswe/bounswe2023group6/assets/113240964/c70b8630-c381-4847-b680-702397d8d141)
![image](https://github.com/bounswe/bounswe2023group6/assets/113240964/36c335ba-19ff-4b8f-a3f7-c751d35e1aad)
![image](https://github.com/bounswe/bounswe2023group6/assets/113240964/c1166044-5412-4ad5-a076-3f6e9144e8bb)

6- He goes to ahmetalperoglu profile and follows him.
![image](https://github.com/bounswe/bounswe2023group6/assets/113240964/3dbff6aa-e104-461a-a257-55389ee1a87e)

7- He goes to forum page.
![image](https://github.com/bounswe/bounswe2023group6/assets/113240964/c6568a8a-fa1c-4354-a664-323055e6826e)

8- He enters Witcher's post and adds a comment and dislikes the post.
![image](https://github.com/bounswe/bounswe2023group6/assets/113240964/9e022775-eabc-4433-a46f-52f17a6691df)

9- He adds an annotation to the post.
![image](https://github.com/bounswe/bounswe2023group6/assets/113240964/b149297e-2b49-4e81-8fae-c599cdd449c6)

10- He goes to the group page.
![image](https://github.com/bounswe/bounswe2023group6/assets/113240964/35de35d1-07f9-4e48-a14c-e64ebbc48eea)

11- He creates a new lfg.
![image](https://github.com/bounswe/bounswe2023group6/assets/113240964/2f430b24-49ef-48db-a0d7-2626cd7f2975)
![image](https://github.com/bounswe/bounswe2023group6/assets/113240964/fd810cc5-e195-495f-a738-0b26fbce42db)

12- He logs out of his account.
![image](https://github.com/bounswe/bounswe2023group6/assets/113240964/d179e342-8629-4e98-8dbf-747f60d64de1)

13- He is redirected to homepage.
![image](https://github.com/bounswe/bounswe2023group6/assets/113240964/8ea24654-ac11-4f5e-b8ed-d3992ae60f0c)

### Work that has been completed related to the features necessary to realize this scenario

1. **User Authentication and Registration:**
   - Implemented a secure user authentication and registration system.
   - Created a user profile structure to store information such as user type, tags, and an "About Me" section.

2. **User Profile Customization:**
   - Enabled users to customize their profiles by specifying user type, adding tags related to their gaming preferences and providing a personalized "About Me" section.

3. **Gaming Platform Interface:**
   - Developed an intuitive gaming platform interface.
   - Incorporated a dynamic and visually appealing layout to enhance user engagement.

4. **Preconditions and Actions:**
   - Established preconditions such as user registration, login credentials, and user status tracking.
   - Developed actions to simulate Mauro's journey, including navigating through login, game pages, rating games, searching and joining groups, following other users, interacting with forum posts, and creating new content like Looking for Group (LFG).

5. **Forum and Group Functionality:**
   - Integrated a forum system with the ability to browse, comment, and interact with posts related to specific games (e.g., Witcher).
   - Implemented group functionalities, allowing users to search, join, and create casual event groups.

6. **Annotations and Rating System:**
   - Added features for users to add annotations to posts, enhancing interaction and user-generated content.
   - Integrated a rating system for games and forum posts, allowing users like Mauro to express their preferences.

7. **Logout Functionality:**
   - Implemented a secure logout functionality, ensuring that users like Mauro can easily exit their accounts.


### Use and Maintanence
Our expansive project has been successfully deployed on the internet, offering universal accessibility to a diverse array of devices equipped with an internet connection and a standard web browser. Our web project, easily accessible through any web browser, provides a seamless experience to users across different devices, ensuring broad reach and convenience.

On the mobile side, our project leverages the versatile Flutter framework, known for its cross-platform capabilities. Flutter empowers us to create a singular mobile application that transcends platform boundaries, allowing it to be seamlessly built for both Android and iOS environments. This ensures that our mobile application can be executed effortlessly on a wide spectrum of mobile devices, providing users with a consistent and optimal experience regardless of their chosen platform. The utilization of Flutter not only enhances the efficiency of development but also broadens the scope of our project, making it accessible to a diverse audience with varying mobile devices and preferences.


## Project Artifacts
### User Manual
#### Mobile
##### Signing In

<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/95e1704b-2068-4998-be53-375f157314b7" width="360" >

- 1 -> Username must be not selected. 
- 2 -> Email must be valid address. 
- 3 -> Password must have at least 8 characters. Password should contain at least one upper case. Password should contain at least one digit.  
- 4 -> Confirm password must match with password.
- 5 -> Click to submit register form.

##### Login

<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/b542105d-a3c5-4583-b986-3c70523356a8" width="360" >

- Credentials must be true.
- Click submit to login.

##### Home Page
![image](https://github.com/bounswe/bounswe2023group6/assets/70749779/8d7ad3cc-9177-4b27-aaed-85b758b1289f)

- 1 -> Search Bar: Search page can be opened from this section. 
- 2 -> Recommended Games: Recommended games based on the user shown here. 
- 3 -> Recommended Posts: Recommended posts based on the user shown here. 
- 4 -> Recommended LFGs: Recommended lfgs(looking for groups) based on the user shown here.


##### Search Page
![image](https://github.com/bounswe/bounswe2023group6/assets/70749779/dba23c52-a033-4421-82c1-af6d68465544)

- 1 -> Search Bar: Search query should be written here. 
- 2-3 -> Context selection dropdown: Context of the search can be selected from here. 
- 4 -> Search result: Search result will be shown here(posts, games and lfgs seperately).


##### Forum Page
![image](https://github.com/bounswe/bounswe2023group6/assets/70749779/365b8ecf-f89d-4e24-9bfb-d9c1d1b3eefd)

- 1 -> Post Card: Some content of the post shown here. It redirects to post page on click. 
- 2 -> Create post button: Redirects to create post page. Only shown to logged in users.  
- 3 -> Filter posts button: Opens the filter widget on the second page. 
- 4 -> Filter widget: Posts can be filtered based on a game(game should be selected and apply button should be clicked). 
 

##### Post Create
![image](https://github.com/bounswe/bounswe2023group6/assets/70749779/eaa4d3e0-362d-4c17-97ba-35921a97b3f4)

- 1 -> Title input section: Title of the post should be entered here(must).  
- 2 -> Description input section: Description of the post should be entered here(must).  
- 3 -> Game selection dropdown: Related game of the post can be selected from here(must). Selection must be made between already created games. 
- 4 -> Category selection dropdown: Category of the post can be selected from here(must).  
- 5 -> Tags input section: Tags for the post can be entered from here(not must). Any string can be entered as tag.  


##### Post Page
![image](https://github.com/bounswe/bounswe2023group6/assets/70749779/d0c5e6fa-330e-4603-94df-a9bc7af1ed93)

- 1 -> Profile Information Section: Some information(name, image) about the owner of the post shown here. Redirects to profile page on click.  
- 2 -> Title Section: Title of the post shown here.   
- 3 -> Category Section: Category of the post shown here.  
- 4 -> More Options Dropdown: More options dropdown shown here. Opens the dropdown in the second page on click.    
- 5 -> Description Section: Description of the post shown here.  
- 6 -> Tags Section: Tags of the post shown here.  
- 7 -> Social Section: Social information about the post(comment count, like-dislike count) shown here. Post can be liked or disliked from this section.  
- 8 -> Add New Comment Section: New comment to the post can be entered from here. 
- 9 -> Post Edit Section: Post content can be edited from here(only shown to the owner).  
- 10 -> Post Delete Section: Post can be deleted from here(only shown to the owner).  
- 11 -> Go to Game Page Section: Redirects to the related game page on click.  
- If not owner, report section also shown on the dropdown. 

##### Comment Card
![image](https://github.com/bounswe/bounswe2023group6/assets/70749779/56adf4c6-c828-4d72-a3fd-7f1644ccc6f2)

- 1 -> Comment Card: Similar to post card(profile section, like, dislike, more options section).
- 2 -> Comment more options dropdown: Similar to post dropdown(edit, delete, report). Only difference is comment can also be replied.    
- 3 -> Reply Section: When some comment is replied, this section shown inside the comment card. 


##### Profile Page(own profile)

<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/92db3853-c2ee-4dc5-b729-fa0dff1ad5b0" width="360" >

- 1 -> Profile Image: Change profil image 
- 2 -> Visibility: Change visibility of profile page.    
- 3 -> Change Profile Information: Change Title and Company. 
- 4 -> Add Tags: Add tags to profile page. 
- 5 -> About Me: Edit your profile description. 
- 6 -> Created Post: Created posts by user shown. Redirects to post page on click.
- 7 -> Liked Post: Liked posts by user shown. Redirects to post page on click.
- Games: Games rated 4 or above by user shown. Redirects to game page on click.

##### Profile Page(other's profile)

<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/a8bae2d0-4c21-446e-94c6-c63221496ffc" width="360" >

- 1 -> Follow/Unfollow: Follow/unfollow user 

##### Lfg List Page

<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/1ce9ec7c-8575-4cd5-8acd-5f8447e5741f" width="360" >

- 1 -> Lfg Card: Title of lfg shown. Redirects to Lfg page on click. 
- 2 -> Change View Button: Change grid view of page.    
- 3 -> Create Lfg Button: Redirects to Create Lfg page on click. If user is guest redirect to Login page on click 

##### Create Lfg
<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/c4021391-531d-456d-ba67-677b086e17f8" width="360" >

- 1 -> Lfg Information: Fill title, description, platform, language, Mic/Cam requirement, group size, game and tags(optional) information to create lfg.
- 2 -> Create Button: Click to create lfg. To see the lfg after creating click on logo on appbar.

##### Lfg Page
<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/27b14ec6-a364-4b3e-94f2-bd274b7d1f0b" width="360" >
<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/bdae8d24-1531-41ce-90ec-2c0cc8f9063a" width="360" >

- 1 -> Lfg Information: See title, description, platform, language, Mic/Cam requirement, group size, game, tags, post owner and creation date
- 2 -> Join/Leave button: Join/leave group
- 3 -> Members button: Members of group shown
- 4 -> Comment: Comment to Lfg post
- 5 -> Update Lfg: Update Lfg information. If you are not owner of post it doesn't let you update 

##### Game List Page
<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/ab023e9d-57bb-4667-a09e-b7833208bfc3" width="360" >

- 1 -> Game Card: Title and image of game shown. Redirects to Game page on click. 
- 2 -> Change View Button: Change grid view of page.    
- 3 -> Create Game Button: Redirects to Create Game page on click. If user is guest redirect to Login page on click 

##### Create game page
<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/10cb4312-f158-4290-9514-8b75edab0423" width="360" >

- 1 -> Game Information: Fill title, description, genre, platforms, player number, release year, universe, mechanic and playtime information to create game.
- 2 -> Choose Image: Choose image for game from image picker.
- Create Button: Click to create game. Admin must approve after creation.

##### Game page
<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/123f181d-f550-474e-9ed8-02de32da885b" width="360" >
<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/df559ba3-3119-42db-be30-b896b6dc2a58" width="360" >

- 1 -> Rating: Rate game. Rating will be updated after reopening page
- 2-3 -> Information: Information about game
- 4 -> Character: See characters of the game. Click plus button to create character
- 5 -> Similar games: See similar games of this game. Click to redirect similar game's page
- 6 -> Related Post: See posts connected to this game. Redirects to post page on click.
- 7 -> Related Lfg: See lfgs connected to this game. Redirects to post page on click.

##### Admin Page

<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/4fb2a990-a2c0-4d5e-a00c-b1217ac81ca1" width="360" >
<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/60455103-b84e-4d9f-a7f9-b39e68f63fc5" width="360" >

- 1 -> Drawer: Click admin panel on the drawer after logged as admin
- 2 -> Game Card: Title and image of game shown. Redirects to Game page on click.
- 3 -> Reports Tab: Reports to post shown in this tab.

##### Admin Game Page

<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/af3b6000-eec6-40e2-9b12-7b5f68f11ac2" width="360" >

- 1 -> Information: Created game information 
- 2 -> Approve Button: Click to approve creation of game.
- 3 -> Reject Button: Click to reject creation of game.

##### Admin Post Page

<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/708f6800-8391-46e5-9ac7-fd83fc03a71e" width="360" >

- 1 -> Report Message and Post Information 
- 2 -> Cancel Button: Click to cancel report.
- 3 -> Delete Button: Click to delete reported post.
- 4 -> Ban User Button: Click to ban owner user of reported post.

##### Annotations

<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/84ab7c8f-4e63-4b73-ae76-3bc199b0f33a" width="360" >
<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/99fc299c-a725-4310-a1f4-42270041a3f0" width="360" >
<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/f16fb758-b332-4a0d-bc3d-e17ab1b3f4d6" width="360" >

- 1 -> Report Message and Post Information 
- 2 -> Cancel Button: Click to cancel report.
- 3 -> Delete Button: Click to delete reported post.

<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/9f3a1a3a-e527-4f1d-a561-b90d35fe4810" width="360" >
<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/6b304775-582f-4760-ba26-683061bc0353" width="360" >
<img src="https://github.com/bounswe/bounswe2023group6/assets/56885279/5d1602ff-020e-4ca3-a93a-a03cca7596ff" width="360" >

- 1 -> Report Message and Post Information 
- 2 -> Cancel Button: Click to cancel report.
- 3 -> Delete Button: Click to delete reported post.

#### Web

##### Signup
<img width="1439" alt="Screenshot 2023-12-29 at 21 05 07" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/5e5c6002-76d4-496d-aba9-73c67cd9386a">

Guest users should go to the  [signup page](https://game-lounge.com/signup) and fill the necessary areas with valid inputs. After that they can create an account with Sign Up button.

##### Login
<img width="1440" alt="Screenshot 2023-12-29 at 21 09 16" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/ca7ffbf1-86f1-4f9f-99e1-302cbb48226f">

Registered users should go to the [login page](https://game-lounge.com/login) and enter their email and password after that they can login with the Log In button. 
* Not registered users can create an account clicking the Signup.
* Registered users who forgot their password can click the Forgot Password to reset their passwords.
### Forgot Password

<img width="1440" alt="Screenshot 2023-12-29 at 21 12 51" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/173efc5d-dd4b-41be-8d43-fe6ec9864a2d">

Registered users should go to the [forgot password page](https://game-lounge.com/forgot-password) and enter their username and email to reset their passwords. 
##### Homepage
<img width="1439" alt="Screenshot 2023-12-29 at 21 18 11" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/8dab2cb9-a5ef-42d0-98f2-8ca0707d3349">

- 1 -> Search Bar: Search page can be opened from this section. 
- 2 -> Recommended Games: Recommended games based on the user shown here. 
- 3 -> Recommended Posts: Recommended posts based on the user shown here. 
- 4 -> Recommended LFGs: Recommended lfgs(looking for groups) based on the user shown here.
- 5 -> Recommended users: Recommended users based on the user shown here.

##### Search Page
<img width="1440" alt="Screenshot 2023-12-29 at 21 24 22" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/057ad8fd-b144-4341-87e6-6479a75155c1">

- 1 -> Search Bar: Users should enter the input to search. 
- 2 -> Related Games: Related games based on the search input shown here. 
- 3 -> Related LFGs: Recommended lfgs(looking for groups) based on the search input shown here.
- 4 -> Related Posts: Recommended posts based on the search input shown here.

##### Game Forum Page
 
<img width="1440" alt="Screenshot 2023-12-29 at 21 30 29" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/4946a9e9-0e15-44ba-aa25-69bc99dc95b8">

All the games shown in the[game forum page](https://game-lounge.com/game) for the users including guest users. 

- 1 -> Platform Filter: Users can filter the games based on their platforms. 
<img width="137" alt="Screenshot 2023-12-29 at 21 36 27" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/cb7cbde0-a0c1-47e3-8f03-9cc12e64a7b2">

- 2 -> Player number filter: Users can filter the games based on their player numbers.
<img width="185" alt="Screenshot 2023-12-29 at 21 36 34" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/24640789-1c66-4108-a6ad-7a36b2d52e74">

- 3 -> Universe Info filter: Users can filter the games based on their universe info.
<img width="159" alt="Screenshot 2023-12-29 at 21 36 41" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/63f1b175-5a2d-4740-89e2-b2961995611a">

- 4 -> Game mechanics filter: Users can filter the games based on their game mechanics.
<img width="195" alt="Screenshot 2023-12-29 at 21 36 47" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/2d7c7fa3-11a6-4041-9304-5684d74c861e">

- 5 -> Genre Filter: Users can filter the games based on their genres.
<img width="118" alt="Screenshot 2023-12-29 at 21 36 55" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/d4adf305-50ee-4072-aafc-b3909865e0ea">

- 6 -> Search bar for games: Users can search the games based on their inputs.
- 7 -> Create game Registered users can create a new game.
<img width="597" alt="Screenshot 2023-12-29 at 21 43 16" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/271bfde6-1216-465e-a1f5-df02b5cc11b8">

<img width="601" alt="Screenshot 2023-12-29 at 21 45 41" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/f7a7d1eb-71f1-4f6e-a417-761556c31e5d">

* Title:Title of the game should be entered here(must).
* Description: Description of the game should be entered here(must).
* Genre: Genre of the game should be selected here(must). Users can select multiple genres.
* Platform: Platform of the game should be selected here(must). Users can select multiple platforms.
* Number of players: Number of the players of the game should be selected here(must).
* Release Year : Release year of the game should be entered here(must).
* Universe info : Universe info  of the game should be selected here(must).
* Game mechanics : Game mechanics of the game should be selected here(must).
* Playtime : Playtime of the game should be entered here(must).
* Image : Image of the game should be uploaded here(must).
* Similar games : Similar games can be selected here(optional).

##### Game Page
<img width="1440" alt="Screenshot 2023-12-29 at 22 08 53" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/8a373b08-867b-4c9d-bb59-30e6e61533e9">

- 1 -> Game Details: All the details of game will be shown here. 
- 2 -> Edit Game: Registered users can create a request to edit game.
 
<img width="600" alt="Screenshot 2023-12-29 at 22 15 08" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/72766027-a642-4117-93da-c62002e50f68">
<img width="589" alt="Screenshot 2023-12-29 at 22 15 20" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/4a5d7cac-9ce2-4100-bb6f-6a2b30979c65">

* Title:Title of the game can be updated here.
* Description: Description of the game can be updated here.
* Genre: Genre of the game can be updated here. Users can select multiple genres.
* Platform: Platform of the game can be updated here. Users can select multiple platforms.
* Number of players: Number of the players of the game can be updated here(must).
* Release Year : Release year of the game can be updated here.
* Universe info : Universe info  of the game can be updated here.
* Game mechanics : Game mechanics of the game can be updated here.
* Playtime : Playtime of the game can be updated here.
* Image : Image of the game can be updated here.

- 3 -> Rate Game: Registered users can rate the game here.
- 4 -> Games may be you like: Games that are related to this game will be shown here.

##### Forum List Page

<img width="1436" alt="Screenshot 2023-12-29 at 22 22 58" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/21b0bb9d-1140-401f-84e1-1dfca74a0976">

All the forum post shown in the[forum page](https://game-lounge.com/forum) for the users including guest users.

- 1 -> Filter posts: Users can be filter to forum posts based on category.
- 2 -> Tag filter: Users can be filter to forum posts based on tags.
- 3 -> Sort type: Users can select the order of sort.
- 4 -> Like dislike buttons: Users can like or dislike the post.
- 5 -> Category of the post: Category of the post will be shown here.
- 6 -> Tags of the post: Tags of the post will be shown here.
- 7 -> Creator of the post : Creator of the post will be shown here. Users can visit the creator of the post on click.
- 8 -> Create post : Users can create new post.

<img width="599" alt="Screenshot 2023-12-29 at 22 38 24" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/80d601b0-47bd-4066-8d46-ddaf9a459659">

* Title input section: Title of the post should be entered here(must).
* Content: Content of the post should be entered here(must).
* Tags input section: Tags for the post can be entered from here(not must). Any string can be entered as tag.
* Category selection: Category of the post can be selected from here(must).
- 9 -> Report the post : Users can report the post.
- 10 -> Post card : The title, brief description, tags, category, post owner, date, comment number, will be shown here. Users can visit the post page clicking the title.

##### Forum post page

<img width="1437" alt="Screenshot 2023-12-29 at 22 45 10" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/e2375407-8be1-4253-8735-f68e48ee43b5">

- 1 -> Tags of the post: Tags of the post will be shown here.
- 2 -> Like dislike buttons: Users can like or dislike the post.
- 3 -> Report the post : Users can report the post.
- 4 -> Creator of the post : Creator of the post will be shown here. Users can visit the creator of the post on click.
- 5 -> Title of the post: Title of the post will be shown here.
- 6 -> Content of the post : Content of the post will be shown here.
- 7 -> Create comment: Users can create comment here.

<img width="1073" alt="Screenshot 2023-12-29 at 22 52 27" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/a52ad8d8-8426-4c6f-ac47-f56cdbe56681">

- 8 -> Comments section: The comments of the post will be shown here users can like, dislike or report the comment.

#####  LFG Page

<img width="1440" alt="Screenshot 2023-12-29 at 22 56 18" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/4ddca66a-cf50-42a6-8844-bdb68e13bff0">

All the groups shown in the[LFG page](https://game-lounge.com/groups) for the users including guest users.

- 1 -> Join: Users can join to the groups if it is not full.
- 2 -> Report the group : Users can report the post.
- 3 -> Create LFG: Users can create new LFG.

<img width="603" alt="Screenshot 2023-12-29 at 23 01 55" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/3a6a6b93-bf74-45fd-afbc-7fe4135af133">

<img width="600" alt="Screenshot 2023-12-29 at 23 02 08" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/9e5c660b-139b-4101-812a-7c6098db5ca3">

* Title input section: Title of the LFG should be entered here(must).
* Content: Content of the LFG should be entered here(must).
* Group Capacity: Group Capacity the LFG should be selected here(must).
* Language: Language of the LFG should be selected here(must).
* Platform: Platform of the LFG should be selected here(must).
* Tags input section: Tags for the LFG can be entered from here(not must). Any string can be entered as tag.
* Mic/cam required: Mic/cam required should be selected here if it is required(not must).

- 4 -> LFG post : Users can see the details of the created LFG posts.

#####  LFG Post Page

<img width="1440" alt="Screenshot 2023-12-29 at 23 06 40" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/06213993-9582-4be9-ba7f-83a2607da3f1">

- 1 -> Title of the LFG: Title of the LFG will be shown here.
- 2 -> Mic/cam: Requirement for mic/cam of the LFG will be shown here.
- 3 -> Language: Language of the LFG will be shown here.
- 4 -> Platform: Platform of the LFG will be shown here.
- 5 -> User number: Number of users / group capacity of the  LFG will be shown here.
- 6 -> Date: Creation date of the  LFG will be shown here.
- 7 -> Report: Users can report the LFG post here.
- 8 -> Join: Users can join to the groups if it is not full.
- 9 -> LFG owner: Owner of the LFG will be shown here. Users can visit the profile page of the owner onclick.

#####  Profile page

<img width="1440" alt="Screenshot 2023-12-29 at 23 13 37" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/cfbbeb03-c74d-4667-bd25-2817e047a40b">

- 1 -> Liked posts: Liked posts of the user will be shown here.
- 2 -> Liked comments: Liked comments of the user will be shown here.
- 3 -> Created posts: Created post of the user will be shown here.
- 4 -> About me: About me content of the user will be shown here.
- 5 -> Follow : Follower and following number of the users will be shown here.
- 6 -> Profile picture : Profile picture of the users will be shown here.
- 7 -> Username : Users can edit their profiles clicking this button.

<img width="598" alt="Screenshot 2023-12-29 at 23 19 00" src="https://github.com/bounswe/bounswe2023group6/assets/72529706/84b1c7f7-e848-46da-9d3c-ed19590a13cf">

* About me: User can update the information about her/himself here.
* Title: User can update the title of her/himself here.
* Company: User can update the information about the company he/she works here.
* Profile Image: User can update the profile picture here.

### System Manual
#### Mobile
To run a Flutter project and test it using an emulator, follow these steps:

##### Prerequisites:

1. **Install Flutter:**
   - Follow the instructions in the [official Flutter documentation](https://flutter.dev/docs/get-started/install) to download and install Flutter on your machine.

2. **Install Android Studio (for Android Emulator) or Xcode (for iOS Emulator):**
   - For Android development, you can use Android Studio, which includes the Android Emulator.
   - For iOS development, you need a Mac with Xcode installed.

3. **Set up Emulator:**
   - Open Android Studio and set up an Android Virtual Device (AVD) for the Android Emulator.
   - For iOS, open Xcode and set up an iOS Simulator.

##### Steps:

1. **Clone or Create a Flutter Project:**
   - Clone an existing Flutter project or create a new one using `flutter create project_name`.

2. **Open Project in VS Code or Android Studio:**
   - Open your Flutter project in your preferred code editor (e.g., Visual Studio Code, Android Studio).

3. **Check Flutter Devices:**
   - Open a terminal and run `flutter devices` to ensure that your emulator is detected. If not, start your emulator.

4. **Run the App:**
   - In the terminal, navigate to your project directory and run `flutter run`.

5. **Choose Target Device:**
   - When prompted, select your emulator from the list.

6. **Observe the App:**
   - The app should build and launch on the emulator.

##### For Android Emulator:

- **Run Directly from Android Studio:**
  - Open your Flutter project in Android Studio.
  - Click on the green play button ("Run") to build and run the app on the Android Emulator.

##### For iOS Emulator:

- **Run Directly from Xcode:**
  - Open the iOS project in Xcode (located in the `ios` directory of your Flutter project).
  - Click on the play button in Xcode to build and run the app on the iOS Simulator.

#### Web

##### Npm scripts

In the project directory, you can run:

###### `npm install`
Installs project dependencies.

###### `npm start`
Runs the app in development mode. Open [http://localhost:3000](http://localhost:3000) to view it in the browser. The page will reload if you make edits.

###### `npm run build`
Builds the app for production to the `build` folder. Optimizes the build for best performance.

###### `npm run eject`
**Note: this is a one-way operation.** Once you `eject`, you can't go back! This command removes the single build dependency from your project and copies all configuration files and dependencies (webpack, Babel, ESLint, etc) into your project.

###### `make precommit`
Runs 'npm run lint' and 'npm run format' to ensure code quality before committing changes.


##### Docker

- Docker Installation*: Ensure Docker is installed on your machine. Follow the official [Docker documentation](https://docs.docker.com/get-docker/) for installation instructions.

If you prefer to run the application in a Docker container, you can use the following Docker commands inside the frontend folder:

###### `docker build -t game-lounge .`

This command is used to create a Docker image and assign the name "game-lounge" to that image.

###### `docker run -p 3000:3000 -d game-lounge`

The command "docker run -p 3000:3000 -d game-lounge" starts a Docker container from the "game-lounge" Docker image, mapping traffic from your local machine's port 3000 to the container's port 3000, and runs the container in the background.

Please note that one needs to setup a simple .env file before running it as the the backend url is defined by it. It's enough to define REACT_APP_API_URL (either localhost:8080 or some remote url).



### Software Requirements Specification (SRS) 
- [Link to the SRS wiki page](https://github.com/bounswe/bounswe2023group6/wiki/Requirements) 

### Software design documents (using UML) 
* [Use Case Diagram](https://github.com/bounswe/bounswe2023group6/wiki/Use-Case-Diagrams)
* [Class Diagram](https://github.com/bounswe/bounswe2023group6/wiki/Class-Diagrams)
* [Sequence Diagrams](https://github.com/bounswe/bounswe2023group6/wiki/Sequence-Diagrams)
### User scenarios and mockups
* Scenarios
   - [Create Game Mobile](https://github.com/bounswe/bounswe2023group6/wiki/Scenario-about-Creating-Game-on-Mobile)
   - [Create Game Web](https://github.com/bounswe/bounswe2023group6/wiki/Create-Game-Scenario)
   - [Create Post Mobile](https://github.com/bounswe/bounswe2023group6/wiki/Create-Forum-Post-Scenario)
   - [Join Group Web](https://github.com/bounswe/bounswe2023group6/wiki/Scenario-About-Joining-a-Group)
* Mockups
   - [Web Mockups](https://github.com/bounswe/bounswe2023group6/wiki/Web-Mockups)
   - [Mobile Mockups](https://github.com/bounswe/bounswe2023group6/wiki/Mobile-Mockups)

### Research 
- [Link to the all research issues](https://github.com/bounswe/bounswe2023group6/issues?q=is%3Aissue+research+is%3Aclosed)
### Project plan 
- [Link to project plan page](https://github.com/orgs/bounswe/projects/22)
### Unit tests reports
Tests for annotation service:

<img width="1297" alt="image" src="https://github.com/bounswe/bounswe2023group6/assets/17512057/0fdf0182-fd59-4c06-95b3-e074346cf3a0">

Tests for backend:

<img width="1365" alt="image" src="https://github.com/bounswe/bounswe2023group6/assets/17512057/91d55be1-4ef0-48cf-83f2-a8c28acf2da8">

here is the test coverage stats for classes:

<img width="312" alt="image" src="https://github.com/bounswe/bounswe2023group6/assets/17512057/e368b86e-b26c-4e0e-a06c-e306a74a04b2">




## Software

The project currently deployed on https://game-lounge.com.

> The server hosting is provided by Digital Ocean.
> The domain name "game-lounge.com" is set up through Namecheap. 
> SSL encryption is established using Let's Encrypt and Certbot. 


* Frontend: https://game-lounge.com --> http://167.99.242.175:3000/ 
* Backend: https://game-lounge.com:9090/ --> http://167.99.242.175:8080/
* Database: http://167.99.242.175:5432/

* Annotation Backend: https://game-lounge.com:9091 --> http://167.99.242.175:8081/
* Annotation Database: http://167.99.242.175:5433/

* Pgadmin: http://167.99.242.175:4000/


### 3.1 Docker Building

We utilize GitHub Actions for building/pushing Docker images to DockerHub and deploying to remote server via ssh connection. To view the specific Docker build commands, you can explore the .github/workflows directory.

Backend:
In the app/backend folder, backend can be built by the following command:
* sudo docker build -t erkamkavak/gamelounge-backend .

Frontend:
In the app/frontend folder, frontend can be built by the following command:
* sudo docker build -t erkamkavak/gamelounge-frontend .

Annotation Backend:
In the app/annotation-service folder, annotation backend can be built by the following command:
* sudo docker build -t erkamkavak/gamelounge-annotation .

Builded docker images can be accessed by following DockerHub repository:
* https://hub.docker.com/u/erkamkavak

### 3.2 Docker Deployment

Database(Postgresql):
* sudo docker run --detach -p 5432:5432 -e POSTGRES_USER="postgres" -e POSTGRES_PASSWORD=<postgres_password> -e POSTGRES_DB="postgres" postgres

Annotation Database(Postgresql):
* sudo docker run --detach --name postgres_annotation -p 5433:5432 -e POSTGRES_USER="annotation" -e POSTGRES_PASSWORD=<annotation_postgres_password> -e POSTGRES_DB="annotation" postgres

Backend:
* sudo docker run --detach -p 8080:8080 -e SPRING_DATASOURCE_URL="jdbc:postgresql://167.99.242.175:5432/postgres" -e SPRING_DATASOURCE_USERNAME="postgres" -e SPRING_DATASOURCE_PASSWORD=<postgres_password>  -e MAIL_URL="http://167.99.242.175:8080/" -e CLOUD_AWS_S3_BUCKET="game-lounge-storage" -e CLOUD_AWS_CREDENTIALS_ACCESSKEY=<aws_access_key> -e CLOUD_AWS_CREDENTIALS_SECRETKEY=<aws_secret_key> erkamkavak/gamelounge-backend:52

Annotation Backend:
* sudo docker run --detach --name gamelounge-annotation -p 8081:8080 -e SPRING_DATASOURCE_URL="jdbc:postgresql://167.99.242.175:5433/annotation" -e SPRING_DATASOURCE_USERNAME="annotation" -e SPRING_DATASOURCE_PASSWORD=<annotation_postgres_password> erkamkavak/gamelounge-annotation:18

Frontend:
* sudo docker run --detach -p 3000:3000 -e REACT_APP_API_URL=https://game-lounge.com:9000 erkamkavak/gamelounge-frontend:47

Pgadmin:
* sudo docker run --name game_pgadmin -p 4000:4000 -e PGADMIN_DEFAULT_EMAIL=<pgadmin_default_email> -e PGADMIN_DEFAULT_PASSWORD=<pgadmin_default_password> -e PGADMIN_LISTEN_ADDRESS="0.0.0.0" -e PGADMIN_LISTEN_PORT="4000" -d dpage/pgadmin4

Note: The server at the address 167.99.242.175(game-lounge.com) hosts the app database, the annotation database, app backend, annotation backend and frontend deployments. To operate this on your local machine, you need to change the address from 167.99.242.175 to 'localhost'.

Additional Note: The deployment of the databases, backends, and frontend should follow a sequential order. The frontend requires the backend for its initial setup, just as the backend depends on the database for its initial configuration.

### 3.3 Mobile Application

In the app/mobile folder, application can be run via:

* flutter run


In order to create apk:

* flutter build apk


It creates a release apk in following folder:

build\app\outputs\flutter-apk\app-release.apk

# Individual Contributions Reports

- [Ahmet Kudu](https://github.com/bounswe/bounswe2023group6/wiki/Individual-Report-for-Final-Milestone-%E2%80%90-Ahmet-Kudu)
- [Beyzanur Bektan](https://github.com/bounswe/bounswe2023group6/wiki/Individual-Contribution-for-451-Milestone-3-Report-%E2%80%90-Beyzanur-Bektan)
- [Emre Sin](https://github.com/bounswe/bounswe2023group6/wiki/Emre-Sin-%E2%80%90-CMPE-451-%E2%80%90-Final-Individual-Contribution-Report)
- [Emre Türker](https://github.com/bounswe/bounswe2023group6/wiki/Emre-T%C3%BCrker%E2%80%90-CMPE-451-%E2%80%90-Final-Individual-Contribution-Report)
- [Erkam Kavak](https://github.com/bounswe/bounswe2023group6/wiki/Final-Milestone-Individual-Contribution-Report-%E2%80%90-Erkam-Kavak)
- [Halis Ayberk Erdem](https://github.com/bounswe/bounswe2023group6/wiki/Final-Individual-Contribution-Report-Halis-Ayberk-Erdem)
- [Hüseyin Çivi](https://github.com/bounswe/bounswe2023group6/wiki/CMPE-451-%E2%80%90-Final-Individual-Contribution-Report-%E2%80%90-Hüseyin-Çivi)
- [Ömer Huzeyfe Bahadıroğlu](https://github.com/bounswe/bounswe2023group6/wiki/CMPE-451-%E2%80%90-Final-Individual-Contribution-Report-%E2%80%90-%C3%96mer-Huzeyfe-Bahad%C4%B1ro%C4%9Flu)
- [Ömer Talip Akalın](https://github.com/bounswe/bounswe2023group6/wiki/Individual-Contribution-Report-3-%7C-Omer-Talip-Akalin-%7C-CMPE451)
- [Süleyman Melih Portakal](https://github.com/bounswe/bounswe2023group6/wiki/Individual-Report-for-Final-Milestone-%E2%80%90-Melih-Portakal)
- [Umut Demir](https://github.com/bounswe/bounswe2023group6/wiki/Individual-Contribution-for-451-Final-Milestone-Report-%E2%80%90-Umut-Demir)
- [Muhammet Mustafa Küçük](https://github.com/bounswe/bounswe2023group6/wiki/Individual-Report-for-Final-Milestone-%E2%80%90-Mustafa-K%C3%BC%C3%A7%C3%BCk)

