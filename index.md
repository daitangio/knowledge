## About Knwoledge (STILL DRAFT)

> The muse visits during the act of creation, not before

## Knwoledge Goals




### Needs and past experience
Primary need is to collect and auto organize (at least "facet") news I read on Internet.

My primary source is  [Hacker News](https://news.ycombinator.com) but I collect data from other souces too.
I do not use bookmarks: I tend to publish interesting articles on twitter, or sent it to a special "todo" mailbox for further reading.
I publish only things I think worth to, and I send to my todo-inbox only things I plan to use on my projects.
I use "Read Later" iPhone functionality when I have a lot of mid-priority stuff to read.
Eventually when an idea is ready for publishing, I write an article on my [Blog](https://gioorgi.com).

Some Ideas can be private, but as a primary goal should be the abiity to prepare a "Idea ReCap" with all the information is presented to be able to write an article on it.

1. Search is a crucial need.
2. Aggregation from diferent sources seems unaivodable
3. A lot of "bookmark" application tried in the past, they seems the wrong direction
4. A long browser history seems a good source for the article basic link collection

### Past experiments

A Wordpress site with the folloing plugin offered a good starting point:

- dw-question-answer to create a StackOverflow-like tassonomy
- elasticpress to index site via elastic search
- wpematico to aggressivly collect rss information (can be a bit dangerous for intellectual property)
- auto-upload-images to collect external images, schematics
- buddypress /buddypress-docs for optional social engage
- Simple Twenty Twenty theme with a fixed page showing:
  - Calendar posts
  - Categories

Other fetaure included:
- Able to import from other wordpress site
- Stable XML-RPC API to quickly enable thrid parts post processing


# Candidates

- Wordpress +Elastic Search + Jupiter
  - Pro
    - Nice look
    - Resouce consumption medium (1.2GB RAM)
    - XML API
  - Cons
    - Plugin support lacks
    - Heavy MySQL DB
    - Attack surface not small
- GitLab
  - Pro
    - Can set up an Editorial boards based on Issues
    - Can Manage wikis via simple github-rendered projects
    - Code-centric
  - Cons
    - Memory consumption heavy (4GB RAM)
    - Less nice themes
    - Heavy Database
- Custom Python aggregator
  - Pro
    - Very small resouce consumption
    - Portable sqlite3 database


