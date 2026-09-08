# Feature Planning Document: Submissions Triage

## 1. Feature Overview

### Submission List View
- a table-like list view of all the submissions with each row showing the most relevant information.
- each rows can be tapped to expand to show a more detailed view through a separate screen.

### Status Filter / Search
- group of components near the application bar containing a search bar and various drop downs and buttons to facilitate filtering and searching

### Submission Detail View
- a separate screen that shows the detailed view of a specific submission
- contains a button to mark a submission as reviewed

### Mark as Reviewed / Update Status
- a button inside the submission detail page to change its status to "reviewed"

### User / customer perspective
<!-- What user problem does this solve? -->

This app problem allows the user to read relevant information at a glance. Users can search and filter for the data they need. With the help of input normalization, missing and malformed data are handled and consolidated to readable values. 

### Developer perspective
<!-- How do you plan to implement it?
Why is this approach reasonable for the timebox? -->

After planning, the focus for the implementation will be the normalization of the inputs from the JSON source. Once the data is properly loaded and varying inputs are consolidated to standard values, operations will just boil down to array manipulation and proper visualization of the data, making the implementation easier.

### QA perspective
<!-- What could go wrong?
What should be tested? -->

Search functionalities are always complex and specific edge cases or user interaction may break the list of results. 

---

## 2. User Stories

Write 2 to 4 user stories. Format:
<!-- - As a <type of user>, I want to <action>, so that <benefit>. -->

- As an admin, I want to view a list of all form submissions, so I can manage things at a glance.

Acceptable Criteria:
    - all submissions from the source are displayed in a scrollable list
    - each row shows the submitter's name, status, and service type
    - missing and malformed information are normalized and falls back to default values

As an admin, I want to search for specific keywords to narrow down the list of submission

Acceptable Criteria
    - a search bar allows filtering by name, email, phone, status, or service
    - results update when the search is confirmed
    - clearing the search restores the full list
    - search is case-insensitive

As an admin, I want to view the full details of a submission, so that I can review all relevant information before taking action

Acceptable Criteria
    - tapping a row navigates to a details screen
    - all relevant fields are displayed 
    - tapping a button marks the submission as complete

For each user story, include 2 to 4 acceptance criteria.

---

## 3. Requirements Review

### Functional requirements

Create an application containing an admin tables-like component that shows a table of submissions, containing important information at a glance. Users can search for specific data, sort, and filter results. Furthermore, users can also open a separate screen for each submissions. Lastly, submissions can be marked as "reviewed" with a button click, changing its status accordingly. 

### Non-functional requirements
<!-- Usability, performance, accessibility, maintainability,
reliability, and security if relevant. -->

**Usability & Accessibility**
As an admin table-like component, there will be compromises to usability and accessibility to allow more information to be visible at a glance. For instance, the app bar will remain minimal and at the top instead of being tall or at the bottom. It makes this component less reachable with one hand operation but it allows more rows to be visible. The application will utilize google font along with material 3 which ensures consistent typography and color contrast

**Performance**
Performance should be good as the app is not bottlenecked by API calls. Data is loaded from a static JSON file, making load times minimal. 

**Reliability**
The app handles malformed and missing data through null safety, default values, and input normalization in the data model. 

**Maintainability**
The app follows a defined data model. Constraints and business rules can be adjusted in one place without cascading across the codebase. 

### Requirements I would clarify or challenge
<!-- List anything unclear, risky, unnecessary, or worth changing. -->

- Does it have to be strictly a table implementation considering its limitations on a mobile screen?
---


## 4. Technical Plan

### Technology stack

- IDE: VSCode
- Framework:Flutter 3.41.9 with Dart 3.11.5
- State Management: Flutter Riverpod 3.3.2
- Packages:
    - Google Font


### Data model / data handling
<!-- The models you decode into, and how you handle missing,
inconsistent, or malformed records (normalization, defaults, validation). -->
```plaintext
enum Status {
    newSubmission,                    - catches strings that contain "new"
    open,                   - catches strings that contain "open"
    processing,             - catches strings that contain "in" && "review", "pending", empty, and other strings
    reviewed,               - catches strings that contain "reviewed", "finish"
    closed                  - catches strings that contain "close"
}

enum Service {
    web,                    - catches strings that contain "web"
    mobile,                 - catches strings that contain "mobile"
    other                   - default value, catches all other string or empty values
}

TableItem:                  - artifact of an unimplemented feature. contains a submission object
    Submission data
    bool isExpanded

Submissions:
    String? id              - accepts both String and int values
    String? name
    String? email
    String? phone
    Service service         - default: Service.other
    Status status           - default: Status.processing
    String? message
    DateTime? submittedAt   - format: "dd MMMM yyyy"
    String? formVersion
    String? internalNotes

```
### Architecture / components / modules
<!-- Views, ViewModels, Models, Services, networking / loading layer. -->

```plaintext
lib/
  ├── data/                 - submissions data
  ├── models/               - data classes
  ├── providers/            - Riverpod providers and notifiers
  ├── utils/                - external and helper functions
  └── ui/                   - screens and widgets
```

### State management / flow
<!-- Loading, error, empty, search / filter, selected item, reviewed state. -->

Loading
    - data is being fetched
    - show circular loading indicator
Error
    - Something went wrong, wrong user input
    - show error snackbar
Empty
    - no data returned
    - show empty state UI
Search/Filter
    - user is searching and filtering data
    - provider filters the result
Selected item
    - user tapped on a row
    - row expands to provide more info, or open Submission screen
Reviewed State
    - user mark submission as done
    - update Submission.status to Status.reviewed

### Implementation steps

1. Initialize project files
2. Setup PLANNING.md
3. Design data model
4. Setup Riverpod providers and state notifiers
5. Implement null or malformed data handling
6. Create initial screens
7. Create reusable widgets
8. Refine screens and widgets
9. Implement search and filtering
10. Testing

---

## 5. Testing Plan

<!-- Manual tests are required. Automated tests are optional. -->

| Test Case | Steps | Expected Result | Tested? |
|---|---|---|---|
|  |  |  | Yes / No |

---

## 6. Timebox Plan

- 60 to 90 minutes: planning document
- 3.5 to 5 hours: core implementation
- 30 minutes: testing and edge cases (especially the messy data)
- 30 minutes: README, cleanup, and recording

## 7. Risks, Trade-offs, and Follow-up

<!-- List important risks, shortcuts, or trade-offs. Also answer: -->

#### What did you intentionally skip?
- most accessibility suggestions as the development time can balloon when taking these into suggestion. 
- search filter due to time constraints
#### What would you improve with more time?
- UX and accessibility

#### What would you ask the client before building this for production?
- what's your expected development time frame and budget?
- Do you have an existing application/system where this app can be integrated into? 
- What information do you want to see at a glance?
- Do you need create, update, and delete functionalities for this app?

#### If you used AI tools, how did you use them and how did you validate output?
- Copilot and Claude are used during the implementation. These tools are used for basic searching, debugging, template generation, and automation of repetitive tasks. Outputs are validated through testing and browsing source documentation. 

- external functions like the String toPascalCase due to time constraints

---

## 8. Iterations
```plaintext
| Change                                        | Reason                                              |
| Enclose Submission Model in Table Item Model  | To make UI manipulation for the expanding row easier|
| Give up on the expandable row                 | Unnecessary, not enough time                        |
```
<!-- If there were no major changes, write: N/A, no major plan changes. -->
