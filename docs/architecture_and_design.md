# Architecture and Design

In this section, the logical and physical architecture of the system are detailed, as well as description of the vertical prototype implemented.

Our project is divided into 3 main sections:

- The GUI, which the user will interact with when using the app
- A Controller with the business logic related to translating the users requests into API calls, as well as interfacing with the SIGARRA API
- And the SIGARRA API, as an external dependency, being the repository where the data is held.

A slight variation of the MVC pattern will be followed, with the Model being possibly added in future features, since this pattern gives us good separation of concerns, as well as good decoupling between all sections of the system.

### Logical architecture

This subsection intends to highlight the high-level logical structure of the code, using the following UML package diagram.

The following components exist:

- The Mobile UI encompasses what the user will see and interact with, in the mobile application.
- The Business Logic will handle requests from the client and translate them into requests to the API, and perform any other necessary procedure.
- Finally, in the External Services category lies the SIGARRA API, from where all the data will be fetched and requested.

![Logical Architecture of the System](./images/logical_architecture.png)

### Physical architecture

The goal of this subsection is to document the high-level physical structure of the software system (machines, connections, software components installed, and their dependencies) using UML deployment diagrams (Deployment View) or component diagrams (Implementation View), separate or integrated, showing the physical structure of the system.

It should describe also the technologies considered and justify the selections made. Examples of technologies relevant for uni4all are, for example, frameworks for mobile applications (such as Flutter).

Example of _UML deployment diagram_ showing a _deployment view_ of the Eletronic Ticketing System (please notice that, instead of software components, one should represent their physical/executable manifestations for deployment, called artifacts in UML; the diagram should be accompanied by a short description of each node and artifact):

### Vertical prototype

To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system.

In this subsection please describe which feature you have implemented, and how, together with a snapshot of the user interface, if applicable.

At this phase, instead of a complete user story, you can simply implement a feature that demonstrates thay you can use the technology, for example, show a screen with the app credits (name and authors).
