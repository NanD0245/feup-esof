# Requirements

In this section, functional and non-functional requirements for our product are described.

## Use case model

Our application use cases reflect the tasks the user needs to be able to accomplish using the system, namely to authenticate himself and consult course information and material.

<p align="center" justify="center" >
  <img src="images/use_cases.png"/>
</p>

    |                                    |                                                                                                                                                                                                                                                                                                                     |
    | ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
    | _Name_                             | Login                                                                                                                                                                                                                                                                                                               |
    | _Actor_                            | Student                                                                                                                                                                                                                                                                                                             |
    | _Description_                      | The Student authenticates into the system, entering his SIGARRA credentials (student number and password), in order to access the UNI features                                                                                                                                                                      |
    | _Preconditions_                    | - The Student is registered into SIGARRA                                                                                                                                                                                                                                                                            |
    | _Postconditions_                   | - The Student enters the app, having access to it's full features.                                                                                                                                                                                                                                                  |
    | _Normal flow_                      | 1. The Student accesses the app.<br> 2. The system shows the Login screen <br> 3. The Student enters his SIGARRA credentials <br> 4. If wanted, the Student may choose to keep his session on.<br> 5. The system verifies the credentials.<br> 6. If they match, the system redirects the Student to the main page. |
    | _Alternative flows and exceptions_ | 1. [Error entering credentials] If, in step 5 of the normal flow the system detects flaws, the system remains in the login page, and highlights the problem.                                                                                                                                                        |

    |                                    |                                                                                                                                                                                             |
    | ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
    | _Name_                             | Logout                                                                                                                                                                                      |
    | _Actor_                            | Authenticated Student                                                                                                                                                                       |
    | _Description_                      | The Student logs out of the system, if he decides his session in UNI should be terminated                                                                                                   |
    | _Preconditions_                    | - The Student is registered into SIGARRA <br> - The Student is authenticated in the UNI app                                                                                                 |
    | _Postconditions_                   | - The Student leaves the app, no longer having access to it's full features.                                                                                                                |
    | _Normal flow_                      | 1. The Student accesses the settings section.<br> 2. The system shows the Settings screen <br> 3. The Student presses the logout button <br> 4. The system logs the user out of the system. |
    | _Alternative flows and exceptions_ | There are no foreseeable exceptions to this use case                                                                                                                                        |

### User stories

The user stories should be created as GitHub issues. Therefore, this section will _not_ exist in your report, it is here only to explain how you should describe the requirements of the product as **user stories**.

A user story is a description of desired functionality told from the perspective of the user or customer. A starting template for the description of a user story is

_As a < user role >, I want < goal > so that < reason >._

User stories should be created and described as [Issues](https://github.com/LEIC-ES-2021-22/templates/issues) in GitHub with the label "user story". See how to in the video [Creating a Product Backlog of User Stories for Agile Development using GitHub](https://www.youtube.com/watch?v=m8ZxTHSKSKE).

You should name the issue with the text of the user story, and, in the "comments" field, add any relevant notes, the image(s) of the user interface mockup(s) (see below) and the acceptance test scenarios (see below).

**INVEST in good user stories**.
You may add more details after, but the shorter and complete, the better. In order to decide if the user story is good, please follow the [INVEST guidelines](https://xp123.com/articles/invest-in-good-stories-and-smart-tasks/).

**User interface mockups**.
After the user story text, you should add a draft of the corresponding user interfaces, a simple mockup or draft, if applicable.

**Acceptance tests**.
For each user story you should write also the acceptance tests (textually in [Gherkin](https://cucumber.io/docs/gherkin/reference/)), i.e., a description of scenarios (situations) that will help to confirm that the system satisfies the requirements addressed by the user story.

**Value and effort**.
At the end, it is good to add a rough indication of the value of the user story to the customers (e.g. [MoSCoW](https://en.wikipedia.org/wiki/MoSCoW_method) method) and the team should add an estimation of the effort to implement it, for example, using t-shirt sizes (XS, S, M, L, XL).

### Domain model

To better understand the context of the software system, it is very useful to have a simple UML class diagram with all the key concepts (names, attributes) and relationships involved of the problem domain addressed by your module.
Also provide a short textual description of each class.

Example:

 <p align="center" justify="center">
  <img src="https://github.com/LEIC-ES-2021-22/templates/blob/main/images/DomainModel.png"/>
</p>
