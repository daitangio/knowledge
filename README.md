# knowledge
A knowledge daemon to collect ideas and auto organize them

    The muse visits during the act of creation, not before

Refer to https://daitangio.github.io/knowledge/ for motivation and goals

# Setup
Init the venv with

    python3 -m venv venv
    source venv/bin/activate
    pip install -r requirements.txt

# Core functions

Index a document with:

    ./index.sh import ....

Search with
    ./index.sh search searchterm

System is able to update data easily.
It als does englih stemming, so idnexintg this readme would result singluar or pluar searches like

    ./index.sh import README.md
    ./index.sh search muses
    ./index.sh search muses AND visit

## Search

### Basic FTS5 SQLITE experiment:
https://www.sqlitetutorial.net/sqlite-full-text-search/


https://www.google.com/search?q=django+search+module+with+sqlite3&client=safari&rls=en&sxsrf=ALiCzsZnWSo2evCBPJRnin_-D8V4aCzVuw%3A1653594704527&ei=UNqPYvfhH5uUxc8Preu18A4&ved=0ahUKEwj3ydyn-P33AhUbSvEDHa11De4Q4dUDCA0&oq=django+search+module+with+sqlite3&gs_lcp=Cgdnd3Mtd2l6EAxKBAhBGABKBAhGGABQAFgAYABoAHAAeACAAQCIAQCSAQCYAQA&sclient=gws-wiz

https://linuxhint.com/build-a-basic-search-for-a-django/
https://django-haystack.readthedocs.io/en/v2.4.1/toc.html


# API Access
Valutare FastAPI o https://www.django-rest-framework.org ?