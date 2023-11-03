### 1. Summary of the project status and changes that are planned for moving forward

At the project's beginning, our client's insights led to an exciting evolution. Responding to their request for a domain-specific feature, we introduced a captivating game page, offering users the opportunity to engage and provide valuable inputs. This page opens up a world of possibilities, enabling us to generate insightful recommendations based on user inputs. We meticulously crafted requirements and UML designs to facilitate these enhancements. As is customary in project development, we kicked off with the foundational aspects, registration, and authorization (sign up, sign in, and sign out). While our initial milestone requirements may have seemed modest, we discovered that the technologies we've chosen for development and deployment are not only meeting our current needs but are also poised to drive future innovations. Moreover, we are committed to harnessing user feedback to create an alluring, user-centric UI/UX design that will elevate the project's visual appeal in the forthcoming phases.


### 2. Summary of the Customer Feedback and Reflections

- Icons and Logo Consistency: There is a consensus on the need for unique icons for each game and addressing issues related to consistent logo usage.
- Rating System: It's suggested that the rating system should be reviewed and potentially redesigned to align with user expectations.
- User Interaction and Communication: The importance of facilitating user interaction, especially post-group formation, has been highlighted, along with the need to clarify or redesign communication systems for LFG users.
- Homepage and User Experience: Enhancing the homepage with detailed game information, potentially including specific post dates and game release dates, is recommended. Additionally, there is a call to provide more content on mock game pages and improve the overall user interface.
- Competitive Advantage: Defining and articulating the platform's competitive edge is emphasized, with an additional focus on flexibility as a competitive strategy.
- Character Recommendation and User Profiles: Exploring a character recommendation system based on character similarities is suggested, potentially tied to user profiles and avatars.
- Games You May Like Section: The need to review and refine the algorithm and presentation of the "Games You May Like" section to enhance user recommendations is highlighted.
- Optional Photo Upload: It's important to clarify that photo upload during registration is optional to avoid potential barriers or privacy concerns for users.



### 3. List and status of deliverables.

