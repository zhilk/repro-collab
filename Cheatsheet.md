### Cheat Sheet: Collaborative Writing on GitHub

**GitHub**:  A kind of cloud storage built around the version control system *git*. 
Like Dropbox, it lets you store and share your project files online, but it’s specifically designed for collaboration and version control.
Git helps to track and manage the development of your files in a structured way, so you can recall earlier versions when needed. 
In this workshop, you only work online in GitHub. 
However, in typical collaborative projects, you'll also use git locally on your computer to track progress (through *commits*), and then upload (*push*) your current version to GitHub so others can access and contribute.

**Commit**: The central unit of version control in git. 
A commit is like a snapshot of your entire project at a certain point in time, saving all changes since the last commit. 
Git tracks these changes line by line, so you can compare different versions and see exactly what was added, removed, or modified. 
The sequence of commits forms the *commit history*, showing you who changed what and when, and allowing you to restore earlier versions if needed. 
To keep things organized, you should create a commit whenever you reach a (small) milestone and briefly describe your changes in a *commit message*. 

**Repository**: The central project folder in GitHub.
It stores all files, version history, and collaboration tools (like *branches*, *pull requests*, and *issues*).
In collaborative writing, the repository is like your shared document workspace. 

**Fork**: A personal copy of a repository, saved under your own GitHub account.
In typical collaborative writing projects, forking is usually *not* needed as collaborators can work directly within the shared repository (e.g., in their own branch).
In this workshop, you are asked to fork the repository for technical reasons, so you can work on your own copy instead of editing the original workshop repository directly.
The original repository you forked from is also called the *upstream repository*.

**Branch**: A parallel version of the project, created within the same repository.
A branch marks the current state of that version of your project and tracks its own set of changes. 
The *main branch* represents the current official version of the project.
Creating additional, separate branches allows collaborators to work on changes without affecting the main branch. 
After finishing work in a branch, collaborators can open a pull request to suggest adding their changes to the main branch.


**Pull Request (PR)**: A tool for requesting that changes from one branch are applied to another branch. 
Pull requests can be made within the same repository (e.g., from a separate branch into the main branch) or from a fork to a branch in the upstream repository.
In both cases, they request that your changes are “pulled” into the target branch.
A pull request lets others review your changes, give feedback, and approve them before *merging* (applying the proposed changes to the target branch). 
Once merged, both branches share the same version of the project again.

**Issue**: A place to track tasks, ideas, or bugs within a specific repository.
In collaborative writing, issues are the central way to coordinate work and communicate with your collaborators.
For example, you can easily discuss revisions or assign writing tasks using GitHub’s built-in features:

- Create checklists by typing - [ ] followed by your task
- Mention people with @username to notify them directly
- Reference issues or PRs using #issue-number or #PR-number

You can also automatically close an issue when you merge a pull request or make a commit by mentioning the issue number with a keyword like `fixes #23` or `closes #23` in your commit message or pull request description. This tells GitHub that your changes solve the problem discussed in that issue.