|**Deliverable**|**Status**|
|---|---|
[Software Requirements Specification](https://github.com/bounswe/bounswe2023group6/wiki/Requirements)|Completed|
[Class Diagram](https://github.com/bounswe/bounswe2023group6/wiki/Class-Diagrams)|Completed|
[Use Case Diagram](https://github.com/bounswe/bounswe2023group6/wiki/Use-Case-Diagrams)|Completed|
[Sequence Diagrams](https://github.com/bounswe/bounswe2023group6/wiki/Sequence-Diagrams)|Completed|
[Scenario 1](https://github.com/bounswe/bounswe2023group6/wiki/Create-Forum-Post-Scenario)|Completed|
[Scenario 2](https://github.com/bounswe/bounswe2023group6/wiki/Scenario-About-Joining-a-Group)|Completed|
[Project Plan](https://github.com/bounswe/bounswe2023group6/wiki/Project-Plan)|Completed|
[RAM](https://github.com/bounswe/bounswe2023group6/wiki/Responsibility-Assignment-Matrix-(RAM))|Completed|
[Software](http://game-lounge.com/)|Completed|


### 4. Evaluation of the status of deliverables
- **Software Requirements Specifications:** During first weeks of the semester there was an incertainty on what to include and exclude in the project such as the game pages, character pages etc. Also there was some uncertainty about the recommendation algorithm. One of those uncertainties was on what aspects of the posts-games to make recommendations to users. We spent quite some time on alicitation process, and negotiated with the product owner. We made clear on what aspects to make suggestions however the algorithm is to be determined. Since algorithm is not a part of the requirements, we can safely assume that the specifications are altered in accordance with the decisions made on the aforementioned issues and they are complete.
 
- **Software Design(UML Diagrams):** Since there were not that much of a change on the general project structure, we needed minor changes in the UML designs. After deciding on which concepts to include and exclude, we quickly worked over the class diagram. Class diagrams describe the general relation among the numerous entities that are planned to be present in the project, and it can be considered to be the backbone for the backend architecture. That’s why we reviewed it. Game, character classes were added and event class was discarded. The second diagram is the usecase diagram. Use case diagrams are means to describe the functionalities that are offered to the all actors of the system, i.e. administrators and different types of users. Respective changes are made to the usecase diagram as well. Lastly the sequence diagram. Since not much of the functionalities of the system were covered in the first milestone, we did not worked exclusively on sequence diagrams. We completed them after the first two diagrams were rafinated enough. All in all it is also safe to say that UML diagrams are complete from the current state of the project.
 
- **Scenarios and Mockups:** Mockups and scenarios are a great means to describe the intentions of a project to the customers and possible future users. We believe that the mockups and scenarios we prepared during the last year’s course were reflecting the intentions of us on the future of the project. Again, the major changes required were related to the game and character pages. Those requirements were also met by our team, and the respective changes were added to the mockups and scenarios.
 
- **Project Plan:** Project plan is an integral part of the process of effectively managing a project. We believe in the potential advantages of having one is crucial to a successful development environment. To this end, we made sure that our plan encompassed all the possible tasks. We were not only able to complete all the predetermined tasks, but also we successfully completed the unforeseen tasks as well.
 
- **RAM:** RAMs are crucial in that they allow the team members to see who contributed to which tasks, and enable them to load balance the tasks on the individuals. Therefore, we paid special attention to having a proper responsibility assignment matrix.
 
- **Individual Contribution Reports:** Although the RAM shows who contributed on building which parts of the project, it could be quite misleading. Some tasks might have required more effort than others, which cannot be concluded just by looking at the RAM, but additional information is required to assess the effort of individuals. ICRs serve exactly this purpose.
 
- **Software:** We were asked to build two applications one for mobile and the other for the web. Therefore we divided into three equal teams: backend, mobile, and frontend to meet the expactations properly. We believe that our teams successfully met the requirements of the first milestone’s targets. Our backend team started the development first and exposed some endpoints for the other teams to develop their ends on them. After building the basis, all teams made some adjustments in their end for better integration among the teams. Finally, the application is successfully deployed and can be accessed through the [link]( http://game-lounge.com/home).

### 5. Evaluation of tools and processes we used to manage our project.
- **Backend**
  - Communication: Discord
Discord was an essential tool for our team's communication, giving us the ability to talk, video call, and message each other for both scheduled meetings and quick chats. We could make separate channels for different topics, which helped us stay organized. Since Discord doesn't have built-in tools for managing our projects, we added some extra tools to make everything work together. But overall, Discord was easy for everyone to use no matter what type of computer or phone they had.

  - IDE: IntelliJ IDEA
IntelliJ IDEA was our chosen software for writing and organizing our code, and it was particularly good because it had special features for Kotlin and Spring Boot, which are the main technologies we used. It could automatically complete parts of code for us and help us change large parts of it easily when needed. It also kept track of changes in our code. Although anyone could use the basic version for free, some of us used the paid version which had more helpful features for working with databases and code, but we had to consider the extra cost and effort to learn these features.

  - Database: PostgreSQL
PostgreSQL was very reliable for storing and handling our project's data, even when we had to do complicated things with it. It came with a lot of documentation, which helped us a lot, and there were many people using it who could help us when we got stuck. To really take advantage of everything PostgreSQL could do, we had to know a lot about databases, but it was worth it because it made our project's data management strong and able to grow.

  - Programming Language & Framework: Kotlin and Spring
Kotlin and Spring worked really well together for building the parts of our project that run on the server. Kotlin lets us write code that's easy to understand and shorter, which saves time. Spring has a lot of tools that do different things we needed, like making sure our app is secure and handles data properly. Even though it can take some time to learn how to set everything up with Spring, using Kotlin made it easier. So, they made a great combination for our project.

  - Database Tool: DBeaver
DBeaver was the tool we chose for working with our databases. It works with many different kinds of databases, which was perfect for us. The program's design made it simple to see our data, make changes, and do tests. It has a lot of different tools to use, and sometimes it was a bit too much, but it was really useful for managing our databases day to day.

  - Project Management: GitHub Projects
GitHub Projects helped us keep an eye on our work and organize our coding tasks. It's part of GitHub, so it worked well with the code we were already writing there. We used it like a board to move tasks around and see what we all were working on. It's not as full-featured as some other project management tools, but it was easy to use and helped us a lot.

- **Frontend**

  - Visual Studio Code (VSCode):
We utilized Visual Studio Code as our code editor for our project. VSCode proved to be a good choice due to its extensive support for various programming languages through extensions. It not only helped us write code efficiently but also provided error messages and warnings for syntax issues, allowing us to make our developments faster and safer. Additionally, being familiar with VSCode from previous experiences made it a speedy and convenient choice for us. Its features, such as debugging, syntax highlighting, code completion, and embedded Git, played a crucial role in our development process. The Git integration made it simple for us to maintain version control by allowing us to easily commit and push our code to our repository.

  - React:
React is not a framework but a JavaScript library, making it straightforward to learn and work with. This simplicity was particularly advantageous for our team, as we had unexperienced React developers. The library's approach based on UI components promotes reusability, allowing us to efficiently use components across different parts of our application. Another reason is its extensive popularity and strong community support, making it easier to learn and troubleshoot issues. React also improves the rendering efficiency using the concept of Virtual DOM, which reduces unnecessary updates. In addition to React itself, we integrated ESLint for code linting and Tailwind CSS for styling. ESLint helped maintain code quality by identifying and suggesting corrections for potential issues in our code, while Tailwind CSS streamlined the styling process.

- **Mobil**
  
  - Dart: This language is employed to develop high-performance mobile and web applications. It adheres to an object-oriented, class-based paradigm, featuring garbage collection and a syntax reminiscent of C. It offers the flexibility to compile into machine code, JavaScript, or WebAssembly. Notable language features include support for interfaces, mixins, abstract classes, reified generics, and type inference. It serves as the foundational programming language for the Flutter framework.

  - Flutter: This is a versatile UI toolkit designed for cross-platform development, facilitating code reuse across various operating systems like iOS and Android. It provides the capability for applications to directly interact with underlying platform services. The primary objective is to empower developers to create high-performance applications that offer a native experience on different platforms, accommodating platform-specific nuances while maximizing shared code. During the development process, Flutter apps operate in a virtual machine (VM) that enables a stateful hot reload, allowing for rapid changes without requiring a complete recompilation.
   
  - Android Emulators: These are software tools that generate virtual Android devices complete with both software and hardware components on your computing device. They serve as a critical resource for testing Android applications and are utilized to observe the output of our Flutter applications.
   
- **CI/CD**
  
  - Digital Ocean: We selected Digital Ocean as our cloud service provider for our project, configuring a Ubuntu instance with 2 CPUs and 2 GB of RAM to efficiently run our Docker images. This decision was influenced by the limited resources in AWS's free tier, offering just a t2.micro instance with 1 CPU and 1 GB of RAM, as well as our access to $200 in free credits through the GitHub Global Campus program, making Digital Ocean a more cost-effective choice. Similar to AWS, Digital Ocean offers scalable computing capacity and simplifies networking, security, and storage configurations, all while eliminating the need for upfront hardware investments, allowing us to expedite application development and deployment.

  - Docker: It is an open platform, is designed to streamline the development, deployment, and execution of applications by allowing you to decouple your applications from the underlying infrastructure, facilitating rapid software delivery. Docker offers the capability to encapsulate and execute applications within isolated environments known as containers. In our project, we utilized three containers: one for the frontend, one for the backend, and one for the PostgreSQL database. Additionally, we configured environment variables for each container to meet specific requirements.

  - GitHub Actions: Workflows have been set up for both the frontend and backend with YAML configuration files to build and push Docker images to DockerHub. These workflows can be manually triggered through the GitHub Actions tab, allowing for monitoring of the status of each action step. This setup plays a crucial role in ensuring continuous integration. 

### 6. The Requirements Addressed in Milestone 1
- 1.1.1.1 Guests shall provide their full name, a valid username, an unregistered, a valid password to sign up.
- 1.1.1.3 Users shall be able to login and logout to platform.
- 1.1.1.4 Users shall be able to reset, and change their passwords.
- 2.1.1 The platform shall use HTTPS protocol.
- 2.1.3 All sensitive user data, such as passwords, shall be encrypted using a salted hashing algorithm(such as SHA-256).
- 2.3.1 Language of the platform shall be English.

### 7. Individual Contribution Reports
- [Ahmet Kudu](https://github.com/bounswe/bounswe2023group6/wiki/Individual-Contribution-for-451-Milestone-1-Report-%E2%80%90-Ahmet-Kudu)
- [Beyzanur Bektan](https://github.com/bounswe/bounswe2023group6/wiki/CMPE451-%E2%80%90-Individual-Contribution-Report-1-%E2%80%90-Beyzanur-Bektan)
- [Emre Sin]
- [Emre Türker](https://github.com/bounswe/bounswe2023group6/wiki/Emre-T%C3%BCrker-%7C-Individual-Contribution-Page-%E2%80%90-Milestone-1)
- [Erkam Kavak]
- [Halis Ayberk Erdem](https://github.com/bounswe/bounswe2023group6/wiki/Halis-Ayberk-Erdem-%7C-Individual-Contribution-Page-%E2%80%90-Milestone-1)
- [Hüseyin Çivi]
- [Ömer Huzeyfe Bahadıroğlu](https://github.com/bounswe/bounswe2023group6/wiki/CMPE451-%E2%80%90-Individual-Contribution-Report-1-%E2%80%90-%C3%96mer-Bahad%C4%B1ro%C4%9Flu)
- [Ömer Talip Akalın](https://github.com/bounswe/bounswe2023group6/wiki/Individual-Contribution-Report-1-%7C-Omer-Talip-Akalin-%7C-CMPE451)
- [Süleyman Melih Portakal]
- [Umut Demir]
- [Muhammet Mustafa Küçük](https://github.com/bounswe/bounswe2023group6/wiki/Muhammet-Mustafa-K%C3%BC%C3%A7%C3%BCk-%7C-Individual-Contribution-Page-%E2%80%90-Milestone-1)

